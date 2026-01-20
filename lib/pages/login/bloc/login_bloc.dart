import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../data/data.dart';
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SecureStorageRepository _secureStorageRepository;
  LoginBloc({
    required SecureStorageRepository secureStorageRepository
  }) : _secureStorageRepository = secureStorageRepository,
  super(const LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginConfirmPasswordChanged>(_onLoginConfirmPasswordChanged);
    on<LoginPasswordObscured>(_onLoginPasswordObscured);
    on<LoginConfirmPasswordObscured>(_onLoginConfirmPasswordObscured);
    on<LoggedInWithCredentials>(_onLoggedInWithCredentials); // login
    // on<ConfirmSubmitted>(_onConfirmSubmitted);
    // on<SignInResults>(_onSignInResults);
    on<PinCodeChanged>(_onPinCodeChanged);
    //
    // on<ConfirmSignUp>(_onConfirmSignUp);
    // on<SignUpConfirmed>(_onSignUpConfirmed);
    // on<SignInConfirmed>(_onSignInConfirmed);
    // on<AuthSignInStepDone>(_onAuthSignInStepDone);
    on<MobilePhoneDataSaved>(_onMobilePhoneDataSaved);
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

  // TODO: CHANGE THIS INTO DESIRED LOGIN
  Future<void> _onLoggedInWithCredentials(LoggedInWithCredentials event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    if (state.isValid) {
      try {
        // TODO: PUT LOGIN METHOD HERE
        emit(state.copyWith(status: FormzSubmissionStatus.success));
        await _secureStorageRepository.saveUsername(state.email.value.trim());
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
      }
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  // Future<void> _onLoggedInWithCredentials(LoggedInWithCredentials event, Emitter<LoginState> emit) async {
  //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
  //   if (state.isValid) {
  //     try {
  //       final result = await Amplify.Auth.signIn(
  //         username: state.email.value,
  //         password: state.password.value
  //       );


  //       add(SignInResults(result));
  //     } on AuthException catch (e) {
  //       emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
  //     } catch (_) {
  //       emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
  //     }
  //   } else {
  //     emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));
  //   }
  //   emit(state.copyWith(status: FormzSubmissionStatus.initial));
  // }

  // Future<void> _onSignInResults(SignInResults event, Emitter<LoginState> emit) async {
  //   final step = event.result.nextStep.signInStep;
  //   if (step == AuthSignInStep.confirmSignUp) {
  //     add(ConfirmSignUp());
  //   } else if (step == AuthSignInStep.done) {
  //     add(AuthSignInStepDone());
  //   } 
  // }

  // void _onConfirmSubmitted(ConfirmSubmitted event, Emitter<LoginState> emit) {
  //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
  //   final code = event.code;
  //   void emitFailure() => emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.formError));

  //   switch (state.signInSteps) {
  //     case SignInSteps.confirmSignUp:
  //       if (code != null) {
  //         add(SignUpConfirmed(code));
  //       } else {
  //         emitFailure();
  //       }
  //       break;
  //     default:
  //       emitFailure();
  //   }
  // }

  // Future<void> _onConfirmSignUp(ConfirmSignUp event, Emitter<LoginState> emit) async {
  //   try {
  //     final result = await Amplify.Auth.resendSignUpCode(username: state.email.value); // resend code
  //     emit(state.copyWith(
  //       status: FormzSubmissionStatus.canceled,
  //       signInSteps: SignInSteps.confirmSignUp,
  //       message: 'A confirmation code has been sent to ${result.codeDeliveryDetails.destination}. '
  //       'Please check your ${result.codeDeliveryDetails.deliveryMedium.name} for the code.'
  //     ));
  //   } on AuthException catch (e) {
  //     emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
  //   } catch (_) {
  //     emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
  //   }
  //   emit(state.copyWith(status: FormzSubmissionStatus.initial));
  // }

  // // CONFIRM SIGNUP
  // Future<void> _onSignUpConfirmed(SignUpConfirmed event, Emitter<LoginState> emit) async {
  //   try {
  //     final result = await Amplify.Auth.confirmSignUp(username: state.email.value, confirmationCode: event.code);
  //     if(result.isSignUpComplete) {
  //       emit(state.copyWith(
  //         status: FormzSubmissionStatus.canceled,
  //         signInSteps: SignInSteps.initial, 
  //         message: TextString.signUpConfirmed
  //       ));
  //     }
  //   } on AuthException catch (e) {
  //     emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
  //   } catch (_) {
  //     emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
  //   }
  //   emit(state.copyWith(status: FormzSubmissionStatus.initial));
  // }

  // // CONFIRM SIGNIN
  // Future<void> _onSignInConfirmed(SignInConfirmed event, Emitter<LoginState> emit) async {
  //   try {
  //     final result = await Amplify.Auth.confirmSignIn(confirmationValue: event.code);
  //     add(SignInResults(result));
  //   } on AuthException catch (e) {
  //     emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
  //   } catch (_) {
  //     emit(state.copyWith(status: FormzSubmissionStatus.failure, message: TextString.error));
  //   }
  //   emit(state.copyWith(status: FormzSubmissionStatus.initial));
  // }

  // void _onAuthSignInStepDone(AuthSignInStepDone event, Emitter<LoginState> emit) {
  //   emit(state.copyWith(status: FormzSubmissionStatus.success));
  // }

  void _onMobilePhoneDataSaved(MobilePhoneDataSaved event, Emitter<LoginState> emit) async {
    emit(state.copyWith(deviceStatus: Status.loading));
    try {
      final device = await DeviceIdHelper.getDeviceUniqueId();
      final deviceInfo = await DeviceIdHelper.getDeviceInfo();

      final deviceId = DeviceId(
        deviceId: device,
        owner: state.email.value,
        deviceModel: deviceInfo['model'] as String
      );
      final request = ModelMutations.create(deviceId);
      final response = await Amplify.API.mutate(request: request).response;
      final createdDeviceId = response.data;

      if (createdDeviceId == null) {
        emit(state.copyWith(deviceStatus: Status.failure));
      }

      emit(state.copyWith(deviceStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(deviceStatus: Status.failure));
    }
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    return super.close();
  }
}
