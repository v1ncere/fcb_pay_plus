part of 'scanner_transaction_bloc.dart';

class ScannerTransactionState extends Equatable with FormzMixin {
  const ScannerTransactionState({
    this.qrDataList = const <QRModel>[],
    required this.account,
    this.accountDropdown = const AccountDropdown.pure(),
    this.inputAmount = const Amount.pure(),
    this.notifyFlag = '',
    this.tip = '',
    this.receiptId = '',
    this.status = Status.initial,
    this.formStatus = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final List<QRModel> qrDataList;
  final Account account;
  final AccountDropdown accountDropdown;
  final String notifyFlag;
  final String tip;
  final Amount inputAmount;
  final String receiptId;
  final Status status;
  final FormzSubmissionStatus formStatus;
  final String message;

  ScannerTransactionState copyWith({
    List<QRModel>? qrDataList,
    Account? account,
    AccountDropdown? accountDropdown,
    String? notifyFlag,
    String? tip,
    Amount? inputAmount,
    String? receiptId,
    Status? status,
    FormzSubmissionStatus? formStatus,
    String? message
  }) {
    return ScannerTransactionState(
      qrDataList: qrDataList ?? this.qrDataList,
      account: account ?? this.account,
      accountDropdown: accountDropdown ?? this.accountDropdown,
      notifyFlag: notifyFlag ?? this.notifyFlag,
      tip: tip ?? this.tip,
      inputAmount: inputAmount ?? this.inputAmount,
      receiptId: receiptId ?? this.receiptId,
      status: status ?? this.status,
      formStatus: formStatus ?? this.formStatus,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    qrDataList,
    account,
    accountDropdown,
    notifyFlag,
    tip,
    inputAmount,
    receiptId,
    status,
    formStatus,
    message,
    isValid,
  ];
  
  @override
  List<FormzInput> get inputs => [accountDropdown, inputAmount];
}
