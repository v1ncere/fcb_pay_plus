import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../home.dart';
import 'widgets.dart';

class FavoriteButtonsRow extends StatelessWidget {
  const FavoriteButtonsRow({super.key, required this.accountNumber});
  final String accountNumber;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteButtonsBloc, FavoriteButtonsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const ButtonShimmer();
        }
        if (state.status.isSuccess) {
          final visibleItems = state.buttons.take(max).toList();
          final hasMore = state.buttons.length > max;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...visibleItems.map(
                (items) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: LabeledSquareButton(
                    icon: iconMapper(items.icon!),
                    color: colorStringParser(items.iconColor!),
                    text: items.title!,
                    onTap: () => context.pushNamed(
                      RouteName.dynamicViewer, 
                      extra: items, 
                      pathParameters: {"accountNumber": accountNumber}
                    )
                  )
                )
              ),
              if (hasMore)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: OutlinedButton(
                    onPressed: () {}, // push to button page another page
                    child: const Icon(
                      Icons.more_horiz,
                      size: 32,
                    )
                  )
                ),
            ]
          );
        }
        if (state.status.isFailure) {
          return Center(
            child: Image.asset(
              AssetString.inboxEmptyPng,
              height: 80,
              width: 80,
            )
          );
        }
        // default
        return const SizedBox.shrink(); 
      }
    );
  }
}