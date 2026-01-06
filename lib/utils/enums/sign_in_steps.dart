enum SignInSteps { initial, confirmSignUp, done }

extension SignInStepsX on SignInSteps {
  bool get isInitial => this == SignInSteps.initial;
  bool get isConfirmSignUp => this == SignInSteps.confirmSignUp;
  bool get isDone => this == SignInSteps.done;
}