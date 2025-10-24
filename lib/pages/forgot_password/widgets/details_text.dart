import 'package:flutter/material.dart';

class DetailsText extends StatelessWidget {
  const DetailsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Text(
            "Enter the email address associated with your account.",
            // style: Theme.of(context).textTheme.headlineSmall,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "We will email you a code to reset your password.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black45,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ]
      ),
    );
  }
}