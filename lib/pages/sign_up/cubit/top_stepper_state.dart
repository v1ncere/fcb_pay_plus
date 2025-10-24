part of 'top_stepper_cubit.dart';

class TopStepperState extends Equatable {
  const TopStepperState({
    this.step = 1,
    required this.length,
  });
  final int step;
  final int length;

  TopStepperState copyWith({
    int? step,
    int? length,
  }) {
    return TopStepperState(
      step: step ?? this.step,
      length: length ?? this.length,
    );
  }

  @override
  List<Object> get props => [step, length];
}
