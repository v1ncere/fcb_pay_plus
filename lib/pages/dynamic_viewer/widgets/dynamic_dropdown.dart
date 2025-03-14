import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../dynamic_viewer.dart';

class DynamicDropdown extends StatelessWidget {
  const DynamicDropdown({
    super.key,
    required this.widget,
    required this.focusNode
  });
  final DynamicWidget widget;
  final FocusNode focusNode;

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
              focusNode: focusNode,
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