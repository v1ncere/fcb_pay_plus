import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'home_buttons_event.dart';
part 'home_buttons_state.dart';

class HomeButtonsBloc extends Bloc<HomeButtonsEvent, HomeButtonsState> {
  HomeButtonsBloc() : super(HomeButtonsState()) {
    on<HomeButtonsFetched>(_onHomeButtonsFetched);
    on<HomeButtonsRefreshed>(_onHomeButtonsRefreshed);
  }

  void _onHomeButtonsFetched(HomeButtonsFetched event, Emitter<HomeButtonsState> emit ) async {
    emit(state.copyWith(status: Status.loading));
    
    try {
      final request = ModelQueries.list(Button.classType, where: Button.TYPE.eq('dashboard'));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;
      
      if (items != null && !response.hasErrors) {
        final buttonList = items.whereType<Button>().toList();
        
        if (buttonList.isNotEmpty) {
          buttonList.sort((a, b) => a.position!.compareTo(b.position!));
          emit(state.copyWith(status: Status.success, buttons: buttonList));
        } else {
          emit(state.copyWith(status: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }
  
  void _onHomeButtonsRefreshed(HomeButtonsRefreshed event, Emitter<HomeButtonsState> emit ) {
    add(HomeButtonsFetched());
  }
}
