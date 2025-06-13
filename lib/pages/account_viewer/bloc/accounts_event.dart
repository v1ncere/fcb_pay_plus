part of 'accounts_bloc.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object?> get props => [];
}

final class AccountsFetched extends AccountsEvent {
  const AccountsFetched(this.account);
  final Account account;

  @override 
  List<Object> get props => [account];
}

final class AccountsStreamed extends AccountsEvent {
  const AccountsStreamed(this.userId);
  final String userId;
  
  @override
  List<Object> get props => [userId];
}

final class AccountsStreamedUpdate extends AccountsEvent {
  const AccountsStreamedUpdate(this.account);
  final Account? account;

  @override
  List<Object?> get props => [account];
}

final class AccountsStreamedFailed extends AccountsEvent {
  const AccountsStreamedFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}