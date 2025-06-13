import 'package:fcb_pay_plus/pages/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';

class BaranggayDropdown extends StatelessWidget {
  const BaranggayDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state.barangayStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.barangayStatus.isSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Barangay', style: Theme.of(context).textTheme.labelLarge),
              DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true, // this will align the menu to the button
                  child: DropdownButtonFormField(
                    value: null,
                    hint: Text("Select Barangay"),
                    onChanged: (value) => context.read<SignUpBloc>().add(BarangayChanged(value!)),
                    validator: (value) {
                      return value == null
                      ? 'Please select an option.'
                      : null;
                    },
                    items: state.barangayList.map((e) {
                      return DropdownMenuItem<String> (
                        value: fixEncoding(e.name),
                        child: Text(fixEncoding(e.name)),
                        onTap: () => context.read<SignUpBloc>().add(ZipCodeFetched()),
                      );
                    }).toList()
                  ),
                ),
              ),
            ],
          );
        }
        if (state.barangayStatus.isFailure) {
          return Center(
            child: Text(state.message)
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}