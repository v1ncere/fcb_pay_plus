import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../sign_up.dart';
import 'custom_textformfield.dart';

class AccountAliasTextfield extends StatelessWidget {
  const AccountAliasTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Alias',
              style: TextStyle(
                color: state.isPitakardExist ? ColorString.jewel : Colors.grey.shade600,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.0),
            CustomTextformfield(
              enabled: state.isPitakardExist,
              controller: state.accountAliasController,
              keyboardType: TextInputType.name,
              hintText: 'Example: Love\'s Savings',
              errorText: state.accountAlias.displayError?.text(),
              suffixIcon: !state.accountAlias.isPure
              ? IconButton(
                  icon: const Icon(FontAwesomeIcons.xmark),
                  iconSize: 18,
                  onPressed: () => context.read<SignUpBloc>().add(AccountAliasErased())
                )
              : null,
              onChanged: (value) => context.read<SignUpBloc>().add(AccountAliasChanged(value))
            ),
            SizedBox(height: 2.0),
            Text(
              'Assign an alias for your linked account.',
              style: TextStyle(
                color: state.isPitakardExist ? ColorString.jewel : Colors.grey.shade600,
                fontSize: 12
              )
            )
          ]
        );
      }
    );
  }
}