import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

final emptyNotification = Notification();

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({
    required SecureStorageRepository secureStorageRepository,
  }) :  _secureStorageRepository = secureStorageRepository,
  super(const NotificationsState(status: Status.loading)) {
    on<NotificationsFetched>(_onNotificationsFetched);
    on<NotificationsOnCreateStreamed>(_onNotificationsOnCreateStreamed);
    on<NotificationsOnUpdateStreamed>(_onNotificationsOnUpdateStreamed);
    on<NotificationsOnDeleteStreamed>(_onNotificationsOnDeleteStreamed);
    on<NotificationsStreamUpdated>(_onNotificationsStreamUpdated);
    on<NotificationsUpdateIsRead>(_onNotificationsUpdateIsRead);
  }
  final SecureStorageRepository _secureStorageRepository;
  StreamSubscription<GraphQLResponse<Notification>>? onCreateSubscription;
  StreamSubscription<GraphQLResponse<Notification>>? onUpdateSubscription;
  StreamSubscription<GraphQLResponse<Notification>>? onDeleteSubscription;

  Future<void> _onNotificationsFetched(NotificationsFetched event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final user = await _secureStorageRepository.getUsername() ?? '';
      final request = ModelQueries.list(Notification.classType, where: Notification.OWNER.eq(user));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;

      if (items != null && !response.hasErrors) {
        final notifications = items.whereType<Notification>().toList();
        
        emit(
          notifications.isNotEmpty
          ? state.copyWith(status: Status.success, notifications: _sortNotifications(notifications))
          : state.copyWith(status: Status.failure, message: TextString.empty)
        );
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on AuthException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }

  FutureOr<void> _onNotificationsOnCreateStreamed(NotificationsOnCreateStreamed event, Emitter<NotificationsState> emit) async {
    final user = await _secureStorageRepository.getUsername() ?? '';
    final subscriptionRequest = ModelSubscriptions.onCreate(Notification.classType, where: Notification.OWNER.eq(user));
    final operation = Amplify.API.subscribe(subscriptionRequest, onEstablished: () => safePrint('Subscription Established!'));
    onCreateSubscription = operation.listen(
      (event) => add(NotificationsStreamUpdated(event.data, false)),
      onError: (error) => safePrint(error.toString()),
    );
  }

  FutureOr<void> _onNotificationsOnUpdateStreamed(NotificationsOnUpdateStreamed event, Emitter<NotificationsState> emit) async {
    final user = await _secureStorageRepository.getUsername() ?? '';
    final subscriptionRequest = ModelSubscriptions.onUpdate(Notification.classType, where: Notification.OWNER.eq(user));
    final operation = Amplify.API.subscribe(subscriptionRequest, onEstablished: () => safePrint('Subscription Established!'));
    onUpdateSubscription = operation.listen(
      (event) => add(NotificationsStreamUpdated(event.data, false)),
      onError: (error) => safePrint(error.toString()),
    );
  }

  FutureOr<void> _onNotificationsOnDeleteStreamed(NotificationsOnDeleteStreamed event, Emitter<NotificationsState> emit) async {
    final user = await _secureStorageRepository.getUsername() ?? '';
    final subscriptionRequest = ModelSubscriptions.onDelete(Notification.classType, where: Notification.OWNER.eq(user));
    final operation = Amplify.API.subscribe(subscriptionRequest, onEstablished: () => safePrint('Subscription Established!'));
    onDeleteSubscription = operation.listen(
      (event) => add(NotificationsStreamUpdated(event.data, true)),
      onError: (error) => safePrint(error.toString()),
    );
  }
  
  void _onNotificationsStreamUpdated(NotificationsStreamUpdated event, Emitter<NotificationsState> emit) {
    final notification = event.notification;
    
    if (notification != null) {
      final newList = List<Notification>.from(state.notifications);
      final index = newList.indexWhere((e) => e.id == notification.id);

      if (event.isDelete) {
        if (index != -1) {
          newList.removeAt(index);
          emit(state.copyWith(status: Status.success, notifications: _sortNotifications(newList)));
        }
      } else {
        if (index != -1) {
          newList[index] = notification;
        } else {
          newList.add(notification);
        }
        emit(state.copyWith(status: Status.success, notifications: _sortNotifications(newList)));
      }
    }
  }

  List<Notification> _sortNotifications(List<Notification> notification) {
    final unread = notification.where((e) => !e.isRead!).toList();
    final read = notification.where((e) => e.isRead!).toList();
    
    unread.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    read.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return [...unread, ...read];
  }

  void _onNotificationsUpdateIsRead(NotificationsUpdateIsRead event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(updateStatus: Status.loading));
    try {
      final updatedNotification = event.notification.copyWith(isRead: true);
      final request = ModelMutations.update(updatedNotification);
      final response = await Amplify.API.mutate(request: request).response;

      emit(
        response.data != null && !response.hasErrors
        ? state.copyWith(updateStatus: Status.success, message: response.toString())
        : state.copyWith(updateStatus: Status.failure, message: response.errors.first.message)
      );
    } on ApiException catch (e) {
      emit(state.copyWith(updateStatus: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(updateStatus: Status.failure, message: e.toString()));
    }
  }

  @override
  Future<void> close() async {
    onCreateSubscription?.cancel();
    onCreateSubscription = null;
    onUpdateSubscription?.cancel();
    onUpdateSubscription = null;
    onDeleteSubscription?.cancel();
    onDeleteSubscription = null;
    return super.close();
  }
}
