import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import '../bloc/forgot_password_bloc.dart';

class ConfirmPasswordTextfield extends StatelessWidget {
  const ConfirmPasswordTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.confirmNewPassword != current.confirmNewPassword,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          onChanged: (value) => context.read<ForgotPasswordBloc>().add(ConfirmNewPasswordChanged(value)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            label: const Text('Confirm Password'),
            hintText: '***',
            errorText: state.confirmNewPassword.displayError?.text(),
          ),
          style: const TextStyle(height: 1.5),
        );
      }
    );
  }
}