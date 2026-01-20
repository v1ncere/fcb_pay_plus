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

final class CardNumberChanged extends AccountAddEvent {
  const CardNumberChanged(this.cardNumber);
  final String cardNumber;

  @override
  List<Object> get props => [cardNumber];
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

// final class BirthdateChanged extends AccountAddEvent {
//   const BirthdateChanged(this.date);
//   final DateTime date;

//   @override
//   List<Object> get props => [date];
// }

final class AccountFormSubmitted extends AccountAddEvent {}