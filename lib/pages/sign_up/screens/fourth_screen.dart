import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';
import '../widgets/widgets.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaceLivenessBloc, FaceLivenessState>(
      builder: (context, state) {
        return state.sessionStatus.isLoading
        ? Center(
            child: SpinKitChasingDots(
              color: ColorString.eucalyptus,
              size: 24,
            )
          )
        : Column(
            children: [
              Text(TextString.faceScan, style: Theme.of(context).textTheme.headlineSmall),
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
