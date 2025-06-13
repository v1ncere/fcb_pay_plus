part of 'transaction_history_bloc.dart';

sealed class TransactionHistoryEvent extends Equatable {
  const TransactionHistoryEvent();

  @override
  List<Object?> get props => [];
}

final class TransactionFetched extends TransactionHistoryEvent {
  const TransactionFetched({
    required this.accountNumber,
    this.searchQuery = '',
    this.filter = '',
  });
  final String accountNumber;
  final String searchQuery;
  final String filter;

  @override
  List<Object> get props => [accountNumber, searchQuery, filter];
}

final class SearchTextFieldChanged extends TransactionHistoryEvent {
  const SearchTextFieldChanged(this.searchQuery);
  final String searchQuery;

  @override
  List<Object> get props => [searchQuery];
}
