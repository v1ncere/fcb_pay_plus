import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../dynamic_viewer.dart';

// * This widget is for wallet destination only, 
// * any usage not meant for this will cause an error.
class WalletAccountText extends StatelessWidget {
  const WalletAccountText({super.key, required this.widget});
  final DynamicWidget widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetsBloc, WidgetsState>(
      builder: (context, state) {
        if (state.userIdStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: ShimmerRectLoading()
          );
        }
        if (state.userIdStatus.isSuccess) {
          context.read<WidgetsBloc>().add(DynamicWidgetsValueChanged(
            id: widget.id,
            title: widget.title ?? '',
            type: widget.dataType ?? '',
            value: state.uid,
          ));
          //
          return Padding(
            padding: EdgeInsets.only(top: 5.0 , bottom: 5.0),
            child: Card(
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
                  child: CustomRowText(
                    title: widget.title ?? '',
                    titleColor: Colors.white,
                    titleFontSize: 12,
                    titleFlex: 1,
                    content: state.uid,
                    contentColor: Colors.white,
                    contentFontWeight: FontWeight.w600,
                    contentFlex: 2,
                  )
                )
              )
            ),
          );
        }
        if (state.userIdStatus.isFailure) {
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