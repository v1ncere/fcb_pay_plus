import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../../data/data.dart';
import '../../local_authentication/local_authentication.dart';
import '../settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: SettingsPage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BiometricCubit(
          localAuth: LocalAuthentication(),
          secureStorageRepository: SecureStorageRepository(storageService: SecureStorageService())
        )
        ..authenticationBiometricChecker()),
        BlocProvider(create: (context) => FingerprintCubit(
          secureStorageRepository: SecureStorageRepository(storageService: SecureStorageService())
        )
        ..getBiometricsStatus())
      ],
      child: const SettingsView()
    );
  }
}