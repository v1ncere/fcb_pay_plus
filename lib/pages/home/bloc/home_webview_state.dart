// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_webview_bloc.dart';

class HomeWebviewState extends Equatable {
  final Status status;
  final String message;

  const HomeWebviewState({
    this.status = Status.initial,
    this.message = '',
  });
  
  HomeWebviewState copyWith({
    Status? status,
    String? message,
  }) {
    return HomeWebviewState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}
