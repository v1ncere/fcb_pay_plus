import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../receipt.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key, required this.receiptId});
  final String? receiptId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReceiptBloc()..add(ReceiptFetched(receiptId ?? ''))),
        BlocProvider(create: (context) => SaveReceiptCubit())
      ],
      child: const ReceiptView()
    );
  }
}