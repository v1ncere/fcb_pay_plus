import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class EmailMobileScreen extends StatelessWidget {
  const EmailMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        EmailTextField(),
        SizedBox(height: 30),
        MobileNumber(),
      ]
    );
  }
}