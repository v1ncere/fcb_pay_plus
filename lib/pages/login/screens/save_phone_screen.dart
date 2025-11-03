import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';

class SavePhoneScreen extends StatelessWidget {
  const SavePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.shade50,
          ),
          child: SvgPicture.asset(AssetString.mobileVerified)
        ),
      ],
    );
  }
}