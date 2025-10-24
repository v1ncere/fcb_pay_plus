import 'package:fcb_pay_plus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_up.dart';

class PitakardCheckbox extends StatelessWidget {
  const PitakardCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: state.isPitakardExist, 
              onChanged: (value) => context.read<SignUpBloc>().add(PitakardChecked(value!)),
            ),
            Text(
              'I have an existing PITAKArd account.',
              style: TextStyle(
                fontSize: 12,
                color: ColorString.jewel
              )
            )
          ]
        );
      }
    );
  }
}