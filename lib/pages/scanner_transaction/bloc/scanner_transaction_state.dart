part of 'scanner_transaction_bloc.dart';

class ScannerTransactionState extends Equatable with FormzMixin {
  const ScannerTransactionState({
    this.qrDataList = const <QRModel>[],
    required this.account,
    this.inputAmount = const Amount.pure(),
    this.notifyFlag = '',
    this.tip = '',
    this.receiptId = '',
    this.status = Status.initial,
    this.accountStatus = Status.initial,
    this.formStatus = FormzSubmissionStatus.initial,
    this.message = ''
  });
  final List<QRModel> qrDataList;
  final Account account;
  final String notifyFlag;
  final String tip;
  final Amount inputAmount;
  final String receiptId;
  final Status status;
  final Status accountStatus;
  final FormzSubmissionStatus formStatus;
  final String message;

  ScannerTransactionState copyWith({
    List<QRModel>? qrDataList,
    Account? account,
    String? notifyFlag,
    String? tip,
    Amount? inputAmount,
    String? receiptId,
    Status? status,
    Status? accountStatus,
    FormzSubmissionStatus? formStatus,
    String? message
  }) {
    return ScannerTransactionState(
      
      qrDataList: qrDataList ?? this.qrDataList,
      account: account ?? this.account,
      notifyFlag: notifyFlag ?? this.notifyFlag,
      tip: tip ?? this.tip,
      inputAmount: inputAmount ?? this.inputAmount,
      receiptId: receiptId ?? this.receiptId,
      status: status ?? this.status,
      accountStatus: accountStatus ?? this.accountStatus,
      formStatus: formStatus ?? this.formStatus,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    qrDataList,
    account,
    notifyFlag,
    tip,
    inputAmount,
    receiptId,
    status,
    accountStatus,
    formStatus,
    message,
    isValid,
  ];
  
  @override
  List<FormzInput> get inputs => [inputAmount];
}
