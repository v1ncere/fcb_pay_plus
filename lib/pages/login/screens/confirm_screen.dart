import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';
import '../widgets/widgets.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(left: 30, right: 30),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 150,
                height: 150,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade50,
                ),
                child: SvgPicture.asset(AssetString.otpSVG)
              ),
              const SizedBox(height: 20),
              Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 22,
                  color: ColorString.deepSea,
                  fontWeight: FontWeight.bold
                )
              ),
              const SizedBox(height: 10),
              Text(
                'Please enter the OTP sent to your registered email address.',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorString.eucalyptus,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const PinInputs(),
              const SizedBox(height: 30),
              Text(
                'Didn\'t receive the code?',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorString.eucalyptus,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              ResendCodeButton(),
            ]
          )
        )
      )
    );
  }
}