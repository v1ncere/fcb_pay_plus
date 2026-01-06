import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../cubit/top_stepper_cubit.dart';
import '../sign_up.dart';
import '../widgets/widgets.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener( // listeners for the signup
      listeners: [
        // FACE LIVENESS LISTENER
        BlocListener<FaceLivenessBloc, FaceLivenessState>(
          listener: (context, state) {
            // liveness session
            if (state.sessionStatus.isSuccess) {
              context.read<FaceLivenessBloc>().add(FaceLivenessMethodChannelInvoked());
            }
            // invoke liveness
            if (state.invokeStatus.isSuccess) {
              context.read<FaceLivenessBloc>().add(FaceLivenessResultFetched());
            }
            // liveness result
            if (state.resultStatus.isSuccess) {
              context.read<SignUpBloc>().add(LivenessImageBytesChanged(state.rawBytes)); // send the image into <SignUpBloc>
              context.read<TopStepperCubit>().goNext(); // go router proceed to next page
            }
            // errors
            if (state.sessionStatus.isFailure
            || state.invokeStatus.isFailure
            || state.resultStatus.isFailure) {
              _showFailureSnackbar(context, state.message);
            }
          }
        ),
        // SIGN UP LISTENER
        BlocListener<SignUpBloc, SignUpState>(
          listenWhen: (previous, current) => previous.status != current.status
          || previous.faceComparisonStatus != current.faceComparisonStatus
          || previous.imageStatus != current.imageStatus
          || previous.uploadStatus != current.uploadStatus
          || previous.otpSendStatus != current.otpSendStatus
          || previous.otpVerifyStatus != current.otpVerifyStatus
          || previous.otpResendStatus != current.otpResendStatus
          || previous.webBridgeStatus != current.webBridgeStatus,
          listener: (context, state) {
            if (state.otpVerifyStatus.isSuccess) {
              context.read<TopStepperCubit>().goNext();
            }
            if (state.webBridgeStatus.isSuccess) {
              context.read<TopStepperCubit>().goNext();
            }
            if (state.status.isSuccess) {
              _showSuccessSnackbar(context, state.message);
              context.goNamed(RouteName.login);
            }
            if (state.status.isFailure
            || state.faceComparisonStatus.isFailure
            || state.imageStatus.isFailure
            || state.uploadStatus.isFailure
            || state.otpSendStatus.isFailure
            || state.otpVerifyStatus.isFailure
            || state.otpResendStatus.isFailure) {
              _showFailureSnackbar(context, state.message);
            }
          }
        )
      ],
      child: LoadingLayer(
        isLoading: context.select((SignUpBloc bloc) => bloc.state.status.isLoading || bloc.state.uploadStatus.isLoading),
        isProgress: context.select((SignUpBloc bloc) => bloc.state.uploadStatus.isProgress),
        progress: context.select((SignUpBloc bloc) => bloc.state.progress),
        child: Scaffold(
          appBar: AppBar(title: const Text('Sign up')),
          body: BlocBuilder<TopStepperCubit, TopStepperState>(
            builder: (context, stepState) {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SegmentedProgressIndicator(
                        totalSteps: stepState.length,
                        completedSteps: stepState.step,
                        height: 8.0,
                        gap: 8.0,
                        backgroundColor: ColorString.algaeGreen,
                        activeColor: ColorString.jewel,
                        borderRadius: BorderRadius.circular(3.0),
                      )
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CurrentPageBuilder(step: stepState.step, isOtp: stepState.isOtp),
                      )
                    )
                  ]
                )
              );
            }
          ),
          bottomNavigationBar: BlocBuilder<TopStepperCubit, TopStepperState>(
            builder: (context, stepState) {
              return SafeArea(child: SwitchNextButton(stepState: stepState));
            }
          )
        ),
      )
    );
  }

  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.solidCircleCheck,
      backgroundColor: ColorString.eucalyptus,
      foregroundColor: ColorString.white
    ));
  }

  void _showFailureSnackbar(BuildContext context, String message) {
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