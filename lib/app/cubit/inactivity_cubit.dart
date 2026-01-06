import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inactivity_state.dart';

const minuteCount = 300; // 5 minutes
const longMinuteCount = 20000; // 10 minutes

class InactivityCubit extends Cubit<InactivityState> {
  InactivityCubit() : super(const InactivityState());
  Timer? _timer;

  void resetTimer() {
    _timer?.cancel(); // cancel the timer
    emit(state.copyWith(status: InactivityStatus.active));
    // timer is NOT paused
    if (!state.isTimerPaused) { // TODO: change into muniteCount and remove longMinuteCount for production
      _timer = Timer(const Duration(seconds: longMinuteCount), () => emit(state.copyWith(status: InactivityStatus.inactive)));
    }
  }

  void pauseTimer() {
    _timer?.cancel(); // cancel the timer
    emit(state.copyWith(status: InactivityStatus.active, isTimerPaused: true));
  }

  void resumeTimer() {
    emit(state.copyWith(status: InactivityStatus.initial, isTimerPaused: false));
    resetTimer();
  }

  @override
  Future<void> close() async {
    _timer?.cancel(); // cancel the timer
    return super.close();
  }
}
