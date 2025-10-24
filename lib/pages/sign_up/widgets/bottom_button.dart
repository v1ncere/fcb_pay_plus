import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';

enum ButtonName { leading, trailing }

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.current});
  final int current;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (current < 4) TextButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  )
                ),
                onPressed: () => _onButtonPressed(
                  context: context,
                  step: current,
                  name: ButtonName.leading,
                  state: state
                ),
                child: Text(
                  _buttonName(current, ButtonName.leading),
                  style: TextStyle(color: ColorString.eucalyptus)
                )
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(ColorString.eucalyptus),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  )
                ),
                onPressed: () => _onButtonPressed(
                  context: context,
                  step: current,
                  name: ButtonName.trailing,
                  state: state
                ),
                child: Text(
                  _buttonName(current, ButtonName.trailing),
                  style: TextStyle(color: ColorString.white)
                )
              )
            ]
          )
        );
      }
    );
  }

  // UTILITY METHODS
  // return string button name
  String _buttonName(int step, ButtonName name) {
    switch(name) {
      case ButtonName.leading:
        return step <= 0 ? 'CANCEL' : 'BACK';
      case ButtonName.trailing:
        return step >= 4 ? 'SUBMIT' : 'NEXT';
    }
  }
  
  void _onButtonPressed({
    required BuildContext context,
    required int step, 
    required ButtonName name,
    required SignUpState state
  }) {
    switch(name) {
      case ButtonName.leading:
        if (step <= 0) {
          context.goNamed('login');
        } else {
          
        }
        break;
      case ButtonName.trailing:
        switch (step) {
          case 0:
            if (state.email.isPure && state.mobile.isPure)
            {
              
            } else {
              _showFailureSnackbar(context, TextString.incompleteForm);
            }
            break;
          case 1:
            
            break;
          case 2:
            
          case 3:
            if (state.livenessImageBytes.isNotEmpty) {
              
            } else {
              _showFailureSnackbar(context, TextString.incompleteForm);
            }
          case 4:
            if (state.userImage != null) {
              context.read<SignUpBloc>().add(FaceComparisonFetched());
            } else {
              _showFailureSnackbar(context, TextString.incompleteForm);
            }
            break;
        }
        break;
    }
  }

  //** UTILITY */
  bool isBirthdateValid(String birthDate) {
    final isMatch = RegExp(r'^(0[1-9]|1\d|2\d|3[01])/(0[1-9]|1[0-2])/(19[5-9]\d|20\d{2})$').hasMatch(birthDate);
    return birthDate.isNotEmpty && isMatch;
  }

  // show failure snackbar
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