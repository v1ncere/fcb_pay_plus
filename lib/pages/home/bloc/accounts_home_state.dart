part of 'accounts_home_bloc.dart';

class AccountsHomeState extends Equatable {
  final List<Account> accountList;
  final Account wallet;
  final Account pitakard;
  final Account plc;
  final Account sa;
  final Account dd;
  final Account loans;
  final String username;
  final String uid;
  final Status status;
  final Status userStatus;
  final String message;
  
  const AccountsHomeState({
    this.accountList = const <Account>[],
    required this.wallet,
    required this.pitakard,
    required this.plc,
    required this.sa,
    required this.dd,
    required this.loans,
    this.username = '',
    this.uid = '',
    this.status = Status.initial,
    this.userStatus = Status.initial,
    this.message = ''
  });

  AccountsHomeState copyWith({
    List<Account>? accountList,
    Account? wallet,
    Account? pitakard,
    Account? plc,
    Account? sa,
    Account? dd,
    Account? loans,
    String? username,
    String? uid,
    Status? status,
    Status? userStatus,
    String? message,
  }) {
    return AccountsHomeState(
      accountList: accountList ?? this.accountList,
      wallet: wallet ?? this.wallet,
      pitakard: pitakard ?? this.pitakard,
      plc: plc ?? this.plc,
      sa: sa ?? this.sa,
      dd: dd ?? this.dd,
      loans: loans ?? this.loans,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      status: status ?? this.status,
      userStatus: userStatus ?? this.userStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props {
    return [
      accountList,
      wallet,
      pitakard,
      plc,
      sa,
      dd,
      loans,
      username,
      uid,
      status,
      userStatus,
      message,
    ];
  }
}
