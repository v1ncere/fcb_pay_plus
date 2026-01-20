import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../login.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password || previous.isObscure != current.isObscure,
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
          obscureText: state.isObscure,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            fillColor: const Color.fromARGB(30, 37, 193, 102),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(FontAwesomeIcons.unlockKeyhole, color: ColorString.eucalyptus),
            labelText: 'Password',
            errorText: state.password.displayError?.text(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorString.deepSea, width: 2.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            suffixIcon: IconButton(
              onPressed: () => context.read<LoginBloc>().add(LoginPasswordObscured()), 
              icon: Icon(
                state.isObscure 
                ? FontAwesomeIcons.eyeSlash
                : FontAwesomeIcons.eye,
                color: Colors.black12,
              )
            )
          )
        );
      }
    );
  }
}