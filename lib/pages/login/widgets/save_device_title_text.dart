import 'package:flutter/material.dart';

class SaveDeviceTitleText extends StatelessWidget {
  const SaveDeviceTitleText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      )
    );
  }
}