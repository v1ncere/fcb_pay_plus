import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';
import '../sign_up.dart';

class UserImage extends StatelessWidget {
  const UserImage({required this.picker, super.key});
  final ImagePicker picker;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => _settingModalBottomSheet(context),
              child: _buildImageContainer(context, state),
            );
          }
        )
      ]
    );
  }

  Widget _buildImageContainer(BuildContext context, SignUpState state) {
    Color backgroundColor = ColorString.emerald;
    Widget child = Icon(FontAwesomeIcons.cameraRetro, color: ColorString.white);
    BoxDecoration decoration = BoxDecoration(
      color: backgroundColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(15)
    );

    if (state.imageStatus.isLoading) {
      child = SpinKitChasingDots(color: ColorString.white, size: 18);
    }
    if (state.imageStatus.isSuccess) {
      child = const SizedBox.shrink();
      decoration = decoration.copyWith(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: FileImage(File(state.userImage!.path))
        )
      );
    }
    if (state.imageStatus.isFailure) {
      backgroundColor = ColorString.zombie;
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FontAwesomeIcons.circleInfo, size: 18, color: ColorString.white),
          Text(
            TextString.imageRetake,
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorString.white, fontWeight: FontWeight.bold),
          )
        ],
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: decoration.copyWith(color: backgroundColor),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: child)
      ),
    );
  }

  Future<void> _settingModalBottomSheet(BuildContext context) async {
    context.read<SignUpBloc>().add(const HydrateStateChanged(isHydrated: true));
    showModalBottomSheet(
      backgroundColor: ColorString.eucalyptus,
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              title: Text(
                'Gallery', 
                style: TextStyle(
                  color: ColorString.white,
                  fontWeight: FontWeight.bold
                )
              ),
              onTap: () => _imageSelector(context, ImageSource.gallery)
            ),
            ListTile(
              title: Text(
                'Camera', 
                style: TextStyle(
                  color: ColorString.white,
                  fontWeight: FontWeight.bold
                )
              ),
              onTap: () => _imageSelector(context, ImageSource.camera)
            )
          ]
        );
      }
    );
  }

  Future<void> _imageSelector(BuildContext context, ImageSource source) async {
    await picker.pickImage(source: source).then((image) {
      if(image != null) {
        if(context.mounted) context.read<SignUpBloc>().add(UserImageChanged(image));
      }
      if(context.mounted) Navigator.of(context).pop();
    });
  }
}

