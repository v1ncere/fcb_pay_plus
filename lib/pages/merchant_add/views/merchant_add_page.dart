import 'package:fcb_pay_plus/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/merchant_add_bloc.dart';
import '../merchant_add.dart';

class MerchantAddPage extends StatelessWidget {
  const MerchantAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MerchantAddBloc(
        sqfliteRepositories: SqfliteRepositories(sqfliteService: SqfliteService())
      )..add(MerchantAddFetched()),
      child: MerchantAddView(),
    );
  }
}
