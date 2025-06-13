part of 'payment_buttons_bloc.dart';

class PaymentButtonsState extends Equatable {
  const PaymentButtonsState({
    this.uid = '',
    this.userStatus = Status.initial, 
    this.status = Status.initial,
    this.buttons = const <Button>[],
    this.message = ''
  });
  final String uid;
  final Status userStatus;
  final List<Button> buttons;
  final Status status;
  final String message;

  PaymentButtonsState copyWith({
    String? uid,
    Status? userStatus,
    List<Button>? buttons,
    Status? status,
    String? message,
  }) {
    return PaymentButtonsState(
      uid: uid ?? this.uid,
      userStatus: userStatus ?? this.userStatus,
      buttons: buttons ?? this.buttons,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    uid, 
    userStatus, 
    buttons, 
    status, 
    message
  ];
}