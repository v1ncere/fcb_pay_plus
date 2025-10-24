import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';
import '../widgets/widgets.dart';

class FacelivenessScreen extends StatelessWidget {
  const FacelivenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaceLivenessBloc, FaceLivenessState>(
      builder: (context, state) {
        return state.sessionStatus.isLoading
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: SpinKitFadingCircle(
                color: ColorString.eucalyptus,
                size: 30,
              )
            )
          )
        : Column(
            children: [
              Text(
                'Take a Quick Selfie', 
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54
                )
              ),
              Center(
                child: SvgPicture.asset(
                  AssetString.faceScanner,
                  height: 350
                ),
              ),
              const SizedBox(height: 20),
              FaceLivenessStartButton(),
            ]
          );
      }
    );
  }
}
