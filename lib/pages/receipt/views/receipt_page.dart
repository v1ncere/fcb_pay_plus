import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../receipt.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key, required this.accountNumber, required this.transCode, required this.referenceId, required this.transDate});
  final String? accountNumber;
  final String? transCode;
  final String? referenceId;
  final TemporalDate? transDate;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReceiptBloc()..add(ReceiptFetched(accountNumber!, transCode!, referenceId!, transDate!))),
        BlocProvider(create: (context) => SaveReceiptCubit())
      ],
      child: const ReceiptView()
    );
  }
}