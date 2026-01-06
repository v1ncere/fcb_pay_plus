import 'package:fcb_pay_plus/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account_settings.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountSettingsBloc(
        sqfliteRepositories: SqfliteRepositories(sqfliteService: SqfliteService())
      ),
      child: const AccountSettingsView()
    );
  }
}