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
    return MultiBlocListener(
      listeners: [
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
              _showSuccessSnackbar(context, state.message);
              context.read<TopStepperCubit>().goNext();
            }
            // errors
            if (state.sessionStatus.isFailure
            || state.invokeStatus.isFailure
            || state.resultStatus.isFailure) {
              _showFailureSnackbar(context, state.message);
            }
          }
        ),
        BlocListener<SignUpBloc, SignUpState>(
          listenWhen: (previous, current) => previous.status != current.status
          || previous.faceComparisonStatus != current.faceComparisonStatus
          || previous.imageStatus != current.imageStatus
          || previous.uploadStatus != current.uploadStatus
          || previous.confirmStatus != current.confirmStatus,
          listener: (context, state) {
            if (state.uploadStatus.isSuccess) {
              _showSuccessSnackbar(context, state.message);
              context.goNamed(RouteName.login);
            }
            if (state.status.isFailure 
            || state.faceComparisonStatus.isFailure 
            || state.imageStatus.isFailure 
            || state.uploadStatus.isFailure
            || state.confirmStatus.isFailure) {
              _showFailureSnackbar(context, state.message);
            }
          }
        )
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign up')),
        body: BlocBuilder<TopStepperCubit, TopStepperState>(
          builder: (context, stepperState) {
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SegmentedProgressIndicator(
                      totalSteps: stepperState.length,
                      completedSteps: stepperState.step,
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
                      child: CurrentPageBuilder(step: stepperState.step),
                    )
                  )
                ]
              )
            );
          }
        ),
        bottomNavigationBar: BlocBuilder<TopStepperCubit, TopStepperState>(
          builder: (context, stepState) {
            return stepState.step != 3
            ? SafeArea(
                child: SwitchNextButton(stepState: stepState)
              )
            : SizedBox.shrink();
          }
        )
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