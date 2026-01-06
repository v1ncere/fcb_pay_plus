part of 'login_bloc.dart';

class LoginState extends Equatable with FormzMixin {
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Name pinCode;
  final bool isObscure;
  final bool isConfirmObscure;
  final SignInSteps signInSteps;
  final FormzSubmissionStatus status;
  final Status deviceStatus;
  final String message;
  
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.pinCode = const Name.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isObscure = true,
    this.isConfirmObscure = true,
    this.signInSteps = SignInSteps.initial,
    this.deviceStatus = Status.initial,
    this.message = '',
  });
  
  @override
  List<FormzInput> get inputs => [email, password];

  LoginState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Name? pinCode,
    bool? isObscure,
    bool? isConfirmObscure,
    SignInSteps? signInSteps,
    FormzSubmissionStatus? status,
    Status? deviceStatus,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      pinCode: pinCode ?? this.pinCode,
      isObscure: isObscure ?? this.isObscure,
      isConfirmObscure: isConfirmObscure ?? this.isConfirmObscure,
      signInSteps: signInSteps ?? this.signInSteps,
      status: status ?? this.status,
      deviceStatus: deviceStatus ?? this.deviceStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props {
    return [
      email,
      password,
      confirmedPassword,
      pinCode,
      isObscure,
      isConfirmObscure,
      signInSteps,
      status,
      deviceStatus,
      message,
    ];
  }
}