import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../../notifications/notifications.dart';
import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final accountNumber = context.select((AccountsHomeBloc bloc) => bloc.state.wallet.accountNumber);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotificationsBloc(
          secureStorageRepository: SecureStorageRepository(storageService: SecureStorageService())
        )
        ..add(NotificationsOnCreateStreamed())
        ..add(NotificationsOnUpdateStreamed())
        ..add(NotificationsOnDeleteStreamed())
        ..add(NotificationsFetched())),
        BlocProvider(create: (context) => TransactionBloc()
        ..add(TransactionFetched(accountNumber))
        ..add(TransactionOnCreatedStream(accountNumber))
        ..add(TransactionOnUpdatedStream(accountNumber))
        ..add(TransactionOnDeletedStream(accountNumber))),
        BlocProvider(create: (context) => HomeWebviewBloc())
      ],
      child: const AccountHomeView(),
    );
  }
}
