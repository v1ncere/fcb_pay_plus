import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/widgets.dart';
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../widgets/widgets.dart';

class AccountViewerView extends StatelessWidget {
  const AccountViewerView({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.goNamed(RouteName.authPin),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            accountTypeNameString(account.accountType!).toUpperCase(),
            style: TextStyle(
              color: ColorString.jewel,
              fontWeight: FontWeight.w700
            )
          ),
          actions: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(FontAwesomeIcons.x, size: 18)
            )
          ],
          automaticallyImplyLeading: false
        ),
        body: ListView(
          children: [
            const CarouselSliderView(),
            const SizedBox(height: 10),
            const AccountDetailsView(),
            const SizedBox(height: 10),
            ActionButtonView(accountNumber: account.accountNumber),
            const SizedBox(height: 20),
            TransactionHistoryView(account: account)
          ]
        )
      )
    );
  }
}