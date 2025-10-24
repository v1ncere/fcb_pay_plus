import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../bloc/merchant_add_bloc.dart';
import '../merchant_add.dart';

class MerchantAddPage extends StatelessWidget {
  const MerchantAddPage({super.key});
  static final _hiveRepository = HiveRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MerchantAddBloc(hiveRepository: _hiveRepository)..add(MerchantAddFetched()),
      child: MerchantAddView(),
    );
  }
}
