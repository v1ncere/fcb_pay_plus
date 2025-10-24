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
        final bal = 0.0;
        return account != emptyAccount
        ? Card(
          elevation: 2.0,
          margin: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          color:const Color(0xFF25C166),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
                  account.accountType!.isNotEmpty
                  ? CustomRowText(
                    title: accountTypeNameString(account.accountType!.toLowerCase()),
                    titleColor: Colors.white,
                    titleFlex: 1,
                    content: 'Balance',
                    contentColor: Colors.white,
                    contentFontWeight: FontWeight.w600,
                    contentFlex: 1,
                  ) : const SizedBox.shrink(),
                  const SizedBox(height: 5),
                  CustomRowText(
                    title: '',
                    titleColor: Colors.white,
                    titleFlex: 1,
                    contentColor: Colors.white,
                    content: f.format(bal),
                    contentFlex: 1,
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