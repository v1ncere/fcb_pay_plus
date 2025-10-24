import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';
import '../widgets/widgets.dart';

class ValidIdCheckScreen extends StatelessWidget {
  const ValidIdCheckScreen({super.key});
  static final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState> (
      builder: (context, state) {
        if (state.faceComparisonStatus.isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: SpinKitFadingCircle(
                color: ColorString.eucalyptus,
                size: 30,
              )
            )
          );
        }
        // default display
        return Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let\'s Verify You', 
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54
                )
              ),
              SizedBox(height: 20),
              const ValidIdDropdown(),
              const SizedBox(height: 20),
              if (state.validIDTitle.isValid) UserImage(picker: picker),
              if (state.validIDTitle.isValid) const SizedBox(height: 5),
              if (state.validIDTitle.isValid) const Text(
                TextString.imageNote,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12,
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
