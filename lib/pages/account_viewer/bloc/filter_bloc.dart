import 'package:amplify_api/amplify_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<FilterFetched>(_onFilteredFetched);
  }

  void _onFilteredFetched(FilterFetched event, Emitter<FilterState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<String> filterList = SearchFilter.values.map((e) => e.name).toList();
      emit(state.copyWith(status: Status.success, filters: filterList));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
