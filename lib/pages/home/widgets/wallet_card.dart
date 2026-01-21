import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../models/Account.dart';
import '../../../utils/utils.dart';
import '../home.dart';
import 'widgets.dart';

Card walletCard({
  required BuildContext context,
  required Account account
}) {
  return Card(
    elevation: 2.0,
    color: ColorString.eucalyptus,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(AssetString.splashLogo),
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.05),
            BlendMode.dstATop
          ),
          fit: BoxFit.cover,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            ColorString.jewel,
            ColorString.mountainMeadow,
            // ColorString.zombie,
          ],
          stops: const [
            0.5,
            1.0
          ]
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Wallet',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorString.white
                      )
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.zero,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.zero, // const Size(50, 30),
                          padding: EdgeInsets.only(left: 13, right: 13, top: 3, bottom: 3),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text('Top Up',
                              style: TextStyle(fontSize: 12)
                            ),
                            SizedBox(width: 2),
                            Icon(FontAwesomeIcons.anglesUp, size: 12),
                          ]
                        )
                      )
                    )
                  ]
                ),
                const Divider(color: Colors.white30)
              ]
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => context.pushNamed(RouteName.account, extra: account),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildAccountNumber(value: account.accountNumber, type: account.accountType ?? ''),
                      Icon(FontAwesomeIcons.chevronRight, size: 18, color: ColorString.white)
                    ]
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<TransactionBloc, TransactionState>(
                        builder: (context, state) {
                          if (state.status.isLoading) {
                            return TwoLineShimmer();
                          }
                          if (state.status.isSuccess) {
                            return buildDetailsBlock(label: 'AVAILABLE BALANCE', value: Currency.fmt.format(state.transactions.first.balanceCleared ?? 0.0));
                          }
                          if (state.status.isFailure) {
                            return buildDetailsBlock(label: 'AVAILABLE BALANCE', value: Currency.fmt.format(0.0));
                          }
                          return SizedBox.shrink();
                        },
                      )
                    ]
                  )
                ]
              )
            )
          ]
        )
      )
    )
  );
}