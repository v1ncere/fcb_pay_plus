import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../app/app.dart';
import '../../../models/ModelProvider.dart';
import '../../home/home.dart';
import '../dynamic_viewer.dart';

class DynamicViewerPage extends StatelessWidget {
  const DynamicViewerPage({super.key, required this.accountNumber, required this.button});
  final String? accountNumber;
  final Button button;
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // widgets bloc with event [widgets load] invoked
        BlocProvider(create: (context) => WidgetsBloc()
        ..add(SourceAccountFetched(accountNumber ?? ''))
        ..add(WidgetsFetched(button.id))
        ..add(UserIdFetched())),
        // dropdown bloc 
        BlocProvider(create: (context) => DropdownBloc()),
        // accounts home bloc with event [accounts home load] invoked
        BlocProvider(create: (context) => AccountsHomeBloc(hiveRepository: HiveRepository())
        ..add(AccountsHomeFetched())),
        // inactivity cubit with event [resume timer] invoked
        BlocProvider(create: (context) => InactivityCubit()
        ..resumeTimer()),
      ],
      child: DynamicViewerView(button: button)
    );
  }
}