import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import '../bloc/forgot_password_bloc.dart';

class ConfirmationCodeTextfield extends StatelessWidget {
  const ConfirmationCodeTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.confirmationCode != current.confirmationCode,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your confirmation code', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (value) => context.read<ForgotPasswordBloc>().add(ConfirmationCodeChanged(value)),
              decoration: InputDecoration(
                filled: true,
                border: const UnderlineInputBorder(),
                label: const Text('Confirmation Code'),
                errorText: state.confirmationCode.displayError?.text(),
              ),
              style: const TextStyle(height: 1.5),
            )
          ]
        );
      }
    );
  }
}