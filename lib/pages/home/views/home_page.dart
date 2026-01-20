import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../../notifications/notifications.dart';
import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => NotificationsBloc(
          secureStorageRepository: SecureStorageRepository(
            storageService: SecureStorageService()
          ),
        )
        ..add(NotificationsOnCreateStreamed())
        ..add(NotificationsOnUpdateStreamed())
        ..add(NotificationsOnDeleteStreamed())
        ..add(NotificationsFetched()),
      ),
      BlocProvider(create: (context) => TransactionBloc()),
    ],
      child: const AccountHomeView(),
    );
  }
}
