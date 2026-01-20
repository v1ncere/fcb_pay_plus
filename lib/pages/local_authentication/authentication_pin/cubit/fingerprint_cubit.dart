import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data.dart';

part 'fingerprint_state.dart';

class FingerprintCubit extends Cubit<FingerprintState> {
  final SecureStorageRepository _secureStorageRepository;
  FingerprintCubit({
    required SecureStorageRepository secureStorageRepository,
  }) : _secureStorageRepository = secureStorageRepository,
  super(const FingerprintState());

  Future<void> getBiometricsStatus() async {
    emit(state.copyWith(status: FingerprintStatus.loading));
    try {
      final biometric = await _secureStorageRepository.getBiometricStatus();
      emit(state.copyWith(status: FingerprintStatus.success, biometric: biometric == 1));
    } catch (_) {
      emit(state.copyWith(status: FingerprintStatus.failure));
    }
  }

  void toggleBiometricStatus() async {
    try {
      _secureStorageRepository.saveBiometricStatus(state.biometric ? 0 : 1);
      emit(state.copyWith(biometric: !state.biometric));
    } catch (_) {
      emit(state.copyWith(status: FingerprintStatus.failure));
    }
  }
}
