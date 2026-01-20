part of 'accounts_home_bloc.dart';

sealed class AccountsHomeEvent extends Equatable {
  const AccountsHomeEvent();

  @override
  List<Object?> get props => [];
}

final class AccountsHomeFetched extends AccountsHomeEvent {}

final class AccountDisplayChanged extends AccountsHomeEvent {
  const AccountDisplayChanged(this.account);
  final Account account;

  @override
  List<Object> get props => [account];
}

final class UserAttributesFetched extends AccountsHomeEvent {}

final class AccountsHomeRefreshed extends AccountsHomeEvent {}
