import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sign_up_bloc.dart';
import '../screens/screens.dart';

class CurrentPageBuilder extends StatelessWidget {
  const CurrentPageBuilder({super.key, required this.step, required this.isOtp});
  final int step;
  final bool isOtp;

  @override
  Widget build(BuildContext context) {
    switch(step) {
      case 1:
        return AccountCheckScreen();
      case 2:
        return isOtp ? OtpScreen() : EmailMobileScreen();
      case 3: 
        return BlocSelector<SignUpBloc, SignUpState, String>(
          selector: (state) => state.activeBridgeToken,
          builder: (context, state) {
            return WebViewScreen(bridgeToken: state);
          },
        );
      case 4: 
        return FacelivenessScreen();
      case 5:
        return ValidIdCheckScreen();
      default: 
        return ErrorScreen();
    }
  }
}
