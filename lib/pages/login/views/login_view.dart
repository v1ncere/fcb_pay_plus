
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
  
import '../../../utils/utils.dart';
import '../login.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState> (
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.goNamed(RouteName.authPin);
          // context.read<AppBloc>().add(LoginChecked());
        }
        if (state.status.isCanceled) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.solidCircleCheck,
            backgroundColor: ColorString.eucalyptus,
            foregroundColor: ColorString.mystic,
          ));
        }
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.triangleExclamation,
            backgroundColor: ColorString.guardsmanRed,
            foregroundColor: ColorString.mystic,
          ));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: LoadingStack(
            isLoading: state.status.isInProgress,
            child: Scaffold(
              body: _getSignInScreen(state.signInSteps)
            )
          )
        );
      }
    );
  }
  
  Widget _getSignInScreen(SignInSteps step) {
    if (step.isConfirmSignUp) {
      return const ConfirmScreen();
    }
    return LoginScreen();
  }
}