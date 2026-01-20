import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../../notifications/notifications.dart';
import '../home.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      icon: const Icon(FontAwesomeIcons.bars, color: Colors.black45)
    ),
    title: Text('Hello, ${context.select((AccountsHomeBloc bloc) => bloc.state.username)}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorString.eucalyptus,
        fontSize: 18
      )
    ),
    actions: [
      IconButton(
        splashRadius: 25,
        icon: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            final isRead = state.notifications.every((e) => e.isRead == true);
            return isRead 
            ? Icon(
                FontAwesomeIcons.solidBell,
                color: ColorString.eucalyptus
              )
            : Badge(
                child: Icon(
                  FontAwesomeIcons.solidBell,
                  color: ColorString.eucalyptus
                )
              );
          }
        ),
        onPressed: () => context.pushNamed(RouteName.notification),
      ),
      IconButton(
        splashRadius: 25,
        icon: Icon(
          FontAwesomeIcons.circleQuestion,
          color: ColorString.eucalyptus
        ),
        onPressed: () {}
      ),
    ],
    bottom: TabBar(
      indicatorColor: ColorString.eucalyptus,
      labelColor: ColorString.eucalyptus,
      unselectedLabelColor: Colors.black45,
      tabs: const [
        Tab(text: 'Dashboard'),
        Tab(text: 'Accounts'),
      ]
    )
  );
} 