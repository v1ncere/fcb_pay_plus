part of 'scanner_transaction_bloc.dart';

class ScannerTransactionState extends Equatable with FormzMixin {
  const ScannerTransactionState({
    this.qrDataList = const <QRModel>[],
    this.uid = '',
    this.accountDropdown = const AccountDropdown.pure(),
    required this.account,
    this.inputAmount = const Amount.pure(),
    this.notifyFlag = '',
    this.tip = '',
    this.status = Status.initial,
    this.userStatus = Status.initial,
    this.formStatus = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final List<QRModel> qrDataList;
  final String uid;
  final String notifyFlag;
  final AccountDropdown accountDropdown;
  final Account account;
  final String tip;
  final Amount inputAmount;
  final Status status;
  final Status userStatus;
  final FormzSubmissionStatus formStatus;
  final String message;

  ScannerTransactionState copyWith({
    List<QRModel>? qrDataList,
    String? uid,
    String? notifyFlag,
    AccountDropdown? accountDropdown,
    Account? account,
    String? tip,
    Amount? inputAmount,
    Status? status,
    Status? userStatus,
    FormzSubmissionStatus? formStatus,
    String? message
  }) {
    return ScannerTransactionState(
      qrDataList: qrDataList ?? this.qrDataList,
      notifyFlag: notifyFlag ?? this.notifyFlag,
      accountDropdown: accountDropdown ?? this.accountDropdown,
      account: account ?? this.account,
      tip: tip ?? this.tip,
      inputAmount: inputAmount ?? this.inputAmount,
      status: status ?? this.status,
      userStatus: userStatus ?? this.userStatus,
      formStatus: formStatus ?? this.formStatus,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    qrDataList,
    notifyFlag,
    accountDropdown,
    account,
    tip,
    inputAmount,
    status,
    userStatus,
    formStatus,
    message,
    isValid,
    isPure
  ];
  
  @override
  List<FormzInput> get inputs => [accountDropdown, inputAmount];
}
