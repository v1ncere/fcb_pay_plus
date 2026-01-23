part of 'home_webview_bloc.dart';

sealed class HomeWebviewEvent extends Equatable {
  const HomeWebviewEvent();

  @override
  List<Object> get props => [];
}

final class WebviewFetchLoadingStarted extends HomeWebviewEvent {}

final class WebviewFetchLoadingSucceeded extends HomeWebviewEvent {}

final class WebviewFetchFailed extends HomeWebviewEvent {
  const WebviewFetchFailed(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

final class WebviewFetchReset extends HomeWebviewEvent {}