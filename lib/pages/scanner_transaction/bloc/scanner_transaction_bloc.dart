import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../data/data.dart';
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'scanner_transaction_event.dart';
part 'scanner_transaction_state.dart';

final emptyAccount = Account(accountNumber: '', owner: '');

class ScannerTransactionBloc extends Bloc<ScannerTransactionEvent, ScannerTransactionState> {
  final SecureStorageRepository _secureStorage;
  ScannerTransactionBloc({
    required SecureStorageRepository secureStorage,
  }) : _secureStorage = secureStorage,
  super(ScannerTransactionState(account: emptyAccount)) {
    on<ScannerSourceAccountFetched>(_onScannerSourceAccountFetched);
    on<ScannerTransactionDisplayLoaded>(_onScannerTransactionDisplayLoaded);
    on<ScannerAmountValueChanged>(_onScannerAmountValueChanged);
    on<ScannerExtraWidgetValueChanged>(_onScannerExtraWidgetValueChanged);
    on<ScannerTransactionSubmitted>(_onScannerTransactionSubmitted);
    on<ScannerTipValueChanged>(_onScannerTipValueChanged);
  }

  Future<void> _onScannerSourceAccountFetched(ScannerSourceAccountFetched event, Emitter<ScannerTransactionState> emit) async {
    emit(state.copyWith(accountStatus: Status.loading));
    try {
      final authUser = await Amplify.Auth.getCurrentUser();
      final request = ModelQueries.get(Account.classType, AccountModelIdentifier(accountNumber: authUser.userId));
      final response = await Amplify.API.query(request: request).response;
      final account = response.data;

      emit(
        account != null && !response.hasErrors
        ? state.copyWith(accountStatus: Status.success, account: account)
        : state.copyWith(accountStatus: Status.failure, message: response.errors.first.message)
      );
    } on AuthException catch (e) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.message));
    } on ApiException catch (e) {
      emit(state.copyWith(accountStatus: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(accountStatus: Status.failure, message: TextString.error));
    }
  }

  Future<void> _onScannerTransactionDisplayLoaded(ScannerTransactionDisplayLoaded event, Emitter<ScannerTransactionState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final dataList = List<QrData>.from(await _secureStorage.getScannedQr() ?? []);
      
      if (dataList.isNotEmpty) {
        emit(state.copyWith(status: Status.success, qrDataList: dataList));

        final index2805 = dataList.indexWhere((e) => e.id == 'subs2805'); // Proxy-Notify Flags
        if (index2805 != -1) {
          final newList = List<QrData>.from(dataList);
          emit(state.copyWith(notifyFlag: newList[index2805].data));
        }

        final index54 = dataList.indexWhere((e) => e.id == 'main54'); // transaction amount
        if (index54 != -1) {
          final newList = List<QrData>.from(dataList);
          add(ScannerAmountValueChanged(newList[index54].data));
        }

        final index55 = dataList.indexWhere((e) => e.id == 'main55'); // tip
        if (index55 != -1) {
          final newList = List<QrData>.from(dataList);
          
          switch(newList[index55].data) {
            case '01':
              emit(state.copyWith(tip: ''));
              break;
            case '02':
              final index56 = dataList.indexWhere((e) => e.id == 'main56');
              if(index56 != -1) {
                final newList = List<QrData>.from(dataList);
                emit(state.copyWith(tip: newList[index56].data));
              }
              break;
            case '03':
              final index57 = dataList.indexWhere((e) => e.id == 'main57');
              if(index57 != -1) {
                final newList = List<QrData>.from(dataList);
                emit(state.copyWith(tip: newList[index57].data));
              }
              break;
          }
        }
      } else {
        emit(state.copyWith(status: Status.failure, message: TextString.empty));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  void _onScannerTipValueChanged(ScannerTipValueChanged event, Emitter<ScannerTransactionState> emit) {
    emit(state.copyWith(tip: event.tip));
  }

  void _onScannerAmountValueChanged(ScannerAmountValueChanged event, Emitter<ScannerTransactionState> emit) {
    emit(state.copyWith(inputAmount: Amount.dirty(event.amount)));
  }

  void _onScannerExtraWidgetValueChanged(ScannerExtraWidgetValueChanged event, Emitter<ScannerTransactionState> emit) {
    final index = state.qrDataList.indexWhere((e) => e.id == event.id);

    if (index != -1) {
      final newList = List<QrData>.from(state.qrDataList);
      newList[index] = newList[index].copyWith(data: event.data); // update list data base on new [event.data]
      emit(state.copyWith(qrDataList: newList));
    } else {
      if (event.id == 'subs6209A' || event.id == 'subs6209M' || event.id == 'subs6209E') {
        final newList = List<QrData>.from(state.qrDataList);
        newList.add(QrData(
          id: event.id,
          title: event.title,
          data: event.data,
          widget: event.widget
        ));
        emit(state.copyWith(qrDataList: newList));
      }
    }
  }

  Future<void> _onScannerTransactionSubmitted(ScannerTransactionSubmitted event, Emitter<ScannerTransactionState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      if (_allExtraFieldsValid()) { // check if all extra fields are valid
        try {
          final qrMap = _getFormSubmissionData();
          final qrExtraMap = _extraFieldSubmissionData();
          final index = state.qrDataList.indexWhere((e) => e.id == 'main55');
          final authUser = await Amplify.Auth.getCurrentUser();
          
          if (index != -1) {
            qrMap.addAll({
              'SourceAccount': state.account.accountNumber,
              'Amount': state.inputAmount.value,
              'TipCon': state.tip
            });
          } else {
            qrMap.addAll({
              'SourceAccount': state.account.accountNumber, 
              'Amount': state.inputAmount.value
            });
          }

          // transaction in Map
          final Map<String, dynamic> transaction = {
            "DynamicWidgets": qrMap,
            if (_containsExtraFields())
              "ExtraWidgets": qrExtraMap,
            "TransactionType": 'payment',
            "Owner": authUser.userId,
          };
          const graphQLDocument = '''
            query ProcessTransaction(\$data: AWSJSON!) {
              processTransaction(data: \$data)
            }
          ''';
          final echoRequest = GraphQLRequest<String>(
            document: graphQLDocument, 
            variables: <String, dynamic> {
              "data": jsonEncode(_cleanMap(transaction))
            }
          );
          final response = await Amplify.API.query(request: echoRequest).response;
            
          if (!response.hasErrors) {
            final Map<String, dynamic> jsonMap = jsonDecode(response.data!);
            final process = ProcessTransactionResponse.fromJson(jsonMap);

            if (process.processTransaction.isSuccess) {
              emit(state.copyWith(formStatus: FormzSubmissionStatus.success, receiptId: process.processTransaction.data!.receiptId));
            } else {
              emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: process.processTransaction.error));
            }
          } else {
            emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: response.errors.first.message));
          }
        } on AuthException catch (e) {
          emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.message));
        } on ApiException catch (e) {
          emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.message));
        } catch (e) {
          emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.toString()));
        }
      } else {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: TextString.incompleteForm));
      }
    } else {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: TextString.incompleteForm));
    }
  }

  // UTILITY METHODS ***
  Map<String, dynamic> _cleanMap(Map<String, dynamic> map) {
    final Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      if (value == null || (value is Map && value.isEmpty)) {
        return; // Skip nulls
      }
      newMap[key] = value; // Otherwise keep
    });
    return newMap;
  }

  bool _containsExtraFields() => state.qrDataList.any((e) => e.widget == 'textfield'); // check if textfields exist

  bool _allExtraFieldsValid() {
    final extraFields = state.qrDataList.where((e) => e.widget == 'textfield');
    return extraFields.isEmpty || extraFields.every((e) => e.data.isNotEmpty);
  }

  Map<String, dynamic> _extraFieldSubmissionData() {
    final Map<String, dynamic> map = {};

    for (final e in state.qrDataList) {
      if (e.widget == 'textfield') {
        map[e.data] = e.data;
      }
    }
    return map;
  }

  Map<String, dynamic> _getFormSubmissionData() {
    final Map<String, dynamic> map = {};
    final pos1 = int.parse(state.notifyFlag.substring(0, 1));

    for (final e in state.qrDataList) {
      if (e.id == 'main59') {
        map[e.title] = e.data;
      }
      if (e.id == 'subs2803' && pos1 == 3) {
        map[e.title] = e.data;
      }
      if (e.id == 'subs2804') {
        map[e.title] = e.data;
      }
      if (e.id == 'subs6205') {
        map[e.title] = e.data;
      }
    }
    return map;
  }
}