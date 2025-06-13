import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../dynamic_viewer.dart';
import 'widgets.dart';

class DropdownDisplay extends StatelessWidget {
  const DropdownDisplay({super.key, required this.pageWidget, required this.focusNode});
  final DynamicWidget pageWidget;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return _isAccountNode(pageWidget)
    ? SourceDropdown(focusNode: focusNode, widget: pageWidget)
    : BlocSelector<WidgetsBloc, WidgetsState, String>(
        selector: (state) => state.uid,
        builder: (context, uid) {
          _dropdownFetch(context, uid, pageWidget);
          return Column(
            children: [
              DynamicDropdown(focusNode: focusNode, widget: pageWidget),
              if (pageWidget.hasExtra ?? false) const ExtraWidgets()
            ]
          );
        }
      );
  }

  // UTILITY FUNCTIONS ***
  bool _isAccountNode(DynamicWidget widget) => (widget.node ?? '').contains('Account');
  
  void _dropdownFetch(BuildContext context, String uid, DynamicWidget widget) {
    context.read<DropdownBloc>().add(DropdownFetched(node: widget.node ?? '', uid: uid));
  }
}