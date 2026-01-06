import 'package:fcb_pay_plus/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../scanner_transaction.dart';

class ScannerTransactionPage extends StatelessWidget {
  const ScannerTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ScannerTransactionBloc(
          secureStorage: SecureStorageRepository(
            storageService: SecureStorageService()
          ),
        )
        ..add(ScannerTransactionDisplayLoaded())),
      ],
      child: const ScannerTransactionView()
    );
  }
}