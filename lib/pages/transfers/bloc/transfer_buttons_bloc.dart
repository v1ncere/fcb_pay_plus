import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'transfer_buttons_event.dart';
part 'transfer_buttons_state.dart';

class TransferButtonsBloc extends Bloc<TransferButtonsEvent, TransferButtonsState> {
  TransferButtonsBloc() : super(const TransferButtonsState(status: Status.loading)) {
    on<TransferButtonUserIdFetched>(_onTransferButtonUserIdFetched);
    on<TransferButtonsFetched>(_onTransferButtonsFetched);
    on<TransferButtonsRefreshed>(_onTransferButtonsRefreshed);
  }

  Future<void> _onTransferButtonUserIdFetched(TransferButtonUserIdFetched event, Emitter<TransferButtonsState> emit) async {
    emit(state.copyWith(userStatus: Status.loading));
    try {
      final authUser = await Amplify.Auth.getCurrentUser();
      emit(state.copyWith(userStatus: Status.success, uid: authUser.userId));
    } on AuthException catch (e) {
      emit(state.copyWith(userStatus: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(userStatus: Status.failure, message: TextString.error));
    }
  }

  Future<void> _onTransferButtonsFetched(TransferButtonsFetched event, Emitter<TransferButtonsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final request = ModelQueries.list(Button.classType, where: Button.TYPE.eq('transfer'));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;

      if (items != null && !response.hasErrors) {
        final buttons = items.whereType<Button>().toList();
        
        if (buttons.isNotEmpty) {
          buttons.sort((a, b) => a.position!.compareTo(b.position!));
          emit(state.copyWith(status: Status.success, buttons: buttons));
        } else {
          emit(state.copyWith(status: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }

  void _onTransferButtonsRefreshed(TransferButtonsRefreshed event, Emitter<TransferButtonsState> emit) {
    add(TransferButtonsFetched());
  }
}
