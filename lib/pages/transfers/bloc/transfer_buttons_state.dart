part of 'transfer_buttons_bloc.dart';

class TransferButtonsState extends Equatable {
  const TransferButtonsState({
    this.uid = '',
    this.userStatus = Status.initial,
    this.status = Status.initial,
    this.buttons = const <Button>[],
    this.message = ''
  });
  final String uid;
  final Status userStatus;
  final Status status;
  final List<Button> buttons;
  final String message;

  TransferButtonsState copyWith({
    String? uid,
    Status? userStatus,
    Status? status,
    List<Button>? buttons,
    String? message
  }) {
    return TransferButtonsState(
      uid: uid ?? this.uid,
      userStatus: userStatus ?? this.userStatus,
      status: status ?? this.status,
      buttons: buttons ?? this.buttons,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [uid, userStatus, status, buttons, message];
}
