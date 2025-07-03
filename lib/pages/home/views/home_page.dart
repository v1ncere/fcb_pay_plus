import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../notifications/notifications.dart';
import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsBloc()
      ..add(NotificationsOnCreateStreamed())
      ..add(NotificationsOnUpdateStreamed())
      ..add(NotificationsOnDeleteStreamed())
      ..add(NotificationsFetched()),
      child: const AccountHomeView(),
    );
  }
}
