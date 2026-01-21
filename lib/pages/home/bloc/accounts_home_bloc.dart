import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../../../models/ModelProvider.dart' hide AccountType;
import '../../../utils/utils.dart';

part 'accounts_home_event.dart';
part 'accounts_home_state.dart';

final Account empty = Account(accountNumber: '', owner: '');

class AccountsHomeBloc extends Bloc<AccountsHomeEvent, AccountsHomeState> {
  final SecureStorageRepository _secureStorageRepository;
  final SqfliteRepositories _sqfliteRepositories;
  
  AccountsHomeBloc({
    required SqfliteRepositories sqfliteRepositories,
    required SecureStorageRepository secureStorageRepository,
  }) : _sqfliteRepositories = sqfliteRepositories, 
  _secureStorageRepository = secureStorageRepository,
  super(AccountsHomeState(plc: empty, pitakard: empty, sa: empty,  wallet: empty, dd: empty, loans: empty)) {
    on<UserAttributesFetched>(_onUserAttributesFetched);
    on<AccountsHomeFetched>(_onAccountsHomeLoaded);
    on<AccountDisplayChanged>(_onAccountDisplayChanged);
    on<AccountsHomeRefreshed>(_onAccountsHomeRefreshed);
  }

  Future<void> _onAccountsHomeLoaded(AccountsHomeFetched event, Emitter<AccountsHomeState> emit) async {
    await _fetchDataAndRefreshState(emit);
  }

  Future<void> _onUserAttributesFetched(UserAttributesFetched event, Emitter<AccountsHomeState> emit) async {
    await _fetchUserDetails(emit);
  }

  // change account display, user management (save by [account type])
  Future<void> _onAccountDisplayChanged(AccountDisplayChanged event, Emitter<AccountsHomeState>  emit) async {
    await _sqfliteRepositories.insertAccount(Accounts(
      id: '${event.account.accountType}',
      accountNumber: event.account.accountNumber,
    ));
    await _fetchDataAndRefreshState(emit);
  }

  // refresh the state
  Future<void> _onAccountsHomeRefreshed(AccountsHomeRefreshed event, Emitter<AccountsHomeState> emit) async {
    emit(state.copyWith(status: Status.loading, userStatus: Status.loading));
    await _fetchUserDetails(emit);
    await _fetchDataAndRefreshState(emit);
  }

  // *** UTILITY METHODS ***
  // fetching list of accounts from AWS
  Future<void> _fetchDataAndRefreshState(Emitter<AccountsHomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final user = await _secureStorageRepository.getUsername(); // username as owner of the account
      final request = ModelQueries.list(
        Account.classType,
        where: Account.OWNER.eq(user),
      );
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;
      
      if (items != null && !response.hasErrors) {
        final accounts = items.whereType<Account>().toList();
        
        if (accounts.isNotEmpty) {
          await _accountHomeCardDisplay(accounts, emit);
        } else {
          emit(state.copyWith(status: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on AuthException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }

  Future<void> _accountHomeCardDisplay(List<Account> accounts, Emitter<AccountsHomeState> emit) async {
    final wallet = _getAccountOfType(accounts, AccountType.wallet.name); // locate wallet account
    final sa = await _getAccount(accounts, AccountType.sa.name); // locate savings account
    final pitakard = await _getAccount(accounts, AccountType.pitakard.name); // locate payroll account
    final plc = await _getAccount(accounts, AccountType.plc.name); // locate credit account
    final dd = await _getAccount(accounts, AccountType.plc.name);
    final loans = await _getAccount(accounts, AccountType.plc.name);

    emit(state.copyWith(
      status: Status.success,
      accountList: accounts,
      wallet: wallet,
      sa: sa,
      pitakard: pitakard,
      plc: plc,
      dd: dd,
      loans: loans,
    ));
  }

  Future<void> _fetchUserDetails(Emitter<AccountsHomeState> emit) async {
    emit(state.copyWith(userStatus: Status.loading));
    try {
      final userName = await _secureStorageRepository.getUsername(); // get the username and make the  username the id
      emit(state.copyWith(userStatus: Status.success, username: userName, uid: userName));
    } on AuthException catch (e) {
      emit(state.copyWith(userStatus: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(userStatus: Status.failure, message: TextString.error));
    }
  }

  // get Account by type (note: type needs to be lower case so it will equals to lowercase enum)
  Account _getAccountOfType(List<Account> accountList, String type) {
    return accountList.firstWhere((e) => e.accountType!.toLowerCase() == type, orElse: () => empty);
  }

  // sort the list of Accounts and return the  latest
  Account _getLatestAccount(List<Account> accountList, String type) {
    accountList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return accountList.firstWhere((e) => e.accountType!.toLowerCase() == type, orElse: () => empty);
  }

  // get account by specific type 
  Future<Account> _getAccount(List<Account> accountList, String type) async {
    final account = accountList.where((e) => e.accountType!.toLowerCase() == type);

    if (account.isNotEmpty) {
      final accountType = await _sqfliteRepositories.getAccountById(type); // get accountNumber saved from local storage [hive]
      return accountType != null && accountType == Accounts.empty
      ? accountList.firstWhere((e) => e.accountNumber == accountType.accountNumber) // if id is not empty, locate the account equals to the id
      : _getLatestAccount(accountList, type); // if id is empty get the latest account
    }
    return empty;
  }
}