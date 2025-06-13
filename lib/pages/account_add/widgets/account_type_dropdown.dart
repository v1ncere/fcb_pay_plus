import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../bloc/account_add_bloc.dart';

class AccountTypeDropdown extends StatelessWidget {
  AccountTypeDropdown({super.key});
  
  final List<AccountType> visibleAccountTypes = AccountType.values.where((type) {
    return type == AccountType.psa || type == AccountType.ppr || type == AccountType.plc;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountAddBloc, AccountAddState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please choose the type of product',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  hint: const Text('Select a product'),
                  borderRadius: BorderRadius.circular(15),
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none)
                  ),
                  onChanged: (value) => context.read<AccountAddBloc>().add(AccountTypeDropdownChanged(value!)),
                  items: visibleAccountTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      enabled: !type.isUnknown,
                      child: type.isUnknown ? _accountTitle() : Text(accountTypeName(type))
                    );
                  }).toList(),
                )
              )
            )
          ],
        ); 
      }
    );
  }

  // UTILITY METHODS
  Widget _accountTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Type', 
          style: TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
        Divider()
      ]
    );
  }
}