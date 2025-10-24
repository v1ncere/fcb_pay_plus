import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../utils/utils.dart';
import '../cubit/top_stepper_cubit.dart';
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
        BlocProvider(create: (context) => SignUpBloc()
        ..add(LostDataRetrieved())
        ..add(BridgeTokenGenerated())),
        BlocProvider(create: (context) => FaceLivenessBloc()),
        BlocProvider(create: (context) => TopStepperCubit(length: 5)),
      ],
      child: const SignUpView(),
    );
  }
}
