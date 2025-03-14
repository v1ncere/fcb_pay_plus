import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../sign_up.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FaceLivenessBloc, FaceLivenessState>(
      listener: (context, state) {
        if(state.sessionStatus.isSuccess) {
          context.read<FaceLivenessBloc>().add(FaceLivenessMethodChannelInvoked());
        }
        // invoked faceLiveness
        if(state.invokeStatus.isSuccess) {
          context.read<FaceLivenessBloc>().add(FaceLivenessResultFetched());
        } 
        if (state.invokeStatus.isFailure) {
         ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.triangleExclamation,
            backgroundColor: ColorString.guardsmanRed,
            foregroundColor: ColorString.mystic,
          ));
        }
        //
        if(state.resultStatus.isSuccess) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: "FaceLiveness Successful!",
            icon: FontAwesomeIcons.circleCheck,
            backgroundColor: ColorString.eucalyptus,
            foregroundColor: ColorString.mystic,
          ));
        }
        if(state.resultStatus.isFailure) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(customSnackBar(
            text: state.message,
            icon: FontAwesomeIcons.triangleExclamation,
            backgroundColor: ColorString.guardsmanRed,
            foregroundColor: ColorString.mystic,
          ));
        }
      },
      child: BlocBuilder<FaceLivenessBloc, FaceLivenessState>(
        builder: (context, state) {
          return state.sessionStatus.isLoading
          ? Center(child: CircularProgressIndicator.adaptive())
          : Column(
              children: [
                Text("Scan your face", style: Theme.of(context).textTheme.headlineSmall),
                Center(
                  child: SvgPicture.asset(
                    AssetString.faceScanner,
                    height: 350
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                  ),
                  onPressed: () => context.read<FaceLivenessBloc>().add(FaceLivenessSessionIdFetched()),
                  child: Text("Tap here to begin")
                )
              ]
            );
        }
      )
    );
  }
}

// Image.memory(
//             Uint8List.fromList(state.rawBytes),
//             height: 200,
//             width: 200,
//           ),
//           Text("Confidence: ${state.confidence}")
