import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/utils.dart';
import '../login.dart';
import '../widgets/widgets.dart';

class SaveMobileScreen extends StatelessWidget {
  const SaveMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // on loading
        if (state.deviceStatus.isLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: ColorString.jewel,
              size: 30,
            ),
          );
        }
        // on successful
        if (state.deviceStatus.isSuccess) {
          return _onSuccessDisplay(context);
        }
        // on failure
        if (state.deviceStatus.isFailure) {
          return _onFailureDisplay(context);
        }
        // default display
        return _onDefaultDisplay(context);
      }
    );
  }
}

Widget _onSuccessDisplay(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SaveDeviceImage(assetString: AssetString.mobileSuccess),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * .7,
          child: Column(
            children: [
              SaveDeviceTitleText(text: 'Device saved'),
              SizedBox(height: 10),
              SaveDeviceDescriptionText(text: 'The mobile device has been successfully saved to the app.')
            ]
          )
        ),
        SizedBox(height: 20),
        SaveDeviceGotoDashboardButton(),
      ]
    )
  );
}

Widget _onFailureDisplay(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SaveDeviceImage(assetString: AssetString.mobileProblem),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * .7,
          child: Column(
            children: [
              SaveDeviceTitleText(text: 'Saving failed'),
              SizedBox(height: 10),
              SaveDeviceDescriptionText(text: 'There was a problem saving the mobile device.')
            ]
          )
        ),
        SizedBox(height: 20),
        SaveDeviceTryAgainButton()
      ]
    )
  );
}

Widget _onDefaultDisplay(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SaveDeviceImageSvg(assetString: AssetString.mobileVerified),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * .7,
          child: Column(
            children: [
              SaveDeviceTitleText(text: 'Save this mobile device?'),
              SizedBox(height: 10),
              SaveDeviceDescriptionText(text: 'Save this device to easily sign in to your banking app again.'),
            ]
          )
        ),
        SizedBox(height: 20),
        SaveDeviceButton(),
        SizedBox(height: 5),
        SaveDeviceCancelButton(),
      ]
    )
  );
}