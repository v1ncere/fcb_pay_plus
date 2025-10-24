import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../utils/utils.dart';

part 'merchant_add_event.dart';
part 'merchant_add_state.dart';

class MerchantAddBloc extends Bloc<MerchantAddEvent, MerchantAddState> {
  MerchantAddBloc({ 
    required HiveRepository hiveRepository 
  }) : _hiveRepository = hiveRepository,
  super(MerchantAddState()) {
    on<MerchantIsScannerChanged>(_onMerchantIsScannerChanged);
    on<MerchantAddCreated>(_onMerchantAddCreated);
    on<MerchantAddFetched>(_onMerchantAddFetched);
    on<MerchantAddDeleted>(_onMerchantAddDeleted);
  }
  final HiveRepository _hiveRepository;

  void _onMerchantIsScannerChanged(MerchantIsScannerChanged event, Emitter<MerchantAddState> emit) {
    emit(state.copyWith(scanner: event.scanner));
  }

  Future<void> _onMerchantAddCreated(MerchantAddCreated event, Emitter<MerchantAddState> emit) async {
    emit(state.copyWith(createStatus: Status.loading));
    try {
      if (event.data.isEmpty) {
        throw QRCodeFailure.fromCode('qr-empty');
      }
      if (_validateQRCodeCRC(event.data)) {
        final qrObjectList = qrDataParser(event.data);

        if (_validateQRObjects(qrObjectList)) {
          final merchName = getMerchant(qrObjectList, 'main59');
          final merchId = getMerchant(qrObjectList, 'subs2803');
          final merchSubsName = getMerchant(qrObjectList, 'main60');
          
          if (merchName != QRModel.empty && merchId != QRModel.empty && merchSubsName != QRModel.empty) {
            final authUser = await Amplify.Auth.getCurrentUser();
            final allMerchants = await _hiveRepository.getMerchants();
            final myMerchants = allMerchants.where((e) => e.owner == authUser.userId).toList();
            final index = myMerchants.indexWhere((e) => e.id == merchId.data);

            if (index != -1) {
              emit(state.copyWith(createStatus: Status.failure, message: TextString.merchantExists));
            } else {
              _hiveRepository.addMerchant(MerchantModel(
                id: merchId.data, 
                name: merchName.data, 
                qrCode: event.data, 
                tag: merchSubsName.data, 
                owner: authUser.userId,
              ));
              emit(state.copyWith(createStatus: Status.success));
              add(MerchantAddFetched());
            }
          } else {
            emit(state.copyWith(createStatus: Status.failure, message: TextString.noMerchant));
          }
        } else {
          throw QRCodeFailure.fromCode('crc-not-match');
        }
      }
    } on AuthException catch (e) {
      emit(state.copyWith(createStatus: Status.failure, message: e.message));
    } on QRCodeFailure catch (e) {
      emit(state.copyWith(createStatus: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(createStatus: Status.failure, message: e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onMerchantAddFetched(MerchantAddFetched event, Emitter<MerchantAddState> emit) async {
    emit(state.copyWith(fetchStatus: Status.loading));
    try {
      final authUser = await Amplify.Auth.getCurrentUser();
      final allMerchants = await _hiveRepository.getMerchants();
      final myMerchants = allMerchants.where((e) => e.owner == authUser.userId).toList();
      
      if (myMerchants.isNotEmpty) {
        emit(state.copyWith(fetchStatus: Status.success, merchants: myMerchants));
      } else {
        emit(state.copyWith(fetchStatus: Status.failure, message: TextString.empty));
      }
    } catch (e) {
      emit(state.copyWith(fetchStatus: Status.failure, message: e.toString()));     
    }
  }

  Future<void> _onMerchantAddDeleted(MerchantAddDeleted event, Emitter<MerchantAddState> emit) async {
    emit(state.copyWith(fetchStatus: Status.loading));
    try {
      await _hiveRepository.deleteMerchant(event.id);
      emit(state.copyWith(fetchStatus: Status.success));
      add(MerchantAddFetched());
    } catch (e) {
      emit(state.copyWith(fetchStatus: Status.failure, message: e.toString()));
    }
  }

  // *** UTILITY METHODS ***

  QRModel getMerchant(List<QRModel> list, String id) {
    return list.firstWhere((e) => e.id == id, orElse: () => QRModel.empty);
  }
    // validate CRC
  bool _validateQRCodeCRC(String data) {
    int len = data.length; // qr length
    String qrCrcCCITT = data.substring(len - 4); // last 4 characters, location of the CRC
    String calcCrcCCITT = crc16CCITT(data.substring(0, len - 4)); // CRC
    return qrCrcCCITT == calcCrcCCITT;
  }

  // validate qr objects
  bool _validateQRObjects(List<QRModel> qrObjectList) {
    bool id27 = false;
    bool id28 = false;
    bool id2803 = false;
    bool id2804 = false;

    for (final qr in qrObjectList) {
      if (qr.id.substring(0, 6) == 'subs27') {
        id27 = true;
      }
      if (qr.id.substring(0, 6) == 'subs28') {
        id28 = true;
      }
      if (qr.id.contains('subs2803')) {
        id2803 = true;
      }
      if (qr.id.contains('subs2804')) {
        id2804 = true;
      }
    }

    if (id27 && id28) {
      throw QRCodeFailure.fromCode('invalid-mai');
    }
    if (!id2803 && !id2804) {
      throw QRCodeFailure.fromCode('no-merchant-id');
    }
    return true;
  }
}
