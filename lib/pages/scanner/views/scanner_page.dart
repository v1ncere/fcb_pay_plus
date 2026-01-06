import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../cubit/scanner_cubit.dart';
import '../scanner.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScannerCubit(
        secureStorage: SecureStorageRepository(
          storageService: SecureStorageService()
        )
      ),
      child: const ScannerView()
    );
  }
}
