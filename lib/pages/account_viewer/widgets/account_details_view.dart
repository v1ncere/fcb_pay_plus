import 'package:fcb_pay_plus/utils/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../account_viewer.dart';
import 'widgets.dart';

class AccountDetailsView extends StatelessWidget {
  const AccountDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselCubit, CarouselState>(
      builder: (context, state) {
        final type = state.account.type!.toLowerCase();
        if (type == AccountType.wlt.name
        || type ==  AccountType.psa.name
        || type ==  AccountType.ppr.name) {
          return ExtraDisplaySavings(account: state.account);
        }
        if (type ==  AccountType.plc.name) {
          return ExtraDisplayCredit(account: state.account);
        }
        // default display
        return const SizedBox.shrink();
      }
    );
  }
}