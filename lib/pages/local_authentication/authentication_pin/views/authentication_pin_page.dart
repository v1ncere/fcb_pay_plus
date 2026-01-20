import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../data/data.dart';
import '../../local_authentication.dart';

class AuthPinPage extends StatelessWidget {
  const AuthPinPage({super.key});
  static final _localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthPinBloc(
          secureStorageRepository: SecureStorageRepository(storageService: SecureStorageService()),
          sqfliteRepositories: SqfliteRepositories(sqfliteService: SqfliteService())
        )),
        BlocProvider(create: (context) => BiometricCubit(secureStorageRepository: SecureStorageRepository(storageService: SecureStorageService()), localAuth: _localAuthentication)
        ..isBiometricUserEnabled()),
        BlocProvider(create: (context) => AuthCheckerBloc(
          secureStorageRepository: SecureStorageRepository(storageService: SecureStorageService()),
          sqfliteRepositories: SqfliteRepositories(sqfliteService: SqfliteService())
        )
        ..add(AuthCheckerPinChecked())),
      ],
      child: const AuthPinView(),
    );
  }
}