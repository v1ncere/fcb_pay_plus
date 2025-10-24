import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';
import '../account_viewer.dart';
import 'widgets.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const ListTileShimmer();
        }
        if (state.status.isSuccess) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              final metrics = notification.metrics;
              if (metrics.atEdge) {
                bool isTop = metrics.pixels == 0;
                if (!isTop) {
                  context.read<TransactionHistoryBloc>().add(TransactionFetched(accountNumber: account.accountNumber));
                }
              }
              return true;
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height *.5,
              child: ListView.separated(
                itemCount: state.transactionList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final transaction = state.transactionList[index]; // specific [transaction] indexed
                  return ListTile(
                    key: ValueKey(transaction),
                    leading: Text('account type removed'),
                    title: Text(transaction.account!.accountNumber),
                    subtitle: Text('details removed', overflow: TextOverflow.ellipsis,),
                    trailing: CustomText(
                      text: getDynamicDateString(state.transactionList[index].createdAt!.getDateTimeInUtc().toLocal()),
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    horizontalTitleGap: 0, // gap between title and leading
                    onTap: () {
                      showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (ctx) => showHistoryDialog(ctx, transaction)
                      );
                    }
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1.0,
                    color: Color.fromARGB(50, 37, 193, 102),
                  );
                }
              ),
            )
          );
        }
        if (state.status.isFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w700
              )
            )
          );
        }
        
        return const SizedBox.shrink();
      }
    );
  }
  
  Dialog showHistoryDialog(BuildContext context, Transaction transaction) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transaction.account!.accountNumber, style: Theme.of(context).textTheme.labelLarge),
              Text('type removed', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 10),
              Text('details removed', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              Text(getDateString(transaction.createdAt!.getDateTimeInUtc().toLocal()), style: Theme.of(context).textTheme.bodySmall)
            ]
          )
        )
      )
    );
  }
}