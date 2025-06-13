import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

final emptyAccount = Account(accountNumber: '', owner: '', ledgerStatus: '');

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc() : super(const AccountsState()) {
    on<AccountsFetched>(_onAccountsFetched);
    on<AccountsStreamed>(_onAccountsStreamed);
    on<AccountsStreamedUpdate>(_onAccountsStreamedUpdate);
    on<AccountsStreamedFailed>(_onAccountsStreamedFailed);
  }
  StreamSubscription<GraphQLResponse<Account>>? subscription;

  Future<void> _onAccountsFetched(AccountsFetched event, Emitter<AccountsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final request = ModelQueries.list(Account.classType, where: Account.OWNER.eq(event.account.owner));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;
      
      if (items != null && !response.hasErrors) {
        final accounts = items.whereType<Account>().toList();
        
        if (accounts.isNotEmpty) {
          final sameType = accounts.where((e) => e.type == event.account.type).toList();
          final first = sameType.firstWhere((e) => e.accountNumber == event.account.accountNumber); // account specified by user to display first
          final others = sameType.where((e) => e.accountNumber != event.account.accountNumber).toList(); // other remaining Accounts
          emit(state.copyWith(status: Status.success, accountList: [first, ...others]));
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

  Future<void> _onAccountsStreamed(AccountsStreamed event, Emitter<AccountsState> emit) async {
    final subscriptionRequest = ModelSubscriptions.onUpdate(Account.classType, where: Account.OWNER.eq(event.userId));
    final operation = Amplify.API.subscribe(subscriptionRequest);
    subscription = operation.listen(
      (event) => add(AccountsStreamedUpdate(event.data)),
      onError: (error) => safePrint(error.toString())
    );
  }

  void _onAccountsStreamedUpdate(AccountsStreamedUpdate event, Emitter<AccountsState> emit) {
    final account = event.account;
    if (account != null && account != emptyAccount) {
      final newList = List<Account>.from(state.accountList);
      final index = newList.indexWhere((e) => e.accountNumber == account.accountNumber);
      
      if (index != -1) {
        newList[index] = account;
        emit(state.copyWith(status: Status.success, accountList: newList));
      }
    }
  }

  void _onAccountsStreamedFailed(AccountsStreamedFailed event, Emitter<AccountsState> emit) {
    emit(state.copyWith(status: Status.failure, message: event.message));
  }

  @override
  Future<void> close() async {
    subscription?.cancel();
    subscription = null;
    return super.close();
  }
}
