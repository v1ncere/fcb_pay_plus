import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_up_confirm.dart';

class SignUpConfirmPage extends StatelessWidget {
  const SignUpConfirmPage({super.key, required this.username});
  final String? username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpConfirmBloc()
      ..add(UsernameChanged(username ?? '')),
      child: const SignUpConfirmView(),
    );
  }
}