import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_up.dart';
import '../../../utils/utils.dart';

class ValidIdDropdown extends StatelessWidget {
  const ValidIdDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Valid ID', style: Theme.of(context).textTheme.headlineSmall),
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField(
              value: null,
              hint: Text("Select Valid ID"),
              validator: (value) {
                return value == null
                ? "Please select an option."
                : null;
              },
              items: validIDJson.map((item) {
                String idName = item.keys.first;
                String idValue = item[idName]?['id'] ?? '';
                return DropdownMenuItem(
                  value: idValue,
                  child: Text(idName)
                );
              }).toList(),
              onChanged: (value) => context.read<SignUpBloc>().add(ValidIDTitleChanged(value!)),
            ),
          ),
        )
      ],
    );
  }
}