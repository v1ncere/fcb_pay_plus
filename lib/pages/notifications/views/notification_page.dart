import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../notifications.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => NotificationsBloc()
    ..add(NotificationsFetched())
    ..add(NotificationsOnCreateStreamed())
    ..add(NotificationsOnUpdateStreamed())
    ..add(NotificationsOnDeleteStreamed()),
      child: const NotificationView()
    );
  }
}