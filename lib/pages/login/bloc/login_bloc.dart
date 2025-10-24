import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginConfirmPasswordChanged>(_onLoginConfirmPasswordChanged);
    on<LoginPasswordObscured>(_onLoginPasswordObscured);
    on<LoginConfirmPasswordObscured>(_onLoginConfirmPasswordObscured);
    on<LoggedInWithCredentials>(_onLoggedInWithCredentials);
    on<ConfirmSubmitted>(_onConfirmSubmitted);
    on<SignInResults>(_onSignInResults);
    on<PinCodeChanged>(_onPinCodeChanged);
    on<LoginMfaChanged>(_onLoginMfaChanged);
    //
    on<ConfirmSignInWithSmsMfaCode>(_onConfirmSignInWithSmsMfaCode);
    on<ConfirmSignInWithNewPassword>(_onConfirmSignInWithNewPassword);
    on<ConfirmSignInWithCustomChallenge>(_onConfirmSignInWithCustomChallenge);
    on<ResetPassword>(_onResetPassword);
    on<HandlePasswordResetCodeDelivery>(_onHandlePasswordResetCodeDelivery);
    on<ResetPasswordWithCodeConfirmed>(_onResetPasswordWithCodeConfirmed);
    on<ResetPasswordDone>(_onResetPasswordDone);
    on<ConfirmSignUp>(_onConfirmSignUp);
    on<SignUpConfirmed>(_onSignUpConfirmed);
    on<ContinueSignInWithMfaSelection>(_onConfirmSignInWithMfaSelection);
    on<ContinueSignInWithTotpSetup>(_onContinueSignInWithTotpSetup);
    on<ConfirmSignInWithTotpMfaCode>(_onConfirmSignInWithTotpMfaCode);
    on<ContinueSignInWithMfaSetupSelection>(_onContinueSignInWithMfaSetupSelection);
    on<ContinueSignInWithEmailMfaSetup>(_onContinueSignInWithEmailMfaSetup);
    on<ConfirmSignInWithOtpCode>(_onConfirmSignInWithOtpCode);
    on<SignInConfirmed>(_onSignInConfirmed);
    on<AuthSignInStepDone>(_onAuthSignInStepDone);
  }
  Timer? _timer;

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: Email.dirty(event.email)));
  }

  void _onLoginPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: Password.dirty(event.password)));
  }

  void _onLoginConfirmPasswordChanged(LoginConfirmPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(confirmedPassword: ConfirmedPassword.dirty(password: event.password, value: event.confirmPassword)));
  }

  void _onPinCodeChanged(PinCodeChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(pinCode: Name.dirty(event.pinCode)));
  }

  void _onLoginPasswordObscured(LoginPasswordObscured event, Emitter<LoginState> emit) {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void _onLoginConfirmPasswordObscured(LoginConfirmPasswordObscured event, Emitter<LoginState> emit) {
    emit(state.copyWith(isConfirmObscure: !state.isConfirmObscure));
  }

  void _onLoginMfaChanged(LoginMfaChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(mfa: event.mfa));
  }

  Future<void> _onLoggedInWithCredentials(LoggedInWithCredentials event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    if (state.isValid) {
      try {
        final result = await Amplify.Auth.signIn(
          username: state.email.value,
          password: state.password.value
        );
        add(SignInResults(result));
      } on AuthException catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
      }
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  Future<void> _onSignInResults(SignInResults event, Emitter<LoginState> emit) async {
    switch(event.result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        add(ConfirmSignInWithSmsMfaCode(event.result));
        break;
      case AuthSignInStep.confirmSignUp:
        add(ConfirmSignUp());
        break;
      case AuthSignInStep.confirmSignInWithTotpMfaCode:
        add(ConfirmSignInWithTotpMfaCode());
        break;
      case AuthSignInStep.confirmSignInWithNewPassword:
        add(ConfirmSignInWithNewPassword());
        break;
      case AuthSignInStep.resetPassword:
        add(ResetPassword());
        break;
      case AuthSignInStep.confirmSignInWithCustomChallenge:
        add(ConfirmSignInWithCustomChallenge(event.result));
        break;
      case AuthSignInStep.continueSignInWithMfaSelection:
        add(ContinueSignInWithMfaSelection(event.result));
        break;
      case AuthSignInStep.continueSignInWithTotpSetup:
        add(ContinueSignInWithTotpSetup(event.result));
        break;
      case AuthSignInStep.continueSignInWithMfaSetupSelection:
        add(ContinueSignInWithMfaSetupSelection(event.result));
        break;
      case AuthSignInStep.continueSignInWithEmailMfaSetup:
        add(ContinueSignInWithEmailMfaSetup());
        break;
      case AuthSignInStep.confirmSignInWithOtpCode:
        add(ConfirmSignInWithOtpCode(event.result));
        break;
      case AuthSignInStep.done:
        add(AuthSignInStepDone());
        break;
    }
  }

  void _onConfirmSubmitted(ConfirmSubmitted event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final code = event.code;
    void emitFailure() => emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
    void emitInitial() => emit(state.copyWith(status: FormzSubmissionStatus.initial));

    switch (state.signInSteps) {
      case SignInSteps.confirmSignInWithSmsMfaCode:
      case SignInSteps.confirmSignInWithTotpMfaCode:
      case SignInSteps.continueSignInWithTotpSetup:
        if (code != null) {
          add(SignInConfirmed(code));
        } else {
          emitFailure();
        }
        break;
      case SignInSteps.confirmSignUp:
        if (code != null) {
          add(SignUpConfirmed(code));
        } else {
          emitFailure();
        }
        break;
      case SignInSteps.continueSignInWithEmailMfaSetup:
        if (state.email.isValid) {
          add(SignInConfirmed(state.email.value));
        } else {
          emitFailure();
          emitInitial();
        }
        break;
      case SignInSteps.confirmSignInWithNewPassword:
        if (state.password.isValid && state.confirmedPassword.isValid) {
          add(SignInConfirmed(state.password.value));
        } else {
          emitFailure();
          emitInitial();
        }
        break;
      case SignInSteps.resetPassword:
        add(ResetPasswordWithCodeConfirmed());
        break;
      case SignInSteps.continueSignInWithMfaSelection:
      case SignInSteps.continueSignInWithMfaSetupSelection:
        add(SignInConfirmed(state.mfa.confirmationValue)); // default MFA is SMS
        break;
      default:
        emitFailure();
    }
  }
  
  void _onConfirmSignInWithSmsMfaCode(ConfirmSignInWithSmsMfaCode event, Emitter<LoginState> emit) {
    final details = event.result.nextStep.codeDeliveryDetails!;
    emit(state.copyWith(
      status: FormzSubmissionStatus.canceled,
      signInSteps: SignInSteps.confirmSignInWithSmsMfaCode,
      message: 'A confirmation code has been sent to ${details.destination}. '
      'Please check your ${details.deliveryMedium.name} for the code.',
    ));
  }

  Future<void> _onConfirmSignUp(ConfirmSignUp event, Emitter<LoginState> emit) async {
    try {
      final result = await Amplify.Auth.resendSignUpCode(username: state.email.value); // resend code
      emit(state.copyWith(
        status: FormzSubmissionStatus.canceled,
        signInSteps: SignInSteps.confirmSignUp,
        message: 'A confirmation code has been sent to ${result.codeDeliveryDetails.destination}. '
        'Please check your ${result.codeDeliveryDetails.deliveryMedium.name} for the code.'
      ));
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void _onConfirmSignInWithTotpMfaCode(ConfirmSignInWithTotpMfaCode event, Emitter<LoginState> emit) {
    emit(state.copyWith(signInSteps: SignInSteps.confirmSignInWithTotpMfaCode));
  }

  // CONFIRM SIGNUP
  Future<void> _onSignUpConfirmed(SignUpConfirmed event, Emitter<LoginState> emit) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(username: state.email.value, confirmationCode: event.code);
      if(result.isSignUpComplete) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.canceled,
          signInSteps: SignInSteps.initial, 
          message: TextString.signUpConfirmed
        ));
      }
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  // CONFIRM SIGNIN
  Future<void> _onSignInConfirmed(SignInConfirmed event, Emitter<LoginState> emit) async {
    try {
      final result = await Amplify.Auth.confirmSignIn(confirmationValue: event.code);
      add(SignInResults(result));
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void _onConfirmSignInWithNewPassword(ConfirmSignInWithNewPassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      status: FormzSubmissionStatus.canceled,
      signInSteps: SignInSteps.confirmSignInWithNewPassword,
      message: TextString.newPassword
    ));
  }

  void _onConfirmSignInWithCustomChallenge(ConfirmSignInWithCustomChallenge event, Emitter<LoginState> emit) {
    final parameters = event.result.nextStep.additionalInfo;
    final prompt = parameters['prompt'] ?? '';
    emit(state.copyWith(signInSteps: SignInSteps.confirmSignInWithCustomChallenge, message: prompt));
  }

  // ======================== >>> RESET PASSWORD =====================================
  Future<void> _onResetPassword(ResetPassword event, Emitter<LoginState> emit) async {
    try {
      final result = await Amplify.Auth.resetPassword(username: state.email.value);
      switch(result.nextStep.updateStep) {
        case AuthResetPasswordStep.confirmResetPasswordWithCode:
          add(HandlePasswordResetCodeDelivery(result));
          break;
        case AuthResetPasswordStep.done:
          add(ResetPasswordDone());
          break;
      }
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void _onHandlePasswordResetCodeDelivery(HandlePasswordResetCodeDelivery event, Emitter<LoginState> emit) {
    final details = event.result.nextStep.codeDeliveryDetails!;
    emit(state.copyWith(
      status: FormzSubmissionStatus.canceled,
      signInSteps: SignInSteps.resetPassword,
      message: 'A confirmation code has been sent to ${details.destination}. '
      'Please check your ${details.deliveryMedium.name} for the code.'
    ));
  }

  Future<void> _onResetPasswordWithCodeConfirmed(ResetPasswordWithCodeConfirmed event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      if (state.pinCode.isValid && state.email.isValid && state.password.isValid) {
        final result = await Amplify.Auth.confirmResetPassword(
          confirmationCode: state.pinCode.value,
          username: state.email.value,
          newPassword: state.password.value
        );
        if (result.isPasswordReset) {
          add(ResetPasswordDone());
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.resetPasswordFail));
        }
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
      }
    } on AuthException catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void _onResetPasswordDone(ResetPasswordDone event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      signInSteps: SignInSteps.initial,
      status: FormzSubmissionStatus.canceled,
      message: TextString.resetPasswordDone
    ));
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
  // <<< ===================== RESET PASSWORD END ========================== <<<

  void _onConfirmSignInWithMfaSelection(ContinueSignInWithMfaSelection event, Emitter<LoginState> emit) {
    final allowedMfaTypes = event.result.nextStep.allowedMfaTypes!;
    emit(state.copyWith(signInSteps: SignInSteps.continueSignInWithMfaSelection, mfaTypes: allowedMfaTypes));
  }

  void _onContinueSignInWithTotpSetup(ContinueSignInWithTotpSetup event, Emitter<LoginState> emit) {
    final details = event.result.nextStep.totpSetupDetails!;
    emit(state.copyWith(totpDetails: details));
    // final setupUri = details.getSetupUri(appName: 'FCBPay');
  }

  void _onContinueSignInWithMfaSetupSelection(ContinueSignInWithMfaSetupSelection event, Emitter<LoginState> emit) {
    final allowedMfaTypes = event.result.nextStep.allowedMfaTypes!;
    emit(state.copyWith(signInSteps: SignInSteps.continueSignInWithMfaSetupSelection , mfaTypes: allowedMfaTypes));
  }

  void _onContinueSignInWithEmailMfaSetup(ContinueSignInWithEmailMfaSetup event, Emitter<LoginState> emit) {
    emit(state.copyWith(signInSteps: SignInSteps.continueSignInWithEmailMfaSetup));
  }

  void _onConfirmSignInWithOtpCode(ConfirmSignInWithOtpCode event, Emitter<LoginState> emit) {
    final details = event.result.nextStep.codeDeliveryDetails!;
    emit(state.copyWith(
      status: FormzSubmissionStatus.canceled,
      signInSteps: SignInSteps.confirmSignInWithOtpCode,
      message: 'A confirmation code has been sent to ${details.destination}. '
      'Please check your ${details.deliveryMedium.name} for the code.',
    ));
  }

  void _onAuthSignInStepDone(AuthSignInStepDone event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    return super.close();
  }
}
