part of 'merchant_add_bloc.dart';

sealed class MerchantAddEvent extends Equatable {
  const MerchantAddEvent();

  @override
  List<Object> get props => [];
}

final class MerchantIsScannerChanged extends MerchantAddEvent {
  const MerchantIsScannerChanged(this.scanner);
  final Scanner scanner;

  @override
  List<Object> get props => [scanner];
}

final class MerchantAddCreated extends MerchantAddEvent {
  const MerchantAddCreated(this.data);
  final String data;

  @override
  List<Object> get props => [data];
}

final class MerchantAddFetched extends MerchantAddEvent {}

final class MerchantAddDeleted extends MerchantAddEvent {
  const MerchantAddDeleted(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}
