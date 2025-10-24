part of 'receipt_bloc.dart';

sealed class ReceiptEvent extends Equatable {
  const ReceiptEvent();

  @override
  List<Object?> get props => [];
}

final class ReceiptFetched extends ReceiptEvent {
  const ReceiptFetched(this.accountNumber, this.transCode, this.referenceId, this.transDate);
  final String accountNumber;
  final String transCode;
  final String referenceId;
  final TemporalDate transDate;

  @override
  List<Object?> get props => [
    accountNumber,
    transCode,
    referenceId,
    transDate,
  ];
}