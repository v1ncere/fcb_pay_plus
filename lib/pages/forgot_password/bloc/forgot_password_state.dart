part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.username = const Email.pure(),
    this.newPassword = const Password.pure(),
    this.confirmNewPassword = const ConfirmedPassword.pure(),
    this.confirmationCode = const Name.pure(),
    this.status = Status.initial,
    this.confirmStatus = Status.initial,
    this.message = '',
  });
  final Email username;
  final Password newPassword;
  final ConfirmedPassword confirmNewPassword;
  final Name confirmationCode;
  final Status status;
  final Status confirmStatus;
  final String message;

  ForgotPasswordState copyWith({
    Email? username,
    Password? newPassword,
    ConfirmedPassword? confirmNewPassword,
    Name? confirmationCode,
    Status? status,
    Status? confirmStatus,
    String? message
  }) {
    return ForgotPasswordState(
      username: username ?? this.username,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      confirmationCode: confirmationCode ?? this.confirmationCode,
      status: status ?? this.status,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [
    username, 
    newPassword, 
    confirmNewPassword, 
    confirmationCode, 
    status, 
    confirmStatus,
    message,
  ];
}
