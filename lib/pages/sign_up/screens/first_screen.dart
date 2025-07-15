import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FullName(),
        SizedBox(height: 20),
        MobileNumber(),
        SizedBox(height: 20),
        EmailTextField(),
      ]
    );
  }
}