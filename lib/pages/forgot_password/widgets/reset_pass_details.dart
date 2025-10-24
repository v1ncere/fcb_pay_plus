import 'package:flutter/material.dart';

class ResetPassDetails extends StatelessWidget {
  const ResetPassDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Please type a new password and confirm it below.",
      style: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
    );
  }
}