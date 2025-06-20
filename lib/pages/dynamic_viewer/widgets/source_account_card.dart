import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';
import '../bloc/widgets_bloc.dart';

class SourceAccountCard extends StatelessWidget {
  const SourceAccountCard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetsBloc, WidgetsState> (
      builder: (context, state) {
        final f = NumberFormat('#,##0.00', 'en_US');
        final account = state.account;
        return account != emptyAccount
        ? Card(
          elevation: 2.0,
          margin: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          color:const Color(0xFF25C166),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(AssetString.coverBG),
                colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.05), BlendMode.dstATop),
                fit: BoxFit.cover
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  account.type!.isNotEmpty
                  ? CustomRowText(
                    title: accountTypeNameString(account.type!.toLowerCase()),
                    titleColor: Colors.white,
                    content: '',
                  ) : const SizedBox.shrink(),
                  const SizedBox(height: 10),
                  CustomRowText(
                    title: 'Balance',
                    titleColor: Colors.white,
                    contentColor: Colors.white,
                    content: f.format(account.balance),
                  )
                ]
              )
            )
          )
        )
        : const SizedBox.shrink();
      }
    );
  }
}