// Amplify graphql
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../../home/home.dart';
import '../../payments/payments.dart';
import '../../transfers/transfers.dart';
import '../bottom_navbar.dart';

class BottomNavbarPage extends StatelessWidget {
  const BottomNavbarPage({super.key});
  // under this nav dont create another .page()

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AccountsHomeBloc(
          sqfliteRepositories: SqfliteRepositories(sqfliteService: SqfliteService()),
          secureStorageRepository: SecureStorageRepository(
            storageService: SecureStorageService()
          )  
        )
        ..add(UserAttributesFetched())
        ..add(AccountsHomeFetched())
        ..add(AccountsHomeOnCreatedStream())
        ..add(AccountsHomeOnDeletedStream())
        ..add(AccountsHomeOnUpdatedStream())),
        BlocProvider(create: (context) => PaymentButtonsBloc()
        ..add(PaymentButtonsUserIdFetched())
        ..add(PaymentButtonsFetched())),
        BlocProvider(create: (context) => TransferButtonsBloc()
        ..add(TransferButtonUserIdFetched())
        ..add(TransferButtonsFetched())),
        BlocProvider(create: (context) => HomeButtonsBloc()
        ..add(HomeButtonsFetched())),
        BlocProvider(create: (context) => BottomNavbarCubit()),
      ],
      child: const BottomNavbarView()
    );
  }
}