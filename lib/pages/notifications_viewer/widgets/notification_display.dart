import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../notifications_viewer.dart';
import 'widgets.dart';

class NotificationDisplay extends StatelessWidget {
  const NotificationDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsViewerBloc, NotificationsViewerState>(
      builder: (context, state) {
        if (state is NotificationsViewerLoading) {
          return const LoadingScreen();
        }
        if (state is NotificationsViewerSuccess) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        state.notification.sender!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black54
                        )
                      )
                    ),
                    SizedBox(width: 5),
                    Text(
                      getDateString(state.notification.createdAt!.getDateTimeInUtc()),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12
                      )
                    )
                  ]
                ),
                const SizedBox(height: 10),
                Text(
                  state.notification.content!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black
                  )
                )
              ]
            )
          );
        }
        if (state is NotificationsViewerError) {
          return Center(
            child: Text(state.message),
          );
        } 
        // default display
        return const SizedBox.shrink();
      }
    );
  }
}