import 'package:fcb_pay_plus/utils/utils.dart';
import 'package:flutter/material.dart';

class SignupText extends StatelessWidget {
  const SignupText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Don\'t have an account yet?',
      style: TextStyle(
        color: ColorString.deepSea,
        shadows: [
          Shadow(
            blurRadius: 1,
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0.2, 1.0)
          )
        ]
      )
    );
  }
}