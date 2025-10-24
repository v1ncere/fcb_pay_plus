import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../dynamic_viewer.dart';
import 'widgets.dart';

class DropdownDisplay extends StatelessWidget {
  const DropdownDisplay({super.key, required this.accountNumber, required this.dynamicWidget, required this.focusNode});
  final String? accountNumber;
  final DynamicWidget dynamicWidget;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return _isAccountDropdown(dynamicWidget)
    ? SourceDropdown(accountNumber: accountNumber, focusNode: focusNode, dynamicWidget: dynamicWidget)
    : BlocSelector<WidgetsBloc, WidgetsState, String>(
        selector: (state) => state.uid,
        builder: (context, uid) {
          // *** fetch dropdown data ***
          context.read<DropdownBloc>().add(DropdownFetched(node: dynamicWidget.node ?? '', uid: uid));
          return Column(
            children: [
              DynamicDropdown(focusNode: focusNode, dynamicWidget: dynamicWidget),
              if (dynamicWidget.hasExtra ?? false) const ExtraWidgets(),
            ]
          );
        }
      );
  }

  // *** UTILITY FUNCTIONS ***
  bool _isAccountDropdown(DynamicWidget widget) {
    final isAccount = (widget.node ?? '').contains('Account');
    final isDropdown = (widget.widgetType ?? '') == 'dropdown';
    return isAccount && isDropdown;
  }
}