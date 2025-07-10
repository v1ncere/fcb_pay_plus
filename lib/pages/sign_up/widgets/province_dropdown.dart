import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';

class ProvinceDropdown extends StatelessWidget {
  const ProvinceDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.provinceList != current.provinceList
      || previous.province != current.province
      || previous.provinceStatus != current.provinceStatus,
      builder: (context, state) {
        if (state.provinceStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.provinceStatus.isSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Province', style: Theme.of(context).textTheme.labelLarge),
              DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true, // this will align the menu to the button
                  child: DropdownButtonFormField(
                    value: null,
                    hint: Text("Select Province"),
                    onChanged: (value) => context.read<SignUpBloc>().add(ProvinceChanged(value!)),
                    validator: (value) {
                      return value == null
                      ? 'Please select an option.'
                      : null;
                    },
                    items: state.provinceList.map((e) {
                      return DropdownMenuItem<String> (
                        value: fixEncoding(e.name),
                        child: Text(fixEncoding(e.name)),
                        onTap: () {
                          context.read<SignUpBloc>().add(MunicipalFetched(e.code));
                          context.read<SignUpBloc>().add(StatusRefreshed());
                        },
                      );
                    }).toList()
                  )
                )
              )
            ]
          );
        }
        if (state.provinceStatus.isFailure) {
          return Center(
            child: TextButton(
              child: Text(
                TextString.pageError,
                textAlign: TextAlign.center,
              ),
              onPressed: () => context.read<SignUpBloc>().add(ProvinceFetched()),
            )
          );
        }
        // default display
        return const SizedBox.shrink();
      }
    );
  }
}