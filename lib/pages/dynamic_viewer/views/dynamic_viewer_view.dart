import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../../app/widgets/widgets.dart';
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../dynamic_viewer.dart';
import '../widgets/widgets.dart';

class DynamicViewerView extends StatelessWidget {
  const DynamicViewerView({super.key, required this.button, required this.accountNumber});
  final Button button;
  final String? accountNumber;
  static final FocusNode focusNode = FocusNode(); // this is for open dropdown buttons

  @override
  Widget build(BuildContext context) {
    return BlocListener<WidgetsBloc, WidgetsState>(
      listener: (context, state) {
        if(state.submissionStatus.isSuccess) {
          context.pushNamed(RouteName.receipt, pathParameters: {'receiptId': state.receiptId});
          _showSuccessDialog(context, TextString.transactionSuccess);
        }
        if(state.submissionStatus.isFailure) {
          _showFailureSnackbar(context, state.message);
        }
      },
      child: InactivityDetector(
        onInactive: () {
          FocusScope.of(context).requestFocus(focusNode); // close the dropdown
          context.goNamed(RouteName.authPin);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              button.title!,
              style: const TextStyle(fontWeight: FontWeight.w700)
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  context.read<InactivityCubit>().resumeTimer();
                  context.pop();
                },
                icon: const Icon(FontAwesomeIcons.x, size: 18)
              )
            ]
          ),
          body: BlocBuilder<WidgetsBloc, WidgetsState>(
            builder: (context, state) {
              if (state.widgetStatus.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: colorStringParser(button.iconColor!)
                  )
                );
              }
              if (state.widgetStatus.isSuccess) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                  child: state.dropdownHasData
                  ? Column(
                    children: [
                      SourceAccountCard(), // this will display if source account is fetch
                      SizedBox(height: 10),
                      CustomCardContainer(
                        color: const Color(0xFFFFFFFF),
                        children: state.widgetList.map((widget) {
                          switch(widget.widgetType) {
                            case 'accounttext':
                              return AccountText(widget: widget, accountNumber: accountNumber);
                            case 'walletaccounttext':
                              return WalletAccountText(widget: widget); // This is for Destination Account, no fetching needed
                            case 'dropdown':
                              return DropdownDisplay(accountNumber: accountNumber, focusNode: focusNode, dynamicWidget: widget);
                            case 'textfield':
                              return DynamicTextfield(widget: widget);
                            case 'text':
                              return DynamicText(widget: widget);
                            case 'multitextfield':
                              return MultiTextfield(widget: widget);
                            case 'button':
                              return SubmitButton(widget: widget, button: button);
                            default:
                              return const SizedBox.shrink();
                          }
                        }).toList()
                      )
                    ]
                  )
                  : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        TextString.transactionDisabled,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold
                        )
                      )
                    )
                  )
                );
              }
              if (state.widgetStatus.isFailure) {
                return Center(child: Text(state.message));
              }
              // default
              return const SizedBox.shrink();
            }
          )
        )
      )
    );
  }

    // show success dialog 
  void _showSuccessDialog(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.solidCircleCheck,
      backgroundColor: ColorString.eucalyptus,
      foregroundColor: ColorString.mystic
    ));
  }

  // show failure snackbar
  void _showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(customSnackBar(
      text: message,
      icon: FontAwesomeIcons.triangleExclamation,
      backgroundColor: ColorString.guardsmanRed,
      foregroundColor: ColorString.mystic
    ));
  }
}