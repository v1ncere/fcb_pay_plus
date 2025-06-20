import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../dynamic_viewer.dart';

class AccountText extends StatefulWidget {
  const AccountText({super.key, required this.widget, required this.accountNumber});
  final DynamicWidget widget;
  final String? accountNumber;
  
  @override
  State<AccountText> createState() => AccountState();
}

class AccountState extends State<AccountText> {
  
  @override
  void initState() {
    super.initState();
    context.read<WidgetsBloc>().add(SourceAccountFetched(widget.accountNumber ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetsBloc, WidgetsState>(
      builder: (context, state) {
        if (state.accountStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.accountStatus.isSuccess) {
          context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
            id: widget.widget.id,
            title: widget.widget.title ?? '',
            type: widget.widget.dataType ?? '',
            value: state.account.accountNumber,
          ));
          //
          return Padding(
            padding: EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: Card(
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
                  child: CustomRowText(
                    title: widget.widget.title ?? '',
                    titleColor: Colors.white,
                    content: state.account.accountNumber,
                    contentColor: Colors.white,
                  )
                )
              )
            ),
          );
        }
        if (state.accountStatus.isFailure) {
          return Center(child: Padding(
            padding: EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: Text(state.message),
          ));
        }
        // default display
        return SizedBox.shrink();
      }
    );
  }
}