import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import '../bloc/forgot_password_bloc.dart';

class UsernameTextfield extends StatelessWidget {
  const UsernameTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => context.read<ForgotPasswordBloc>().add(UsernameChanged(value)),
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              hintText: 'Enter Email Address',
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
              errorText: state.username.displayError?.text(),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(height: 1.5),
          ),
        );
      }
    );
  }
}