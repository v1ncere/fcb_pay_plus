import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:fcb_pay_plus/models/ModelProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../utils/utils.dart';

part 'account_settings_event.dart';
part 'account_settings_state.dart';

class AccountSettingsBloc extends Bloc<AccountSettingsEvent, AccountSettingsState> {
  AccountSettingsBloc({
    required HiveRepository hiveRepository
  }) :  _hiveRepository = hiveRepository,
        super(const AccountSettingsState()) {
          on<AccountEventPressed>(_onAccountEventPressed);
        }
  final HiveRepository _hiveRepository;

  Future<void> _onAccountEventPressed(AccountEventPressed event, Emitter<AccountSettingsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      switch (event.method) {
        case Settings.delete:
          final request =  ModelMutations.delete(event.account);
          final response = await Amplify.API.mutate(request: request).response;
          
          if (!response.hasErrors) {
            await _hiveRepository.deleteAccountNumber('${event.account.accountType}');
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
