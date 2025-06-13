import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../home.dart';
import 'widgets.dart';

class AccountsCardView extends StatelessWidget {
  const AccountsCardView({super.key});
  static final emptyAccount = Account(accountNumber: '', owner: '', ledgerStatus: '');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsHomeBloc, AccountsHomeState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const _CardPadding(child: CardShimmer());
        }
        if (state.status.isSuccess) {
          return ListView(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            children: [
              if (state.wallet != emptyAccount)
                walletCard(
                  context: context,
                  account: state.wallet
                ),
              if (state.savings != emptyAccount) 
                savingsCard(
                  context: context,
                  accountList: state.accountList,
                  account: state.savings
                ),
              if (state.payroll != emptyAccount) 
                savingsCard(
                  context: context,
                  accountList: state.accountList,
                  account: state.payroll
                ),
              if (state.credit != emptyAccount)
                creditCard(
                  context: context,
                  accountList: state.accountList,
                  account: state.credit
                ),
              const SizedBox(height: 150),
            ]
          );
        } 
        if (state.status.isFailure) {
          return _ErrorMessageView(message: state.message);
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

class _ErrorMessageView extends StatelessWidget {
  final String message;
  const _ErrorMessageView({required this.message});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
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
        )
      ]
    );
  }
}