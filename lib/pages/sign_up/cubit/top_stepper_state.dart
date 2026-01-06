part of 'top_stepper_cubit.dart';

class TopStepperState extends Equatable {
  final int step;
  final int length;
  final bool isOtp;
  
  const TopStepperState({
    this.step = 1,
    required this.length,
    this.isOtp = false,
  });

  TopStepperState copyWith({
    int? step,
    int? length,
    bool? isOtp,
  }) {
    return TopStepperState(
      step: step ?? this.step,
      length: length ?? this.length,
      isOtp: isOtp ?? this.isOtp,
    );
  }

  @override
  List<Object> get props => [
    step,
    length,
    isOtp
  ];
}
