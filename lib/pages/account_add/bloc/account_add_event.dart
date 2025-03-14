part of 'account_add_bloc.dart';

sealed class AccountAddEvent extends Equatable {
  const AccountAddEvent();

  @override
  List<Object> get props => [];
}

final class AccountTypeDropdownChanged extends AccountAddEvent {
  const AccountTypeDropdownChanged(this.accountType);
  final AccountType accountType;

  @override
  List<Object> get props => [accountType];
}

final class AccountNumberChanged extends AccountAddEvent {
  const AccountNumberChanged(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

final class FirstNameChanged extends AccountAddEvent {
  const FirstNameChanged(this.firstName);
  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class LastNameChanged extends AccountAddEvent {
  const LastNameChanged(this.lastName);
  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class BirthdateChanged extends AccountAddEvent {
  const BirthdateChanged(this.date);
  final DateTime date;

  @override
  List<Object> get props => [date];
}


final class AccountFormSubmitted extends AccountAddEvent {}

final class IsAccountExisted extends AccountAddEvent {
  const IsAccountExisted(this.isExists);
  final bool isExists;

  @override
  List<Object> get props => [isExists];
}

final class AccountVerified extends AccountAddEvent {}

final class AccountVerifyReplyStreamed extends AccountAddEvent {
  const AccountVerifyReplyStreamed(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class AccountVerifyReplyUpdated extends AccountAddEvent {
  const AccountVerifyReplyUpdated(this.verifyReply);
  final SignupVerifyReply verifyReply;

  @override
  List<Object> get props => [verifyReply];
}

final class AccountVerifyReplyFailed extends AccountAddEvent {
  const AccountVerifyReplyFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}