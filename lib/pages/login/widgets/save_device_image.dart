import 'package:flutter/material.dart';

class SaveDeviceImage extends StatelessWidget {
  const SaveDeviceImage({super.key, required this.assetString});
  final String assetString;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetString,
      width: 300,
      height: 300,
    );
  }
}