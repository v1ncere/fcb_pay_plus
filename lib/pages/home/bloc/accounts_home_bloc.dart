import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../models/ModelProvider.dart' hide AccountType;
import '../../../utils/utils.dart';

part 'accounts_home_event.dart';
part 'accounts_home_state.dart';

final Account emptyAccount = Account(accountNumber: '', owner: '');

class AccountsHomeBloc extends Bloc<AccountsHomeEvent, AccountsHomeState> {
  AccountsHomeBloc({
    required HiveRepository hiveRepository,
  })  : _hiveRepository = hiveRepository,
        super(AccountsHomeState(credit: emptyAccount, payroll: emptyAccount, savings: emptyAccount, wallet: emptyAccount)) {
          on<UserAttributesFetched>(_onUserAttributesFetched);
          on<AccountsHomeOnCreatedStream>(_onAccountsHomeOnCreatedStream);
          on<AccountsHomeOnDeletedStream>(_onAccountsHomeOnDeletedStream);
          on<AccountsHomeOnUpdatedStream>(_onAccountsHomeOnUpdatedStream);
          on<AccountsHomeStreamUpdated>(_onAccountsHomeStreamUpdated);
          on<AccountsHomeFetched>(_onAccountsHomeLoaded);
          on<AccountDisplayChanged>(_onAccountDisplayChanged);
          on<AccountsHomeRefreshed>(_onAccountsHomeRefreshed);
        }
  final HiveRepository _hiveRepository;
  StreamSubscription<GraphQLResponse<Account>>? subscriptionOnCreate;
  StreamSubscription<GraphQLResponse<Account>>? subscriptionOnUpdate;
  StreamSubscription<GraphQLResponse<Account>>? subscriptionOnDelete;

  Future<void> _onAccountsHomeLoaded(AccountsHomeFetched event, Emitter<AccountsHomeState> emit) async {
    await _fetchDataAndRefreshState(emit);
  }

  Future<void> _onUserAttributesFetched(UserAttributesFetched event, Emitter<AccountsHomeState> emit) async {
    await _fetchUserDetails(emit);
  }

  // change account display
  Future<void> _onAccountDisplayChanged(AccountDisplayChanged event, Emitter<AccountsHomeState>  emit) async {
    // save by [account type]
    await _hiveRepository.addAccountNumber(uid: '${event.account.accountType}', accountNumber: event.account.accountNumber);
    await _fetchDataAndRefreshState(emit);
  }

  // listening on create
  FutureOr<void> _onAccountsHomeOnCreatedStream(AccountsHomeOnCreatedStream event, Emitter<AccountsHomeState> emit) async {
    final authUser = await Amplify.Auth.getCurrentUser();
    final request = ModelSubscriptions.onCreate(Account.classType, where: Account.OWNER.eq(authUser.userId));
    final operation = Amplify.API.subscribe(request);
    
    subscriptionOnCreate = operation.listen(
      (event) => add(AccountsHomeStreamUpdated(event.data, false)),
      onError: (error) => safePrint(error.toString()),
    );
  }

  // listening on update
  FutureOr<void> _onAccountsHomeOnUpdatedStream(AccountsHomeOnUpdatedStream event, Emitter<AccountsHomeState> emit) async {
    final authUser = await Amplify.Auth.getCurrentUser();
    final request = ModelSubscriptions.onUpdate(Account.classType, where: Account.OWNER.eq(authUser.userId));
    final operation = Amplify.API.subscribe(request);
    
    subscriptionOnUpdate = operation.listen(
      (event) => add(AccountsHomeStreamUpdated(event.data, false)),
      onError: (error) => safePrint(error.toString()),
    );
  }

  // listening on delete
  FutureOr<void> _onAccountsHomeOnDeletedStream(AccountsHomeOnDeletedStream event, Emitter<AccountsHomeState> emit) async {
    final authUser = await Amplify.Auth.getCurrentUser();
    final request = ModelSubscriptions.onDelete(Account.classType, where: Account.OWNER.eq(authUser.userId));
    final operation = Amplify.API.subscribe(request);
    
    subscriptionOnDelete = operation.listen(
      (event) => add(AccountsHomeStreamUpdated(event.data, true)),
      onError: (error) => safePrint(error.toString()),
    );
  }

  FutureOr<void> _onAccountsHomeStreamUpdated(AccountsHomeStreamUpdated event, Emitter<AccountsHomeState> emit) async {
    final account = event.account;
    if (account != null) {
      final newList = List<Account>.from(state.accountList);
      final index = newList.indexWhere((e) => e.accountNumber == account.accountNumber);
      
      if (event.isDelete) {
        if (index != -1) {
          newList.removeAt(index);
          await _accountHomeCardDisplay(newList, emit);
        }
      } else {
        if (index != -1) {
          newList[index] = account;
        } else {
          newList.add(account);
        }
        await _accountHomeCardDisplay(newList, emit);
      }
    }
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
      final user = await Amplify.Auth.getCurrentUser();
      final request = ModelQueries.list(Account.classType, where: Account.OWNER.eq(user.userId));
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
    emit(state.copyWith(status: Status.success, accountList: accounts, wallet: wallet, savings: sa, payroll: pitakard, credit: plc));
  }

  Future<void> _fetchUserDetails(Emitter<AccountsHomeState> emit) async {
    emit(state.copyWith(userStatus: Status.loading));
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      final sub = result.firstWhere((e) => e.userAttributeKey == AuthUserAttributeKey.sub);
      final givenName = result.firstWhere((e) => e.userAttributeKey == AuthUserAttributeKey.givenName);
      emit(state.copyWith(userStatus: Status.success, username: givenName.value, uid: sub.value));
    } on AuthException catch (e) {
      emit(state.copyWith(userStatus: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(userStatus: Status.failure, message: TextString.error));
    }
  }

  // get Account by type
  Account _getAccountOfType(List<Account> accountList, String type) {
    return accountList.firstWhere((e) => e.accountType!.toLowerCase() == type, orElse: () => emptyAccount);
  }

  // sort the list of Accounts and return the  latest
  Account _getLatestAccount(List<Account> accountList, String type) {
    accountList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return accountList.firstWhere((e) => e.accountType!.toLowerCase() == type, orElse: () => emptyAccount);
  }

  // get account by specific type 
  Future<Account> _getAccount(List<Account> accountList, String type) async {
    final account = accountList.where((e) => e.accountType!.toLowerCase() == type);
    if (account.isNotEmpty) {
      final accountNumber = await _hiveRepository.getAccountNumber(type); // get accountNumber saved from local storage [hive]
      return accountNumber.isNotEmpty
      ? accountList.firstWhere((e) => e.accountNumber == accountNumber) // if id is not empty, locate the account equals to the id
      : _getLatestAccount(accountList, type); // if id is empty get the latest account
    }
    return emptyAccount;
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