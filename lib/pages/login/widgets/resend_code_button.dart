import 'package:fcb_pay_plus/utils/utils.dart';
import 'package:flutter/material.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {}, // TODO: PUT A RESEND BLOC EVENT HERE
      child: Text(
        'Resend OTP',
        style: TextStyle(
          color: ColorString.deepSea,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}