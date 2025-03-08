import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';

class UsernameDisplay extends StatelessWidget {
  const UsernameDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            const Text(
              'Username',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12
              )
            ),
            Text(
              state.email.value,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 16
              ),
            ),
            const Divider(color: Colors.black45)
          ]
        );
      }
    );
  }
}