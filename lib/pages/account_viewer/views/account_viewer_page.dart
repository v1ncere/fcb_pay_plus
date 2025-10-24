import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../account_viewer.dart';

class AccountViewerPage extends StatelessWidget {
  const AccountViewerPage({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TransactionHistoryBloc()
        ..add(TransactionFetched(accountNumber: account.accountNumber))),
        BlocProvider(create: (context) => FilterBloc()
        ..add(FilterFetched())),
        BlocProvider(create: (context) => AccountButtonBloc()
        ..add(ButtonsFetched(account.accountType!))),
        BlocProvider(create: (context) => AccountsBloc()
        ..add(AccountsFetched(account))
        ..add(AccountsStreamed(account.owner))),
        BlocProvider(create: (context) => CarouselCubit()..setAccount(account: account)),
      ],
      child: AccountViewerView(account: account)
    );
  }
}