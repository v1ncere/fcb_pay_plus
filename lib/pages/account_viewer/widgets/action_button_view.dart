import 'package:flutter/material.dart';

import 'widgets.dart';

class ActionButtonView extends StatelessWidget {
  const ActionButtonView({super.key, required this.accountNumber});
  final String accountNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( 
            'Actions',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w900
            )
          ),
          Divider(color: Color(0xFF25C166)),
          SizedBox(height: 10),
          GridViewButtons(accountNumber: accountNumber)
        ]
      )
    );
  }
}