import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_stepper_state.dart';

class TopStepperCubit extends Cubit<TopStepperState> {
  TopStepperCubit({required this.length}) : super(TopStepperState(length: length));
  final int length;

  void goNext() => emit(state.copyWith(step: (state.step < length) ? state.step + 1 : state.step));

  void goPrevious() => emit(state.copyWith(step: (state.step > 1) ? state.step - 1 : state.step));
}
