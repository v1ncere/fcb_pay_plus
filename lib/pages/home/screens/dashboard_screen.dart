import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalletDisplayCard(),
            const SizedBox(height: 20),
            const ButtonShimmer(), // TODO: remove when buttons load
            // ButtonsGridView(accountNumber: context.select((AccountsHomeBloc state) => state.state.uid)), // TODO: change to account number base on what used as wallet account
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Favorites",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorString.eucalyptus,
                    fontSize: 16
                  )
                ),
                SizedBox(width: 2),
                Icon(
                  FontAwesomeIcons.solidStar,
                  color: ColorString.eucalyptus,
                  size: 14,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const ButtonShimmer(), // TODO: remove when buttons load
            // ButtonsGridView(accountNumber: context.select((AccountsHomeBloc state) => state.state.uid)), // TODO: change to account number base on what used as wallet account
            const SizedBox(height: 20),
            AdsWebview(),
            const SizedBox(height: 100),
          ]
        )
      )
    );
  }
}

class _ErrorMessageView extends StatelessWidget {
  final String message;
  const _ErrorMessageView({required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            )
          )
        )
      )
    );
  }
}