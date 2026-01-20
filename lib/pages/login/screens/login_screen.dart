import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/utils.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Image.asset(AssetString.fcbPayPlusLogo),
            Text(
              'Where Quality Service is a Commitment',
              style: GoogleFonts.greatVibes(
                fontSize: 18,
                color: ColorString.jewel,
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 60),
            const EmailInput(),
            const SizedBox(height: 12),
            const PasswordInput(),
            const SizedBox(height: 20),
            const LoginElevatedButton(),
            const ForgotPassword(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SignupText(),
                const CreateAccountButton(),
              ]
            )
          ]
        ),
      )
    );
  }
}