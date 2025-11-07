import 'package:flutter/material.dart';

class SaveDeviceDescriptionText extends StatelessWidget {
  const SaveDeviceDescriptionText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16
      )
    );
  }
}