import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../bloc/account_add_bloc.dart';

class AccountNumberInput extends StatelessWidget {
  const AccountNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountAddBloc, AccountAddState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Number',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            TextFormField(
              inputFormatters: [
                //NumberSeparatorFormatter(),
                CardNumberSeparatorFormatter(),
                LengthLimitingTextInputFormatter(17)
              ],
              keyboardType: TextInputType.number,
              maxLength: 17,
              decoration: InputDecoration(
                filled: true,
                labelText: '000-0000-000000-0',
                errorText: state.accountNumber.displayError?.text(),  
              ),
              style: const TextStyle(height: 1.5),
              onChanged: (value) => context.read<AccountAddBloc>().add(AccountNumberChanged(value))
            )
          ]
        );
      }
    );
  }
}