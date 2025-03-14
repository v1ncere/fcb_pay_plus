import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../sign_up.dart';

class MunicipalityDropdown extends StatelessWidget {
  const MunicipalityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state.cityMunicipalStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.cityMunicipalStatus.isSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('City/Municipality', style: Theme.of(context).textTheme.labelLarge),
              DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true, // this will align the menu to the button
                  child: DropdownButtonFormField(
                    value: null,
                    hint: Text("Select City/Municipality"),
                    onChanged: (value) => context.read<SignUpBloc>().add(CityMunicipalityChanged(value!)),
                    validator: (value) {
                      return value == null
                      ? 'Please select an option.'
                      : null;
                    },
                    items: state.cityMunicipalityList.map((e) {
                      return DropdownMenuItem<String> (
                        value: fixEncoding(e.name),
                        child: Text(fixEncoding(e.name)),
                        onTap: () => context.read<SignUpBloc>().add(BarangayFetched(e.code)),
                      );
                    }).toList()
                  ),
                ),
              ),
            ],
          );
        }
        if (state.cityMunicipalStatus.isFailure) {
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