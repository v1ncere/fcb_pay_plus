import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // if verification is needed push to signup verify
      onPressed: () => context.pushNamed(RouteName.signUp),
      child: Text(
        'Sign up',
        style: TextStyle(
          color: ColorString.blazeOrange,
          shadows: [
            Shadow(
              blurRadius: 1,
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0.2, 1.0)
            )
          ]
        )
      )
    );
  }
}
