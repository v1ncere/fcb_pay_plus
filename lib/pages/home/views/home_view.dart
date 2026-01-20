import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class AccountHomeView extends StatelessWidget {
  const AccountHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        appBar: homeAppBar(context),
        body: RefreshIndicator(
          onRefresh: () async => context.read<AccountsHomeBloc>().add(AccountsHomeRefreshed()),
          child: TabBarView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [
              DashboardScreen(),
              AccountScreen(),
            ]
          )
        )
      )
    );
  }
}