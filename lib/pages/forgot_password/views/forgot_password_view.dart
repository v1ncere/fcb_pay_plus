import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            color: ColorString.eucalyptus,
            fontWeight: FontWeight.w700
          )
        ),
        actions: [
          IconButton(
            onPressed: () => context.pop(),
            iconSize: 18, 
            icon: Icon(FontAwesomeIcons.arrowLeftLong)
          )
        ]
      ),
      body: child
    );
  }
}