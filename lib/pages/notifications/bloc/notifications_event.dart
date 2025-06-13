part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

final class NotificationsFetched extends NotificationsEvent {}

final class NotificationsOnCreateStreamed extends NotificationsEvent {}

final class NotificationsOnUpdateStreamed extends NotificationsEvent {}

final class NotificationsOnDeleteStreamed extends NotificationsEvent {}

final class NotificationsStreamUpdated extends NotificationsEvent {
  const NotificationsStreamUpdated(this.notification, this.isDelete);
  final Notification? notification;
  final bool isDelete;
  
  @override
  List<Object?> get props => [notification, isDelete];
}

final class NotificationsUpdateIsRead extends NotificationsEvent {
  const NotificationsUpdateIsRead(this.notification);
  final Notification notification;

  @override
  List<Object> get props => [notification];
}