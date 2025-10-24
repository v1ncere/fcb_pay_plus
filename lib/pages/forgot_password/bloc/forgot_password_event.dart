part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

final class UsernameChanged extends ForgotPasswordEvent {
  const UsernameChanged(this.username);
  final String username;

  @override
  List<Object> get props => [username];
}

final class NewPasswordChanged extends ForgotPasswordEvent {
  const NewPasswordChanged(this.newPassword);
  final String newPassword;

  @override
  List<Object> get props => [newPassword];
}

final class ConfirmNewPasswordChanged extends ForgotPasswordEvent {
  const ConfirmNewPasswordChanged(this.confirmNewPassword);
  final String confirmNewPassword;

  @override
  List<Object> get props => [confirmNewPassword];
}

final class ConfirmationCodeChanged extends ForgotPasswordEvent {
  const ConfirmationCodeChanged(this.confirmationCode);
  final String confirmationCode;

  @override
  List<Object> get props => [confirmationCode];
}

final class ResetPassword extends ForgotPasswordEvent {}

final class HandleResetPasswordResult extends ForgotPasswordEvent {
  const HandleResetPasswordResult(this.result);
  final ResetPasswordResult result;

  @override
  List<Object> get props => [result];
}

final class HandleCodeDelivery extends ForgotPasswordEvent {
  const HandleCodeDelivery(this.details);
  final AuthCodeDeliveryDetails? details;

  @override
  List<Object?> get props => [details];
}

final class ConfirmResetPassword extends ForgotPasswordEvent {}