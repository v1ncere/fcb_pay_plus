import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/utils.dart';

class PinInputs extends StatelessWidget {
  const PinInputs({super.key});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      showCursor: true,
      defaultPinTheme: PinTheme(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: ColorString.eucalyptus,
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )
      ),
      onCompleted: (value) {},
      // onCompleted: (value) => context.read<LoginBloc>().add(ConfirmSubmitted(code: value)),
      closeKeyboardWhenCompleted: true,
    );
  }
}