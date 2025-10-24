import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../bloc/forgot_password_bloc.dart';
import '../widgets/widgets.dart';

class NewPasswordStep extends StatelessWidget {
  const NewPasswordStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.confirmStatus.isSuccess) {
          _showSuccessSnackbar(context, state.message);
          context.goNamed(RouteName.login);
        }
        if (state.confirmStatus.isFailure) {
          _showFailureSnackbar(context, state.message);
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade50,
                ),
                child: SvgPicture.asset(AssetString.forgotPassword)
              ),
              SizedBox(height: 15),
              ResetPassDetails(),
              SizedBox(height: 20),
              PasswordTextfield(),
              SizedBox(height: 10),
              ConfirmPasswordTextfield(),
              SizedBox(height: 20),
              ConfirmButton()
            ]
          )
        )
      )
    );
  }

  //** UTILITY METHODS */
  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.solidCircleCheck,
      backgroundColor: ColorString.eucalyptus,
      foregroundColor: ColorString.white
    ));
  }

  void _showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.triangleExclamation,
      backgroundColor: ColorString.guardsmanRed,
      foregroundColor: ColorString.white
    ));
  }
}