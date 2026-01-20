import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../home.dart';
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
            WalletButtonsRow(accountNumber: context.select((AccountsHomeBloc bloc) => bloc.state.wallet.accountNumber)),
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
                )
              ]
            ),
            const SizedBox(height: 10),
            FavoriteButtonsRow(accountNumber: context.select((AccountsHomeBloc bloc) => bloc.state.wallet.accountNumber)),
            const SizedBox(height: 20),
            AdsWebview(),
            const SizedBox(height: 100),
          ]
        )
      )
    );
  }
}