import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart';
import '../login.dart';

class LoginElevatedButton extends StatelessWidget {
  const LoginElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status || current.isValid,
      builder: (context, state) {
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
            onPressed: () => _emailAndPasswordAuth(context),
            child: state.status.isInProgress
            ? Center(
                child: SpinKitThreeBounce(
                  color: ColorString.white,
                  size: 30.0,
                )
              )
            : Text(
                'Login',
                style: TextStyle(
                  color: ColorString.white
                )
              )
          )
        );
      }
    );
  }
}

void _emailAndPasswordAuth(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
  context.read<LoginBloc>().add(LoggedInWithCredentials());
}