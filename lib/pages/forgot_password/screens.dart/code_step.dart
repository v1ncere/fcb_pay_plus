import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';
import '../widgets/widgets.dart';

class CodeStep extends StatelessWidget {
  const CodeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade50,
              ),
              child: SvgPicture.asset(AssetString.mailSent)
            ),
            const SizedBox(height: 20),
            const Text(
              'Verification',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87
              )
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter the verification code we just sent you on your email address.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const PinInput(),
            const SizedBox(height: 20),
            ContinueButton()
          ]
        )
      )
    );
  }
}