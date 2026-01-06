part of 'home_buttons_bloc.dart';

class HomeButtonsState extends Equatable {
  final Status status;
  final List<Button> buttons;
  final String message;

  const HomeButtonsState({
    this.status = Status.initial,
    this.buttons = const <Button>[],
    this.message = TextString.empty,
  });

  HomeButtonsState copyWith({
    Status? status,
    List<Button>? buttons,
    String? message,
  }) {
    return HomeButtonsState(
      status: status ?? this.status,
      buttons: buttons ?? this.buttons,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [status, buttons, message];
}