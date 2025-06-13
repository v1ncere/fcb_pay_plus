import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'payment_buttons_event.dart';
part 'payment_buttons_state.dart';

class PaymentButtonsBloc extends Bloc<PaymentButtonsEvent, PaymentButtonsState> {
  PaymentButtonsBloc() : super(PaymentButtonsState()) {
    on<PaymentButtonsUserIdFetched>(_onPaymentButtonsUserIdFetched);
    on<PaymentButtonsFetched>(_onPaymentButtonsFetched);
    on<PaymentButtonsRefreshed>(_onPaymentButtonsRefreshed);
  }

  Future<void> _onPaymentButtonsUserIdFetched(PaymentButtonsUserIdFetched event, Emitter<PaymentButtonsState> emit) async {
    emit(state.copyWith(userStatus: Status.initial));
    try {
      final authUser = await Amplify.Auth.getCurrentUser();
      emit(state.copyWith(userStatus: Status.success, uid: authUser.userId));
    } on AuthException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }

  Future<void> _onPaymentButtonsFetched(PaymentButtonsFetched event, Emitter<PaymentButtonsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final request = ModelQueries.list(Button.classType, where: Button.TYPE.eq('payment'));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;

      if (items != null && !response.hasErrors) {
        final buttonList = items.whereType<Button>().toList();
        
        if (buttonList.isNotEmpty) {
          buttonList.sort((a, b) => a.position!.compareTo(b.position!));
          emit(state.copyWith(status: Status.success, buttons: buttonList));
        } else {
          emit(state.copyWith(status: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }

  void _onPaymentButtonsRefreshed(PaymentButtonsRefreshed event, Emitter<PaymentButtonsState> emit) {
    add(PaymentButtonsFetched());
  }
}
