part of 'account_button_bloc.dart';

class AccountButtonState extends Equatable {
  const AccountButtonState({
    this.buttons = const <Button>[],
    this.status = Status.initial,
    this.message = ''
  });
  final List<Button> buttons;
  final Status status;
  final String message;

  AccountButtonState copyWith({
    List<Button>? buttons,
    Status? status,
    String? message
  }) {
    return AccountButtonState(
      buttons: buttons ?? this.buttons,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [buttons, status, message];
}
