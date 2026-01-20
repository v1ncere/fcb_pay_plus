part of 'favorite_buttons_bloc.dart';

class FavoriteButtonsState extends Equatable {
  final List<Button> buttons;
  final Status status;
  final String message;

  const FavoriteButtonsState({
    this.buttons = const <Button>[],
    this.status = Status.initial,
    this.message = TextString.empty,
  });

  FavoriteButtonsState copyWith({
    List<Button>? buttons,
    Status? status,
    String? message,
  }) {
    return FavoriteButtonsState(
      buttons: buttons ?? this.buttons,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [buttons, status, message];
}
