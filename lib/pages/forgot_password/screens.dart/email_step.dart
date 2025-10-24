import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../bloc/forgot_password_bloc.dart';
import '../widgets/widgets.dart';

class EmailStep extends StatelessWidget {
  const EmailStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          _showSuccessSnackbar(context, state.message);
          context.goNamed(RouteName.login);
        }
        if (state.status.isCanceled) {
          _showSuccessSnackbar(context, state.message);
          context.push('/reset/code');
        }
        if (state.status.isFailure) {
          _showFailureSnackbar(context, state.message);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(AssetString.sendingEmails, height: 200),
              DetailsText(),
              SizedBox(height: 20),
              UsernameTextfield(),
              SizedBox(height: 30),
              SendButton()
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