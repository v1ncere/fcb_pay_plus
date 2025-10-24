import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';

class FaceLivenessStartButton extends StatelessWidget {
  const FaceLivenessStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaceLivenessBloc, FaceLivenessState>(
      builder: (context, state) {
        if (state.resultStatus.isLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: ColorString.eucalyptus,
              size: 30,
            )
          );
        }
        // default display
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(ColorString.eucalyptus),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
          ),
          onPressed: () => context.read<FaceLivenessBloc>().add(FaceLivenessSessionIdFetched()),
          child: Text(
            "Tap here to begin",
            style: TextStyle(color: ColorString.mystic)
          )
        );
      }
    );
  }
}