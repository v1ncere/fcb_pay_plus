import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../sign_up.dart';

class ZeroScreen extends StatelessWidget {
  const ZeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaceLivenessBloc()..add(FaceLivenessSessionIdFetched()),
      child: ZeroScreenStateful(),
    );
  }
}

class ZeroScreenStateful extends StatefulWidget {
  const ZeroScreenStateful({super.key});

  @override
  ZeroScreenState createState() => ZeroScreenState();
}

class ZeroScreenState extends State<ZeroScreenStateful> {

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
          if(state.resultStatus.isLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state.resultStatus.isSuccess) {
            return Column(
              children: [
                Text("This was the image!"),
                Image.memory(
                  Uint8List.fromList(state.rawBytes),
                  height: 200,
                  width: 200,
                ),
                Text("Confidence: ${state.confidence}")
              ],
            );
          }
          if (state.resultStatus.isFailure) {
            return Center(
              child: Text(state.message)
            );
          }
          else {
            return SizedBox.shrink();
          }
        }
      )
    );
  }
}
