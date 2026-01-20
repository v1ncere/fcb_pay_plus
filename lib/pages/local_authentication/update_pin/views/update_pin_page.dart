import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data.dart';
import '../update_pin.dart';

class UpdatePinPage extends StatelessWidget {
  const UpdatePinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePinBloc(
        secureStorageRepository: SecureStorageRepository(storageService: SecureStorageService()),
        sqfliteRepositories: SqfliteRepositories(sqfliteService: SqfliteService())
      ),
      child: const UpdatePinView()
    );
  }
}