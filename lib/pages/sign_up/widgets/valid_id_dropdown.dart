import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

import '../sign_up.dart';
import '../../../utils/utils.dart';

class ValidIdDropdown extends StatelessWidget {
  const ValidIdDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.validIDTitle != current.validIDTitle,
      builder: (context, state) {
        return DropdownButtonFormField(
          initialValue: state.validIDTitle.value,
          decoration: InputDecoration(
            labelText: 'Valid ID',
            labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            errorText: state.validIDTitle.displayError?.text(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: ColorString.eucalyptus, width: 2.0)
            )
          ),
          items: validIDJson.map((item) {
            String idName = item.keys.first;
            String idValue = item[idName]?['id'] ?? '';
            return DropdownMenuItem(
              value: idValue,
              child: Text(idName)
            );
          }).toList(),
          onChanged: (value) => context.read<SignUpBloc>().add(ValidIDTitleChanged(value!)),
        );
      }
    );
  }
}