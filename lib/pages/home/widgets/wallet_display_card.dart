import 'package:fcb_pay_plus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';
import 'widgets.dart';

class WalletDisplayCard extends StatelessWidget {
  const WalletDisplayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsHomeBloc, AccountsHomeState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const _CardPadding(child: SingleCardShimmer());
        }
        if (state.status.isSuccess) {
          if (state.wallet != emptyAccount) {
            return (state.wallet != emptyAccount)
            ? walletCard(
                context: context,
                account: state.wallet
              ) 
            : const SizedBox(height: 150);
          }
        }
        if (state.status.isFailure) {
          return SingleCardError(message: state.message);
          // return _ErrorMessageView(message: state.message);
        }
        // default
        return const SizedBox.shrink();
      }
    );
  }
}

class _CardPadding extends StatelessWidget {
  final Widget child;
  const _CardPadding({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: child,
    );
  }
}