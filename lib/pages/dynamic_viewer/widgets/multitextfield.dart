import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../dynamic_viewer.dart';

class MultiTextfield extends StatelessWidget {
  const MultiTextfield({
    super.key,
    required this.widget
  });
  final DynamicWidget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        minLines: 2,
        maxLines: 5,
        maxLength: 100,
        style: const TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w700
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(30, 37, 193, 102),
          labelText: widget.title,
          labelStyle: const TextStyle(color: Colors.black54),
          border: SelectedInputBorderWithShadow(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none
          )
        ),
        onChanged: (value) {
          context.read<WidgetsBloc>().add(
            DynamicWidgetsValueChanged(
              id: widget.id,
              title: widget.title!,
              value: value,
              type: widget.dataType!,
            )
          );
        }
      )
    );
  }
}