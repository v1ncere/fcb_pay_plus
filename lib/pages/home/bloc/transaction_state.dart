// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final Status status;
  final String message;
  
  const TransactionState({
    this.transactions = const <Transaction>[],
    this.status = Status.initial,
    this.message = '',
  });

  TransactionState copyWith({
    List<Transaction>? transactions,
    Status? status,
    String? message,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [transactions, status, message];
}
