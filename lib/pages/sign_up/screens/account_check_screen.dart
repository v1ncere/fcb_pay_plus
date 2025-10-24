import 'package:fcb_pay_plus/utils/utilities/utilities.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class AccountCheckScreen extends StatelessWidget {
  const AccountCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let\'s Get Started!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: ColorString.jewel,
            )
          ),
          SizedBox(height: 20),
          AccountCardTextfield(),
          SizedBox(height: 30),
          AccountAliasTextfield(),
        ]
      ),
    );
  }
}
