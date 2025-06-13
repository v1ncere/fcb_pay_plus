import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../screens/screens.dart';
import '../sign_up.dart';
import '../widgets/widgets.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              _showSuccessSnackbar(context, state.message);
              context.goNamed(RouteName.login);
            }
            if(state.status.isCanceled) {
              _showSuccessSnackbar(context, state.message);
              context.goNamed(RouteName.signUpConfirm, pathParameters: {'username': state.email.value});
            }
            if (state.status.isFailure || state.faceComparisonStatus.isFailure || state.imageStatus.isFailure) {
              _showFailureSnackbar(context, state.message);
            }
          }
        ),
        BlocListener<FaceLivenessBloc, FaceLivenessState>(
          listener: (context, state) {
            // session
            if(state.sessionStatus.isSuccess) {
              context.read<FaceLivenessBloc>().add(FaceLivenessMethodChannelInvoked());
            }
            // invoke
            if(state.invokeStatus.isSuccess) {
              context.read<FaceLivenessBloc>().add(FaceLivenessResultFetched());
            }
            // liveness result
            if(state.resultStatus.isSuccess) {
              context.read<SignUpBloc>().add(LivenessImageBytesChanged(state.rawBytes));
              context.read<SignUpStepperCubit>().stepContinued();
              _showSuccessSnackbar(context, state.message);
            }
            // errors
            if (state.invokeStatus.isFailure || state.resultStatus.isFailure || state.sessionStatus.isFailure) {
              _showFailureSnackbar(context, state.message);
            }
          }
        )
      ],
      child: BlocBuilder<SignUpStepperCubit, int>(
        builder: (context, currentStep) {
          return BlocBuilder<SignUpBloc, SignUpState>(
            builder: (_, state) {
              return LoadingLayer(
                isLoading: state.status.isLoading,
                isProgress: state.status.isProgress,
                progress: state.progress,
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.x, size: 16),
                        onPressed: () => context.pop(),
                      )
                    ]
                  ),
                  body: Stepper(
                    elevation: 0,
                    currentStep: currentStep,
                    type: StepperType.horizontal,
                    physics: const ScrollPhysics(),
                    steps: getSteps(currentStep, state),
                    onStepTapped: context.read<SignUpStepperCubit>().stepTapped,
                    controlsBuilder: (_, __) => const SizedBox.shrink()
                  ),
                  bottomNavigationBar: currentStep != 3
                  ? BottomButton(current: currentStep)
                  : const SizedBox.shrink()
                )
              );
            }
          );
        }
      )
    );
  }

  // STEPS
  List<Step> getSteps(int step, SignUpState state) {
    const shrink = SizedBox.shrink();
    return <Step>[
      Step(
        title: shrink,
        content: const FirstScreen(),
        isActive: step == 0,
        state: getStepState(0, step, state)
      ),
      Step(
        title: shrink,
        content: const SecondScreen(),
        isActive: step == 1,
        state: getStepState(1, step, state)
      ),
      Step(
        title: shrink,
        content: const ThirdScreen(),
        isActive: step == 2,
        state: getStepState(2, step, state)
      ),
      Step(
        title: shrink,
        content: const FourthScreen(),
        isActive: step == 3,
        state: getStepState(3, step, state)
      ),
      Step(
        title: shrink,
        content: const FifthScreen(),
        isActive: step == 4,
        state: getStepState(4, step, state)
      ),
    ];
  }

  // STEP STATE
  StepState getStepState(int index, int step, SignUpState state) {
    if (step < index) {
      return StepState.disabled;
    } else if (step == index) {
      switch(index) {
        case 0:
          return (state.email.isPure && state.firstName.isPure && state.lastName.isPure && state.mobile.isPure)
          ? StepState.indexed
          : StepState.editing;
        case 1:
          return (state.password.isPure && state.confirmPassword.isPure)
          ? StepState.indexed
          : StepState.editing;
        case 2:
          return (state.province.isPure && state.cityMunicipality.isPure && state.barangay.isPure && state.zipCode.isPure) 
          ? StepState.indexed 
          : StepState.editing;
        case 3:
          return (state.livenessImageBytes.isNotEmpty)
          ? StepState.indexed
          : StepState.editing;
        case 4:
          return (state.userImage != null)
          ? StepState.indexed
          : StepState.editing;
        default:
          return StepState.indexed;
      }
    } else {
      switch(index) {
        case 0:
          return (state.email.isValid && state.firstName.isValid && state.lastName.isValid && state.mobile.isValid) 
          ? StepState.complete 
          : StepState.error;
        case 1:
          return (state.password.isValid && state.confirmPassword.isValid) 
          ? StepState.complete
          : StepState.error;
        case 2:
          return (state.province.isValid && state.cityMunicipality.isValid && state.barangay.isValid && state.zipCode.isValid) 
          ? StepState.complete
          : StepState.error;
        case 3:
          return (state.livenessImageBytes.isNotEmpty)
          ? StepState.complete
          : StepState.error;
        case 4:
          return (state.userImage != null)
          ? StepState.complete
          : StepState.error;
        default:
          return StepState.error;
      }
    }
  }

  // show success dialog 
  _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.solidCircleCheck,
      backgroundColor: ColorString.eucalyptus,
      foregroundColor: ColorString.white
    ));
  }

  // show failure snackbar
  _showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.triangleExclamation,
      backgroundColor: ColorString.guardsmanRed,
      foregroundColor: ColorString.white
    ));
  }
}