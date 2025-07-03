import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart';
import '../scanner_transaction.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerTransactionBloc, ScannerTransactionState>(
      builder: (context, state) {
        return state.formStatus.isInProgress
        ? Center(
            child: SpinKitCircle(
              color: ColorString.eucalyptus,
              size: 26,
            )
          )
        : ElevatedButton(
          onPressed: state.isValid
          ? () => context.read<ScannerTransactionBloc>().add(ScannerTransactionSubmitted())
          : null,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
            elevation: WidgetStateProperty.all(2),
            backgroundColor: WidgetStateProperty.all(const Color(0xFF25C166)) 
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('PAY',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 5),
              Icon(
              FontAwesomeIcons.coins, 
                color: Colors.white,
                size: 20
              )
            ]
          )
        );
      }
    );
  }
}