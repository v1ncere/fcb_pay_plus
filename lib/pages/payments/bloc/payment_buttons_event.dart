part of 'payment_buttons_bloc.dart';

sealed class PaymentButtonsEvent extends Equatable {
  const PaymentButtonsEvent();

  @override
  List<Object> get props => [];
}

final class PaymentButtonsUserIdFetched extends PaymentButtonsEvent {}

final class PaymentButtonsFetched extends PaymentButtonsEvent {}

final class PaymentButtonsRefreshed extends PaymentButtonsEvent {}