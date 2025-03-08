import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/custom_widgets/custom_widgets.dart';

class ProvinceDropdown extends StatelessWidget {
  const ProvinceDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownBloc, DropdownState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.status.isSuccess) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: CustomDropdownButton(
              value: null,
              hint: Text(widget.title!),
              onChanged: (value) {
                context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
                  id: widget.id,
                  title: widget.title!,
                  type: widget.dataType!,
                  value: value!
                ));
              },
              validator: (value) {
                return value == null
                ? 'Please select an option.'
                : null;
              },
              items: state.dropdowns.map((item) {
                return DropdownMenuItem<String> (
                  value: item.toString(),
                  child: Text(item.replaceAll('_', ' ')),
                  onTap: () => context.read<WidgetsBloc>().add(ExtraWidgetFetched(item.toString())),
                );
              }).toList()
            )
          );
        }
        if (state.status.isFailure) {
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