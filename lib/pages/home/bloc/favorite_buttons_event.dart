part of 'favorite_buttons_bloc.dart';

sealed class FavoriteButtonsEvent extends Equatable {
  const FavoriteButtonsEvent();

  @override
  List<Object> get props => [];
}

final class FavoriteButtonsFetched extends FavoriteButtonsEvent {}

final class FavoriteButtonsRefreshed extends FavoriteButtonsEvent {}
