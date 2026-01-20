import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../../../utils/utils.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ConfirmNewPasswordChanged>(_onConfirmNewPasswordChanged);
    on<ConfirmationCodeChanged>(_onConfirmationCodeChanged);
    on<ResetPassword>(_onResetPassword);
    on<HandleResetPasswordResult>(_onHandleResetPasswordResult);
    on<HandleCodeDelivery>(_onHandleCodeDelivery);
    on<ConfirmResetPassword>(_onConfirmResetPassword);
  }
  
  void _onUsernameChanged(UsernameChanged event, Emitter<ForgotPasswordState> emit) {
    final username = Email.dirty(event.username);
    emit(state.copyWith(username: username));
  }

  void _onNewPasswordChanged(NewPasswordChanged event, Emitter<ForgotPasswordState> emit) {
    final newPassword = Password.dirty(event.newPassword);
    emit(state.copyWith(newPassword: newPassword));
  }

  void _onConfirmNewPasswordChanged(ConfirmNewPasswordChanged event, Emitter<ForgotPasswordState> emit) {
    final confirmNewPassword = ConfirmedPassword.dirty(password: state.newPassword.value, value: event.confirmNewPassword);
    emit(state.copyWith(confirmNewPassword: confirmNewPassword));
  }

  void _onConfirmationCodeChanged(ConfirmationCodeChanged event, Emitter<ForgotPasswordState> emit) {
    final confirmationCode = Name.dirty(event.confirmationCode);
    emit(state.copyWith(confirmationCode: confirmationCode));
  }
  
  Future<void> _onResetPassword(ResetPassword event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final result = await Amplify.Auth.resetPassword(username: state.username.value);
      add(HandleResetPasswordResult(result));
    } on AuthException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }

  Future<void> _onHandleResetPasswordResult(HandleResetPasswordResult event, Emitter<ForgotPasswordState> emit) async {
    final result = event.result;
    switch(result.nextStep.updateStep) {
      case AuthResetPasswordStep.confirmResetPasswordWithCode:
        add(HandleCodeDelivery(result.nextStep.codeDeliveryDetails));
        break;
      case AuthResetPasswordStep.done:
        emit(state.copyWith(status: Status.success, message: TextString.resetPasswordDone));
        break;
    }
  }

  void _onHandleCodeDelivery(HandleCodeDelivery event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(
      status: Status.canceled,
      message: 'A confirmation code has been sent to ${event.details!.destination}. '
      'Please check your ${event.details!.deliveryMedium.name} for the code.',
    ));
    emit(state.copyWith(status: Status.initial));
  }

  Future<void> _onConfirmResetPassword(ConfirmResetPassword event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(confirmStatus: Status.loading));
    if (state.newPassword.isValid && state.confirmNewPassword.isValid) {
      try {
        final result = await Amplify.Auth.confirmResetPassword(
          username: state.username.value,
          newPassword: state.newPassword.value,
          confirmationCode: state.confirmationCode.value,
        );
        if (result.isPasswordReset) {
          emit(state.copyWith(confirmStatus: Status.success, message: TextString.resetPasswordDone));
        } else {
          emit(state.copyWith(confirmStatus: Status.failure, message: TextString.resetPasswordFail));
        }
      } on AuthException catch (e) {
        emit(state.copyWith(confirmStatus: Status.failure, message: e.message));
      }
    } else {
      emit(state.copyWith(confirmStatus: Status.failure, message: TextString.incompleteForm));
    }
    emit(state.copyWith(confirmStatus: Status.initial));
  }
}
