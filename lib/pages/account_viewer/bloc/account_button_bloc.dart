import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'account_button_event.dart';
part 'account_button_state.dart';

final emptyAccountButton = AccountButton(type: '');

class AccountButtonBloc extends Bloc<AccountButtonEvent, AccountButtonState> {
  AccountButtonBloc() : super(const AccountButtonState(status: Status.loading)) {
    on<ButtonsFetched>(_onButtonsFetched);
  }

  void _onButtonsFetched(ButtonsFetched event, Emitter<AccountButtonState> emit) async {
    try {
      final request = ModelQueries.get<AccountButton>(AccountButton.classType, AccountButtonModelIdentifier(type: event.type)); // account type i.e.(wlt, plc, psa, ppr)
      final response = await Amplify.API.query(request: request).response;
      final data = response.data;
      
      if (data != null && !response.hasErrors) {
        
        if (data != emptyAccountButton) {
          final newRequest = ModelQueries.list<Button>(Button.classType, where: Button.ACCOUNTBUTTON.eq(data.type));
          final newResponse = await Amplify.API.query(request: newRequest).response;
          final newItems = newResponse.data?.items;
          
          if (newItems != null && !newResponse.hasErrors) {
            final buttons = newItems.whereType<Button>().toList();
            emit(
              buttons.isNotEmpty
              ? state.copyWith(status: Status.success, buttons: buttons)
              : state.copyWith(status: Status.failure, message: TextString.empty)
            );
          } else {
            emit(state.copyWith(status: Status.failure, message: newResponse.errors.first.message));
          }
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
}