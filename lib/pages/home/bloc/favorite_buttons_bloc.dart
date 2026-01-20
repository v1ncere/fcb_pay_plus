import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart';
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'favorite_buttons_event.dart';
part 'favorite_buttons_state.dart';

class FavoriteButtonsBloc extends Bloc<FavoriteButtonsEvent, FavoriteButtonsState> {
  final SqfliteRepositories _sqfliteRepositories;
  FavoriteButtonsBloc({
    required SqfliteRepositories sqfliteRepositories
  }) : _sqfliteRepositories = sqfliteRepositories,
  super(FavoriteButtonsState()) {
    on<FavoriteButtonsFetched>(_onFavoriteButtonsFetched);
    on<FavoriteButtonsRefreshed>(_onFavoriteButtonsRefreshed);
  }

  Future<void>  _onFavoriteButtonsFetched(FavoriteButtonsFetched event, Emitter<FavoriteButtonsState> emit) async {
    try {
      final ids = await _sqfliteRepositories.getAllFavorites();
      
      if (ids.isNotEmpty) {
        final futures = ids.map((id) {
          final request = ModelQueries.get(Button.classType, ButtonModelIdentifier(id: id.id));
          return Amplify.API.query(request: request).response;
        });

        final responses = await Future.wait(futures);
        final buttons = List<Button>.from(state.buttons);
        final res = responses.map((r) => r.data).whereType<Button>().toList();
        buttons.addAll(res);
        emit(state.copyWith(status: Status.success, buttons: buttons));
      } else {
        emit(state.copyWith(status: Status.failure, message: TextString.empty));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (_) {
      emit(state.copyWith(status: Status.failure, message: TextString.empty));
    }
  }

  void _onFavoriteButtonsRefreshed(FavoriteButtonsRefreshed event, Emitter<FavoriteButtonsState> emit) {
    add(FavoriteButtonsFetched());
  }
}