import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../scanner_transaction.dart';
import '../widgets/widgets.dart';

class ScannerTransactionView extends StatelessWidget {
  const ScannerTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InactivityDetector(
        onInactive: () => context.goNamed(RouteName.authPin),
        child: BlocListener<ScannerTransactionBloc, ScannerTransactionState>(
          listener: (context, state) {
            if(state.formStatus.isSuccess) {
              context.pushNamed(RouteName.receipt, pathParameters: {'receiptId': state.receiptId});
              _showSuccessDialog(context, TextString.transactionSuccess);
            }
            if(state.formStatus.isFailure) {
              _showFailureSnackbar(context, state.message);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Transaction',
                style: TextStyle(
                  color: ColorString.jewel,
                  fontWeight: FontWeight.w700
                )
              ),
              actions: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(FontAwesomeIcons.x, size: 18)
                )
              ]
            ),
            body: const Padding(
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QrDataDisplay(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(text: 'Account:', color: Colors.black54)
                      ]
                    ),
                    SizedBox(height: 10),
                    AccountCardInfo(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(text: 'Amount:', color: Colors.black54),
                      ]
                    ),
                    SizedBox(height: 5),
                    AmountInput(),
                    SizedBox(height: 10),
                    Divider(thickness: 2), // line divider ---------------------
                    SizedBox(height: 5),
                    CustomText(text: TextString.paymentNote,
                      fontSize: 12,
                      color: Colors.teal
                    ),
                    SizedBox(height: 15),
                    SubmitButton(),
                    SizedBox(height: 20)
                  ]
                )
              )
            )
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