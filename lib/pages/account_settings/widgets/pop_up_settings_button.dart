import 'package:fcb_pay_plus/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../account_settings.dart';

class PopUpSettingsButton extends StatelessWidget {
  const PopUpSettingsButton({
    super.key,
    required this.account
  });
  final Account account;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      clipBehavior: Clip.antiAlias,
      icon: const Icon(
        FontAwesomeIcons.ellipsis,
        color: Colors.white
      ),
      iconSize: 18,
      onSelected: (value) {
        showDialog(
          context: context, 
          builder: (ctx) => BlocProvider.value(
            value: BlocProvider.of<AccountSettingsBloc>(context),
            child: CustomAlertDialog(
              description: 'Are you sure you want to ${value.name} this account? ', 
              title: 'Confirmation', 
              onPressed: () {
                context.read<AccountSettingsBloc>().add(AccountEventPressed(account: account, method: value));
                Navigator.of(ctx).pop();
              }
            )
          )
        );
      },
      itemBuilder: (context) {
        return Settings.values.map((value) {
          return PopupMenuItem<Settings>(
            value: value,
            child: Text(value.name),
          );
        }).toList();
      }
    );
  }
}