part of 'receipt_bloc.dart';

sealed class ReceiptEvent extends Equatable {
  const ReceiptEvent();

  @override
  List<Object?> get props => [];
}

final class ReceiptFetched extends ReceiptEvent {
  const ReceiptFetched(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}