import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';

class SignUpWithPitakardButton extends StatelessWidget {
  const SignUpWithPitakardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.pushNamed(RouteName.signUp),
      child: Text(
        'Sign Up with PITAKArd',
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
