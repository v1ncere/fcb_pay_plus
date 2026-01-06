import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../app/app.dart';
import '../data/data.dart';
import '../utils/utils.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  
  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final _secureStorage = SecureStorageRepository(
    storageService: SecureStorageService()
  );
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => setState(() {}));
    animationController.forward();
    setState(() { _visible = !_visible; });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  TextString.slogan, 
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans'
                  )
                )
              )
            ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetString.splashLogo,
                width: animation.value * 200,
                height: animation.value * 200
              )
            ]
          )
        ]
      )
    );
  }

  Future<void> startTime() async {
    Future.delayed(const Duration(seconds: 3), () async {
      final isBoarded = await _secureStorage.getOnboardingStatus();
      if (!mounted) return; // Prevents actions if the widget is disposed
      if (isBoarded != null && isBoarded == 1) {
        context.read<AppBloc>().add(LoginChecked());
      } else {
        _secureStorage.saveOnboardingStatus(1);
        context.goNamed(RouteName.walkThrough);
      }
    });
  }
}