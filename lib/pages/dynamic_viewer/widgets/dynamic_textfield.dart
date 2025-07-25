import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../dynamic_viewer.dart';

class DynamicTextfield extends StatelessWidget {
  const DynamicTextfield({
    super.key,
    required this.widget
  });
  final DynamicWidget widget;
  static final _regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');

  @override
  Widget build(BuildContext context) {
    switch(widget.dataType) {
      case 'int':
        return _intTextField(context);
      case 'string':
        return _stringTextfield(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _intTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: CustomTextFormField(
        title: widget.title!,
        inputFormatters: <ThousandsFormatter>[ThousandsFormatter(allowFraction: true)],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return value?.isEmpty == true
          ? TextString.dynamicAmountRequired
          : _regex.hasMatch(value!)
            ? null
            : TextString.dynamicAmountInvalid;
        },
        onChanged: (value) {
          context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
            id: widget.id,
            title: widget.title!,
            value: value,
            type: widget.dataType!,
          ));
        }
      )
    );
  }

  Widget _stringTextfield(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: CustomTextFormField(
        title: widget.title!,
        validator: (value) {
          return value?.isEmpty == true 
          ? TextString.dynamicEmptyFields
          : null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
            id: widget.id,
            title: widget.title!,
            value: value,
            type: widget.dataType!,
          ));
        }
      )
    );
  }
}