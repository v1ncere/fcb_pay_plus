import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../repository/repository.dart';
import '../../../utils/utils.dart';
import '../sign_up.dart';

class SignupRoute extends StatelessWidget {
  const SignupRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightThemeData(context),
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
      builder: EasyLoading.init(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc(
          amplifyAuth: AmplifyAuth(),
          amplifyStorage: AmplifyStorage()
        )..add(LostDataRetrieved())),
        BlocProvider(create: (context) => SignUpStepperCubit(length: 3)), // length starts at 1
      ], 
      child: const SignUpView()
    );
  }
}
