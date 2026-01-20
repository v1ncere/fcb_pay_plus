import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../sign_up.dart';
import 'widgets.dart';

class AccountCardTextfield extends StatelessWidget {
  const AccountCardTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Number',
              style: TextStyle(
                color: state.isPitakardExist ? ColorString.jewel : Colors.grey.shade600,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.0),
            CustomTextformfield(
              inputFormatters: [
                NumberSeparatorFormatter(),
                LengthLimitingTextInputFormatter(19)
              ],
              enabled: state.isPitakardExist,
              controller: state.accountNumberController,
              keyboardType: TextInputType.number,
              hintText: '14-16 digit account number',
              errorText: state.accountNumber.displayError?.text(),
              suffixIcon: !state.accountNumber.isPure
              ? IconButton(
                  icon: const Icon(FontAwesomeIcons.xmark),
                  iconSize: 18,
                  onPressed: () => context.read<SignUpBloc>().add(AccountNumberErased())
                )
              : null,
              onChanged: (value) => context.read<SignUpBloc>().add(AccountNumberChanged(value)),
            ),
            SizedBox(height: 2.0),
            Text(
              'This can either be your 14-digit account number or 16-digit PITAKArd number.',
              style: TextStyle(
                color: state.isPitakardExist ? ColorString.jewel : Colors.grey.shade600,
                fontSize: 12
              ),
            ),
          ],
        );
      },
    );
  }
}