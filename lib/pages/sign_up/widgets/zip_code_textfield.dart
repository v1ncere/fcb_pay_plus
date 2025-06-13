import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';

class ZipCodeTextfield extends StatelessWidget {
  const ZipCodeTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if(state.zipCodeStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.zipCodeStatus.isSuccess) {
          return TextFormField(
            controller: state.zipCodeController,
            keyboardType: TextInputType.number,
            onChanged: (value) => context.read<SignUpBloc>().add(ZipCodeChanged(value)),
            decoration: InputDecoration(
              filled: true,
              border: const UnderlineInputBorder(),
              label: const Text('Zip Code'),
              errorText: state.zipCode.displayError?.text(),
              suffixIcon: !state.zipCode.isPure
              ? IconButton(
                  icon: const Icon(FontAwesomeIcons.xmark),
                  iconSize: 18,
                  onPressed: () => context.read<SignUpBloc>().add(ZipCodeErased()),
                )
              : null,
            ),
            style: const TextStyle(height: 1.5),
          );
        } 
        else {
          return const SizedBox.shrink();  
        }
      },
    );
  }
}