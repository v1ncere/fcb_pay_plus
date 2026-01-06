import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_up.dart';
import '../../../utils/utils.dart';

class ResendOtpCodeButton extends StatelessWidget {
  const ResendOtpCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<SignUpBloc>().add(OtpCodeSent()),
      child: Text(
        'Resend OTP',
        style: TextStyle(
          color: ColorString.deepSea,
          fontWeight: FontWeight.bold
        )
      )
    );
  }
}