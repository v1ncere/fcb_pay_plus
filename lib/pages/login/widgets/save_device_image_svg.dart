import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SaveDeviceImageSvg extends StatelessWidget {
  const SaveDeviceImageSvg({super.key, required this.assetString});
  final String assetString;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetString,
      width: 300,
      height: 300,
    );
  }
}