import 'package:flutter/material.dart';

import '../../../models/ModelProvider.dart' hide AccountType;
import '../../../utils/utils.dart';
import 'widgets.dart';

class ExtraDisplaySavings extends StatelessWidget {
  const ExtraDisplaySavings({super.key, required this.account});
  final Account account;
  final bal = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        mainInfoBlock(label: 'AVAILABLE BALANCE', value: Currency.fmt.format(bal)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Table(
            columnWidths: const <int, TableColumnWidth> {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2)
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              tableRow(label: 'ACCOUNT TYPE', value: accountTypeNameString(account.accountType!)),
              tableRow(label: 'ACCOUNT NUMBER', value: account.accountType ==  AccountType.wallet.name
              ? maskedNum(account.accountNumber)
              : account.accountNumber)
            ]
          )
        )
      ]
    );
  }
}

TableRow tableRow({
  required String label,
  required String value,
}) {
  return TableRow(
    children: [
      Text(
        label,
        style: TextStyle(
          color: ColorString.eucalyptus,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
              color: Colors.black.withValues(alpha: 0.15), // Shadow color
              blurRadius: 1,
              offset: const Offset(0, 1)
            )
          ]
        ),
      ),
      Text(
        value,
        style: TextStyle(
          color: ColorString.eucalyptus,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          shadows: <Shadow>[
            Shadow(
              color: Colors.black.withValues(alpha: 0.15), // Shadow color
              blurRadius: 1,
              offset: const Offset(0, 1)
            )
          ]
        )
      )
    ]
  );
}