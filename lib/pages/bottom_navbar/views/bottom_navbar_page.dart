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
      providers: [ // we put providers here to load instead of every page
        BlocProvider(create: (context) => AccountsHomeBloc(
          sqfliteRepositories: SqfliteRepositories(sqfliteService: SqfliteService()),
          secureStorageRepository: SecureStorageRepository(storageService: SecureStorageService()),
        )
        ..add(UserAttributesFetched())
        ..add(AccountsHomeFetched())),
        BlocProvider(create: (context) => FavoriteButtonsBloc(
          sqfliteRepositories: SqfliteRepositories(sqfliteService: SqfliteService()),
        )..add(FavoriteButtonsFetched())),
        BlocProvider(create: (context) => HomeButtonsBloc()
        ..add(HomeButtonsFetched())),
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