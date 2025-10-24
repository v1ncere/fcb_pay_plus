import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';
import '../scanner_transaction.dart';

class AccountCardInfo extends StatefulWidget {
  const AccountCardInfo({super.key});
  
  @override
  State<AccountCardInfo> createState() => AccountCardInfoState();
}

class AccountCardInfoState extends State<AccountCardInfo> {
  
  @override
  void initState() {
    super.initState();
    context.read<ScannerTransactionBloc>().add(ScannerSourceAccountFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerTransactionBloc, ScannerTransactionState> (
      builder: (context, state) {
        if (state.accountStatus.isLoading) {
          return Center(
            child: SpinKitCircle(
              color: ColorString.eucalyptus,
              size: 26,
            )
          );
        }
        if (state.accountStatus.isSuccess) {
          final f = NumberFormat('#,##0.00', 'en_US');
          final account = state.account;
          final bal = 0.0;
          return Card(
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
                    CustomRowText(
                      title: 'Balance',
                      titleColor: Colors.white,
                      titleFlex: 1,
                      contentColor: Colors.white,
                      content: f.format(bal),
                      contentFlex: 1,
                    ),
                    const SizedBox(height: 20),
                    account.accountType!.isNotEmpty
                    ? CustomRowText(
                      title: accountTypeNameString(account.accountType!.toLowerCase()),
                      titleColor: Colors.white,
                      titleFlex: 1,
                      contentColor: Colors.white,
                      content: account.accountNumber.replaceRange(0,  account.accountNumber.length - 4, '***'),
                      contentFontSize: 12,
                      contentFlex: 1,
                    ) : const SizedBox.shrink(),
                  ]
                )
              )
            )
          );
        }
        if (state.accountStatus.isFailure) {
          return Center(
            child: Text(state.message)
          );
        }
        // default display
        return const SizedBox.shrink();
      }
    );
  }
}