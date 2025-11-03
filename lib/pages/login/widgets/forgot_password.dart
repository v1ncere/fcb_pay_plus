import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerRight,
      child: TextButton(
        onPressed: () => context.push('/reset/email'),
        child: Text(
          'Forgot Password',
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
        )
      )
    );
  }
}
