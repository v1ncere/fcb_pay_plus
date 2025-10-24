import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';

import '../sign_up.dart';
import 'widgets.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email 
      || previous.emailController != current.emailController,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: TextStyle(
                color: ColorString.jewel,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.0),
            CustomTextformfield(
              controller: state.emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => context.read<SignUpBloc>().add(EmailChanged(value)),
              hintText: 'Email Address',
              errorText: state.email.displayError?.text(),
              suffixIcon: !state.email.isPure
              ? IconButton(
                  icon: const Icon(FontAwesomeIcons.xmark),
                  iconSize: 18,
                  onPressed: () => context.read<SignUpBloc>().add(EmailTextErased())
                )
              : null,
            ),
          ],
        );
      }
    );
  }
}