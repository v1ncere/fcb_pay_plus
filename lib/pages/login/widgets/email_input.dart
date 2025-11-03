import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../login.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          clipBehavior: Clip.antiAlias,
          onChanged: (email) => context.read<LoginBloc>().add(LoginEmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            fillColor: const Color.fromARGB(30, 37, 193, 102),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(FontAwesomeIcons.solidCircleUser, color: ColorString.eucalyptus),
            labelText: 'Email add',
            errorText: state.email.displayError?.text(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0)
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorString.deepSea, width: 2.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
          )
        );
      }
    );
  }
}