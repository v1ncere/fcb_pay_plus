import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../../home/home.dart';
import '../dynamic_viewer.dart';

class SourceDropdown extends StatelessWidget {
  const SourceDropdown({super.key, required this.accountNumber, required this.dynamicWidget, required this.focusNode});
  final String? accountNumber;
  final DynamicWidget dynamicWidget;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsHomeBloc, AccountsHomeState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.status.isSuccess) {
          final list = state.accountList.where((e) => e.accountType?.toLowerCase() != "plc" && e.accountNumber != accountNumber).toList(); 
          return Padding(
            padding: const EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField<String>(
                focusNode: focusNode,
                isExpanded: true,
                isDense: false,
                icon: const Icon(
                  FontAwesomeIcons.caretDown, 
                  color: Colors.green,
                  size: 16
                ),
                dropdownColor: Colors.white,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
                borderRadius: BorderRadius.circular(10.0),
                decoration: InputDecoration(
                  label: Text(dynamicWidget.title!),
                  filled: true,
                  fillColor: ColorString.algaeGreen,
                  border: SelectedInputBorderWithShadow(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  )
                ),
                onChanged: (value) {
                  context.read<WidgetsBloc>().add(
                    DynamicWidgetsValueChanged(
                      id: dynamicWidget.id,
                      title: dynamicWidget.title!,
                      value: value!,
                      type: dynamicWidget.dataType!,
                    )
                  );
                },
                selectedItemBuilder: (context) {
                  return list.map((item) {
                    final bal = 0.0; // TODO: get from Transaction table
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(accountTypeNameString(item.accountType!)),
                        Text("***${item.accountNumber.substring(item.accountNumber.length - 4)}"),
                        Text('${Currency.php}${(bal).toStringAsFixed(2).replaceAllMapped(Currency.reg, Currency.mathFunc)}'),
                      ]
                    );
                  }).toList();
                },
                items: list.map((item) {
                  final bal = 0.0; // TODO: get from Transaction table
                  return DropdownMenuItem<String> (
                    value: item.accountNumber.toString(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(accountTypeNameString(item.accountType!)),
                        Text("***${item.accountNumber.substring(item.accountNumber.length - 4)}"),
                        Text('${Currency.php}${(bal).toStringAsFixed(2).replaceAllMapped(Currency.reg, Currency.mathFunc)}'),
                        const Divider()
                      ]
                    )
                  );
                }).toList()
              )
            )
          );
        }
        if (state.status.isFailure) {
          return Center(
            child: Text(state.message,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w900,
                fontSize: 16.0
              )
            )
          );
        }
        // default display
        return const SizedBox.shrink();
      }
    );
  }
}

