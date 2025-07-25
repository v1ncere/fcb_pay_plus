import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/Account.dart';
import '../../../utils/utils.dart';

PopupMenuButton settingsPopUp ({
  required String type,
  required List<Account> accountList,
  required void Function(dynamic)? onSelected
}) {
  return PopupMenuButton(
    tooltip: 'Select account to be displayed',
    onSelected: onSelected,
    itemBuilder: (context) {
      final newList = accountList.where((e) => e.type == type).toList();
      return newList.map((value) {
        return PopupMenuItem<Account>(
          value: value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAccountNumber(type: value.type ?? '', value: value.accountNumber),
              _detailsBlock(label: 'CARD HOLDER', value: value.ownerName ?? ''),
              const Divider(color: Colors.black12)
            ]
          )
        );
      }).toList();
    },
    child: Icon(
      FontAwesomeIcons.arrowRightArrowLeft,
      color: ColorString.mystic,
      size: 16,
      shadows: <Shadow>[
        Shadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 3,
          offset: const Offset(0, 1.5)
        )
      ]
    )
  );
}

Column _buildAccountNumber({
  required String value,
  required String type
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      CustomText(
        text: 'ACCOUNT NO.',
        color: ColorString.emerald,
        fontSize: 8,
        fontWeight: FontWeight.bold
      ),
      CustomText(
        text: maskedNum(value),
        color: ColorString.deepSea,
        fontSize: 14
      ),
      CustomText(
        text: type.toUpperCase(),
        color: ColorString.emerald,
        fontSize: 8,
        fontWeight: FontWeight.bold
      )
    ]
  );
}

Column _detailsBlock({
  required String label,
  required String value
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        value.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorString.deepSea,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          shadows: <Shadow>[
            Shadow(
              color: Colors.black.withValues(alpha: 0.15), // Shadow color
              blurRadius: 1,
              offset: const Offset(0, 0.5)
            )
          ]
        )
      ),
      CustomText(
        text: label.toUpperCase(),
        color: ColorString.emerald,
        fontSize: 8,
        fontWeight: FontWeight.bold
      )
    ]
  );
}
