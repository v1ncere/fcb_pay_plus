part of 'account_add_bloc.dart';

class AccountAddState extends Equatable with FormzMixin {
  const AccountAddState({
    this.accountType = AccountType.unknown,
    this.accountNumber = const AccountNumber.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.message = ''
  });

  final AccountType accountType;
  final AccountNumber accountNumber;
  final Name firstName;
  final Name lastName;
  final FormzSubmissionStatus formStatus;
  final String message;

  AccountAddState copyWith({
    AccountType? accountType,
    List<AccountType>? typeList,
    AccountNumber? accountNumber,
    Name? firstName,
    Name? lastName,
    FormzSubmissionStatus? formStatus,
    String? message
  }) {
    return AccountAddState(
      accountType: accountType ?? this.accountType,
      accountNumber: accountNumber ?? this.accountNumber,
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
    firstName,
    lastName,
    formStatus,
    message,
    isValid
  ];
  
  @override
  List<FormzInput> get inputs => [
    accountNumber,
    firstName,
    lastName
  ];
}
