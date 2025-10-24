import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../utils/utils.dart';
import '../bloc/merchant_add_bloc.dart';
import '../widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Merchant',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorString.eucalyptus
          )
        ),
        actions: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(FontAwesomeIcons.x, size: 18)
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<MerchantAddBloc, MerchantAddState>(
        builder: (context, state) {
          if (state.fetchStatus.isLoading) {
            return const ListTileShimmer();
          }
          if (state.fetchStatus.isSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.merchants.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final merchant = state.merchants[index];
                      return Slidable(
                        key: ValueKey(merchant),
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => context.read<MerchantAddBloc>().add(MerchantAddDeleted(merchant.id)),
                              backgroundColor: ColorString.guardsmanRed,
                              foregroundColor: ColorString.white,
                              icon: FontAwesomeIcons.trash,
                              label: 'Delete',
                              flex: 1,
                            )
                          ]
                        ),
                        child: ListTile(
                          key: ValueKey(merchant),
                          leading: Text('${index + 1}'),
                          title: Text(merchant.name),
                          subtitle: Text(merchant.tag),
                          horizontalTitleGap: 0, // gap between title and leading
                          onTap: () {
                            showDialog(
                              context: context,
                              useRootNavigator: false,
                              builder: (ctx) => showHistoryDialog(ctx, merchant.qrCode)
                            );
                          }
                        )
                      );
                    }
                  )
                ),
                _iconScannerButton(context)
              ]
            );
          }
          if (state.fetchStatus.isFailure) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w700
                      )
                    )
                  )
                ),
                _iconScannerButton(context)
              ]
            );
          }
          // default display
          return SizedBox.shrink();
        }
      )
    );
  }

  // *** UTILITY METHODS ***

  Widget _iconScannerButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor: ColorString.eucalyptus,
            foregroundColor: Colors.white,
          ),
          onPressed: () => context.read<MerchantAddBloc>().add(MerchantIsScannerChanged(Scanner.scanner)),
          child: Icon(FontAwesomeIcons.qrcode, size: 20)
        )
      )
    );
  }

  Dialog showHistoryDialog(BuildContext context, String qr) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qr,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ]
        )
      )
    );
  }
}