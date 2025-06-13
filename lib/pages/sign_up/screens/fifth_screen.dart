import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';
import '../widgets/widgets.dart';

class FifthScreen extends StatelessWidget {
  const FifthScreen({super.key});
  static final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState> (
      builder: (context, state) {
        if (state.faceComparisonStatus.isLoading) {
          return Center(
            child: Center(
              child: SpinKitChasingDots(
                color: ColorString.eucalyptus,
                size: 24,
              )
            )
          );
        }
        if (state.faceComparisonStatus.isSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.circleCheck, 
                color: ColorString.eucalyptus,
                size: 50,
              ),
              SizedBox(height: 20),
              Text(
                TextString.submitText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: ColorString.eucalyptus
                ),
              )
            ]
          );
        }
        //
        return Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ValidIdDropdown(),
              const SizedBox(height: 20),
              if(state.validIDTitle.isNotEmpty) UserImage(picker: picker),
              if(state.validIDTitle.isNotEmpty) const SizedBox(height: 5),
              if(state.validIDTitle.isNotEmpty) const Text(
                TextString.imageNote,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500
                )
              )
            ]
          )
        );
      }
    );
  }
}
