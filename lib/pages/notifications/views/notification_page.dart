import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../notifications.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => NotificationsBloc(
      secureStorageRepository: SecureStorageRepository(
        storageService: SecureStorageService()
      ),
    )
    ..add(NotificationsFetched())
    ..add(NotificationsOnCreateStreamed())
    ..add(NotificationsOnUpdateStreamed())
    ..add(NotificationsOnDeleteStreamed()),
      child: const NotificationView()
    );
  }
}