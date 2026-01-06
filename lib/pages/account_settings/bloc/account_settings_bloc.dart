import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'account_settings_event.dart';
part 'account_settings_state.dart';

class AccountSettingsBloc extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  final SqfliteRepositories _sqfliteRepositories;
  AccountSettingsBloc({
    required SqfliteRepositories sqfliteRepositories
  }) : _sqfliteRepositories = sqfliteRepositories,
        super(const AccountSettingsState()) {
          on<AccountEventPressed>(_onAccountEventPressed);
        }

  Future<void> _onAccountEventPressed(AccountEventPressed event, Emitter<AccountSettingsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      switch (event.method) {
        case Settings.delete:
          final request =  ModelMutations.delete(event.account);
          final response = await Amplify.API.mutate(request: request).response;
          
          if (!response.hasErrors) {
            await _sqfliteRepositories.deleteAccount('${event.account.accountType}');
            emit(state.copyWith(status: Status.success));
          } else {
            emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
          }
          break;
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
