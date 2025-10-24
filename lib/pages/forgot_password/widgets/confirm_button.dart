import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/utils.dart';
import '../bloc/forgot_password_bloc.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return state.confirmStatus.isLoading
        ? Center(
            child: SpinKitFadingCircle(
              color: ColorString.eucalyptus,
              size: 30,
            )
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorString.eucalyptus,
              foregroundColor: ColorString.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            ),
            onPressed: () => context.read<ForgotPasswordBloc>().add(ConfirmResetPassword()),
            child: Text('Proceed')
          );
      },
    );
  }
}