part of 'home_buttons_bloc.dart';

sealed class HomeButtonsEvent extends Equatable {
  const HomeButtonsEvent();

  @override
  List<Object> get props => [];
}

final class HomeButtonsFetched extends HomeButtonsEvent {}

final class HomeButtonsRefreshed extends HomeButtonsEvent {}