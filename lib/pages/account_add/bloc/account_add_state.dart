part of 'account_add_bloc.dart';

class AccountAddState extends Equatable with FormzMixin {
  const AccountAddState({
    this.accountType = AccountType.unknown,
    this.accountNumber = const AccountNumber.pure(),
    this.cardNumber = const CardNumber.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.message = ''
  });

  final AccountType accountType;
  final AccountNumber accountNumber;
  final CardNumber cardNumber;
  final Name firstName;
  final Name lastName;
  final FormzSubmissionStatus formStatus;
  final String message;

  AccountAddState copyWith({
    AccountType? accountType,
    List<AccountType>? typeList,
    AccountNumber? accountNumber,
    CardNumber? cardNumber,
    Name? firstName,
    Name? lastName,
    FormzSubmissionStatus? formStatus,
    String? message
  }) {
    return AccountAddState(
      accountType: accountType ?? this.accountType,
      accountNumber: accountNumber ?? this.accountNumber,
      cardNumber: cardNumber ?? this.cardNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      formStatus: formStatus ?? this.formStatus,
      message: message ?? this.message
    );
  }

  @override
  List<Object> get props => [
    accountType,
    accountNumber,
    cardNumber,
    firstName,
    lastName,
    formStatus,
    message,
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [
    accountNumber,
    cardNumber,
    firstName,
    lastName
  ];
}
