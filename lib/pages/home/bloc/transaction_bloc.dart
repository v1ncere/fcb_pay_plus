import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  StreamSubscription<GraphQLResponse<Transaction>>? subscriptionOnCreate;
  StreamSubscription<GraphQLResponse<Transaction>>? subscriptionOnUpdate;
  StreamSubscription<GraphQLResponse<Transaction>>? subscriptionOnDelete;

  TransactionBloc() : super(TransactionState()) {
    on<TransactionFetched>(_onTransactionFetched);
    on<TransactionOnCreatedStream>(_onTransactionOnCreatedStream);
    on<TransactionOnUpdatedStream>(_onTransactionOnUpdatedStream);
    on<TransactionOnDeletedStream>(_onTransactionOnDeletedStream);
    on<TransactionStreamUpdated>(_onTransactionStreamUpdated);
    on<TransactionRefreshed>(_onTransactionRefreshed);
  }

  Future<void> _onTransactionFetched(TransactionFetched event, Emitter<TransactionState> emit) async {
    await _fetchData(event.accountNumber, emit);
  }

  void _onTransactionOnCreatedStream(TransactionOnCreatedStream event, Emitter<TransactionState> emit) {
    final request = ModelSubscriptions.onCreate(
      Transaction.classType,
      where: Transaction.ACCOUNTNUMBER.eq(event.accountNumber)
    );
    final operation = Amplify.API.subscribe(request);

    subscriptionOnCreate = operation.listen(
      (event) => add(TransactionStreamUpdated(transaction: event.data, isDelete: false)),
      onError: (error) => safePrint(error.toString()),
    );
  }

  void _onTransactionOnUpdatedStream(TransactionOnUpdatedStream event, Emitter<TransactionState> emit) {
    final request = ModelSubscriptions.onUpdate(
      Transaction.classType,
      where: Transaction.ACCOUNTNUMBER.eq(event.accountNumber)
    );
    final operation = Amplify.API.subscribe(request);

    subscriptionOnUpdate = operation.listen(
      (event) => add(TransactionStreamUpdated(transaction: event.data, isDelete: false)),
      onError: (error) => safePrint(error.toString())
    );
  }

  void _onTransactionOnDeletedStream(TransactionOnDeletedStream event, Emitter<TransactionState> emit) {
    final request = ModelSubscriptions.onDelete(
      Transaction.classType,
      where: Transaction.ACCOUNTNUMBER.eq(event.accountNumber)
    );
    final operation = Amplify.API.subscribe(request);

    subscriptionOnDelete = operation.listen(
      (event) => add(TransactionStreamUpdated(transaction: event.data, isDelete: true)),
      onError: (error) => safePrint(error.toString())
    );
  }

  Future<void> _onTransactionStreamUpdated(TransactionStreamUpdated event, Emitter<TransactionState> emit) async {
    final transaction = event.transaction;
    
    if (transaction != null) {
      final newList = List<Transaction>.from(state.transactions);
      final index = newList.indexWhere(
        (e) => e.transDate == transaction.transDate
        && e.referenceId == transaction.referenceId
        && e.transCode == transaction.transCode
        && e.accountNumber == transaction.accountNumber
      );

      if (event.isDelete) {
        if (index != -1) {
          newList.removeAt(index);
        }
      } else {
        if (index != -1) {
          newList[index] = transaction;
        } else {
          newList.add(transaction);
        }
      }

      newList.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      emit(state.copyWith(status: Status.success, transactions: newList));
    }
  }

  FutureOr<void> _onTransactionRefreshed(TransactionRefreshed event, Emitter<TransactionState> emit) {
    _fetchData(event.accountNumber, emit);
  }

  Future<void> _fetchData(String accountNumber, Emitter<TransactionState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final request = ModelQueries.list(
        Transaction.classType,
        where: Transaction.ACCOUNTNUMBER.eq(accountNumber)
      );
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;

      if (items != null && !response.hasErrors) {
        final transactions = items.whereType<Transaction>().toList();
        
        if (transactions.isNotEmpty) {
          emit(state.copyWith(status: Status.success, transactions: transactions));
        } else {
          emit(state.copyWith(status: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }

  @override
  Future<void> close() async {
    subscriptionOnCreate?.cancel();
    subscriptionOnCreate = null;
    subscriptionOnUpdate?.cancel();
    subscriptionOnUpdate = null;
    subscriptionOnDelete?.cancel();
    subscriptionOnDelete = null;
    return super.close();
  }
}
