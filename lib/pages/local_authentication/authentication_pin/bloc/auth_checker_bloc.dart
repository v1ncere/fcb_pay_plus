import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data.dart';

part 'auth_checker_event.dart';
part 'auth_checker_state.dart';

class AuthCheckerBloc extends Bloc<AuthCheckerEvent, AuthCheckerState> {
  final SqfliteRepositories _sqfliteRepositories;
  final SecureStorageRepository _secureStorageRepository;
  AuthCheckerBloc({
    required SqfliteRepositories sqfliteRepositories,
    required SecureStorageRepository secureStorageRepository,
  }) : _sqfliteRepositories = sqfliteRepositories,
  _secureStorageRepository = secureStorageRepository,
  super(const AuthCheckerState()) {
    on<AuthCheckerPinChecked>(_onAuthCheckerPinChecked);
  }

  // check if pin exists
  Future<void> _onAuthCheckerPinChecked(AuthCheckerPinChecked event, Emitter<AuthCheckerState> emit) async {
    emit(state.copyWith(status: AuthCheckerStatus.loading));
    try {
      final user = await _secureStorageRepository.getUsername();
      if (user == null) throw Exception('Username not found!');
      
      final pinAuth = await _sqfliteRepositories.getPinAuthById(user);
      if (pinAuth == null) throw Exception('Pin authenticaion not set.');
      
      emit(state.copyWith(
        status: AuthCheckerStatus.success, 
        userName: user,
        isPinExist: pinAuth.id.isNotEmpty
      ));
    } on AuthException catch (_) {
      emit(state.copyWith(status: AuthCheckerStatus.failure));
    } catch (_) {
      emit(state.copyWith(status: AuthCheckerStatus.failure));
    }
  }
}
