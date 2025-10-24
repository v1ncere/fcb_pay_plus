import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc() : super(const TransactionHistoryState(status: Status.loading)) {
    on<SearchTextFieldChanged>(_onSearchTextFieldChanged);
    on<TransactionFetched>(_onTransactionFetched);
  }

  void _onSearchTextFieldChanged(SearchTextFieldChanged event, Emitter<TransactionHistoryState> emit) {
    emit(state.copyWith(searchQuery: Search.dirty(event.searchQuery)));
  }

  Future<void> _onTransactionFetched(TransactionFetched event,  Emitter<TransactionHistoryState> emit) async {
    try {
      final request = ModelQueries.list(Transaction.classType, where: Transaction.ACCOUNT.eq(event.accountNumber)); // transactions specific every account
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;
      
      if (items != null && !response.hasErrors) {
        final transactions = items.whereType<Transaction>().toList();
         
        if (transactions.isNotEmpty) {
          final sortedList = _transactionHandler(list: transactions, search: event.searchQuery, filter: event.filter);
          emit(state.copyWith(status: Status.success, transactionList: sortedList));
        } else {
          emit(state.copyWith(status: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }

  // *** UTILITY METHODS ***

  List<Transaction> _transactionHandler({required List<Transaction> list, required String search, required String filter}) {
    final searchQuery = search.trim().toLowerCase();
    final filterQuery = filter.trim().toLowerCase();
    List<Transaction> newList = List<Transaction>.from(list);
    
    if (filterQuery.isNotEmpty) {
      if (filterQuery == 'newest') {
        newList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      } else if (filterQuery == 'oldest') {
        newList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      } 
      // else {
      //   newList = newList.where((e) => e.accountType!.trim().toLowerCase().contains(filterQuery)).toList();
      // }
    }

    if (search.isNotEmpty) {
      // TODO: from details(removed from table) to accountNumber
      newList = newList.where((e) => e.accountNumber.toLowerCase().contains(searchQuery)).toList();
    }
    // return filtered list
    return newList;
  }
}
