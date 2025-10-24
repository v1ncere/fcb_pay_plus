import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../bloc/merchant_add_bloc.dart';
import '../screens/screens.dart';

class MerchantAddView extends StatelessWidget {
  const MerchantAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return InactivityDetector(
      onInactive: () => context.goNamed(RouteName.authPin),
      child: BlocBuilder<MerchantAddBloc, MerchantAddState>(
        builder: (context, state) {
          if (state.scanner.isScanner) {
            return ScannerScreen();
          }
          // default display
          return MainScreen();
        }
      )
    );
  }
}