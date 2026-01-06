import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Center(
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
              child: SvgPicture.asset(AssetString.mobileProblem)
            ),
            const SizedBox(height: 20),
            Text(
              'Page not found.',
              style: TextStyle(
                fontSize: 22,
                color: ColorString.deepSea,
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 10),
            Text(
              'Oops! This page isn\'t available.',
              style: TextStyle(
                fontSize: 14,
                color: ColorString.eucalyptus,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          ]
        )
      )
    );
  }
}