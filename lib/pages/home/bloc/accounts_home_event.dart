part of 'accounts_home_bloc.dart';

sealed class AccountsHomeEvent extends Equatable {
  const AccountsHomeEvent();

  @override
  List<Object?> get props => [];
}

final class AccountsHomeFetched extends AccountsHomeEvent {}

final class AccountsHomeOnCreateStreamed extends AccountsHomeEvent {}

final class AccountsHomeOnUpdateStreamed extends AccountsHomeEvent {}

final class AccountsHomeOnDeleteStreamed extends AccountsHomeEvent {}

final class AccountsHomeStreamUpdated extends AccountsHomeEvent {
  const AccountsHomeStreamUpdated(this.account, this.isDelete);
  final Account? account;
  final bool isDelete;

  @override
  List<Object?> get props => [account, isDelete];
}

final class AccountDisplayChanged extends AccountsHomeEvent {
  const AccountDisplayChanged(this.account);
  final Account account;

  @override
  List<Object> get props => [account];
}

final class UserAttributesFetched extends AccountsHomeEvent {}

final class AccountsHomeRefreshed extends AccountsHomeEvent {}
