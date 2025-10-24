import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';
import 'pin_inputs.dart';

class ConfirmSignupView extends StatelessWidget {
  const ConfirmSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Center(
        child: SingleChildScrollView(
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
                child: SvgPicture.asset(AssetString.otpSVG)
              ),
              const SizedBox(height: 20),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter the OTP send to your email',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const PinInputs(),
              const SizedBox(height: 25)
            ]
          )
        )
      )
    );
  }
}