import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data.dart';
import '../../local_authentication.dart';

class CreatePinPage extends StatelessWidget {
  const CreatePinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePinBloc(
        secureStorageRepository: SecureStorageRepository(storageService: SecureStorageService()),
        sqfliteRepositories: SqfliteRepositories(sqfliteService: SqfliteService())
      ),
      child: const CreatePinView(),
    );
  }
}