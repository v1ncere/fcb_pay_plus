import 'package:fcb_pay_plus/pages/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class PinInputs extends StatelessWidget {
  const PinInputs({super.key});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      showCursor: true,
      defaultPinTheme: PinTheme(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green.shade200),
        ),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )
      ),
      onChanged: (value) => context.read<SignUpBloc>().add(OtpCodeChanged(value)),
      onCompleted: (value) => context.read<SignUpBloc>().add(OtpCodeVerified(value)),
      closeKeyboardWhenCompleted: true,
    );
  }
}