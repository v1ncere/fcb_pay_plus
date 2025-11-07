import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class SaveDeviceCancelButton extends StatelessWidget {
  const SaveDeviceCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              width: 2,
              color: ColorString.jewel,
            )
          )
        ),
        onPressed: () {},
        child: Text('Not now'),
      )
    );
  }
}