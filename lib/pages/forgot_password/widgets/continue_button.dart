import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorString.eucalyptus,
        foregroundColor: ColorString.white,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      ),
      onPressed: () => context.push('/reset/new_password'),
      child: Text('Verify')
    );
  }
}