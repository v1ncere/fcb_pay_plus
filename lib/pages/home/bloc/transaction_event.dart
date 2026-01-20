part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

final class TransactionFetched extends TransactionEvent {
  const TransactionFetched(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

final class TransactionOnCreatedStream extends TransactionEvent {
  const TransactionOnCreatedStream(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

final class TransactionOnUpdatedStream extends TransactionEvent {
  const TransactionOnUpdatedStream(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

final class TransactionOnDeletedStream extends TransactionEvent {
  const TransactionOnDeletedStream(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

final class TransactionStreamUpdated extends TransactionEvent {
  const TransactionStreamUpdated({required this.transaction, required this.isDelete});
  final Transaction? transaction;
  final bool isDelete;

  @override
  List<Object?> get props => [transaction];
}

final class TransactionRefreshed extends TransactionEvent {
  const TransactionRefreshed(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}