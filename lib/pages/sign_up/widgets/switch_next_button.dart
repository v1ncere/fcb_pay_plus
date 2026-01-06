import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../cubit/top_stepper_cubit.dart';
import '../sign_up.dart';
import 'widgets.dart';

class SwitchNextButton extends StatelessWidget {
  const SwitchNextButton({super.key, required this.stepState});
  final TopStepperState stepState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        switch(stepState.step) {
          case 1: return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PitakardCheckbox(),
                NextButton(isValid: (state.accountNumber.isValid && state.accountAlias.isValid) || !state.isPitakardExist),
              ]
            );
          case 2: return !stepState.isOtp
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NextButton(isValid: state.email.isValid && state.mobile.isValid),
                ],
              ) 
            : SizedBox.shrink();
          case 3: return SizedBox.shrink();
          case 4: return SizedBox.shrink();
          case 5: return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NextButton(isValid: state.email.isValid && state.mobile.isValid && state.webBridgeStatus.isSuccess),
              ],
            );
          default: return SizedBox.shrink();
        }
      }
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.isValid});
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopStepperCubit, TopStepperState>(
      builder: (context, state) {
        final isNext = state.step == state.length;
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((state) {
                    if (state.contains(WidgetState.disabled)) {
                      return Colors.grey.shade500;
                    }
                    return ColorString.jewel;
                  }),
                ),
                onPressed: isValid
                ? () {
                    if (isNext) {
                      context.read<SignUpBloc>().add(FaceComparisonFetched());
                    } else {
                      if (state.step == 1) {
                        context.read<TopStepperCubit>().goNext();
                      }
                      if (state.step == 2) {
                        if (!state.isOtp) {
                          context.read<TopStepperCubit>().isOtpChange();
                          context.read<SignUpBloc>().add(OtpCodeSent());
                        }
                      }
                    }
                  }
                : null,
                child: Text(
                  (isNext) ? 'Submit' : 'Next',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorString.white
                  )
                )
              )
            )
          )
        );
      }
    );
  }
}