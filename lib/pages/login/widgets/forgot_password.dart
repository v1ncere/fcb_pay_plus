import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.push('/reset/email'),
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: const Color(0xFF25C166),
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0.2, 1.0)
            )
          ]
        )
      )
    );
  }
}
