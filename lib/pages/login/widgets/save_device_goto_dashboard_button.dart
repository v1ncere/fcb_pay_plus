import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../login.dart';

class SaveDeviceGotoDashboardButton extends StatelessWidget {
  const SaveDeviceGotoDashboardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((state) {
            if (state.contains(WidgetState.disabled)) {
              return Colors.grey.shade500;
            }
            return ColorString.jewel;
          }),
        ),
        onPressed: () => context.read<LoginBloc>().add(MobilePhoneDataSaved()),
        child: Text(
          'Go to dashboard',
          style: TextStyle(
            color: ColorString.white
          )
        )
      )
    );
  }
}