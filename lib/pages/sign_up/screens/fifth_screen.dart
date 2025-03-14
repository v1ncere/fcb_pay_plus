import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';
import '../widgets/widgets.dart';

class FifthScreen extends StatelessWidget {
  const FifthScreen({super.key});
  static final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserImage(picker: picker),
          const SizedBox(height: 5),
          const Text(
            TextString.imageNote,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black45,
              fontWeight: FontWeight.w500
            )
          )
        ]
      )
    );
  }
}
