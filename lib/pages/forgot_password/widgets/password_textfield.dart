import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../bloc/forgot_password_bloc.dart';

class PasswordTextfield extends StatelessWidget {
  const PasswordTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.newPassword != current.newPassword,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          onChanged: (value) => context.read<ForgotPasswordBloc>().add(NewPasswordChanged(value)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            label: const Text('New Password'),
            hintText: '***',
            errorText: state.newPassword.displayError?.text(),
          ),
          style: const TextStyle(height: 1.5),
        );
      }
    );
  }
}