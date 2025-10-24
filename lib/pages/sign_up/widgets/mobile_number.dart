import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';
import 'widgets.dart';

class MobileNumber extends StatelessWidget {
  const MobileNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.mobile != current.mobile
      || previous.mobileController != current.mobileController,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mobile Number',
              style: TextStyle(
                color: ColorString.jewel,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.0),
            CustomTextformfield(
              controller: state.mobileController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, Group334Formatter()],
              keyboardType: TextInputType.phone,
              onChanged: (value) => context.read<SignUpBloc>().add(MobileNumberChanged(value.replaceAll(' ', ''))),
              hintText: 'xxx xxx xxxx',
              prefixIcon: Padding( // visible in unfocused, because Text is not visible in prefix
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '+63',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
              errorText: state.mobile.displayError?.text(),
              suffixIcon: !state.mobile.isPure
              ? IconButton(
                  icon: const Icon(FontAwesomeIcons.xmark),
                  iconSize: 18,
                  onPressed: () => context.read<SignUpBloc>().add(MobileTextErased())
                )
              : null,
            ),
          ],
        );
      }
    );
  }
}