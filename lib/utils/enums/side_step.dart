enum SideStep { unknown, toOtp, inOtp }

extension SideStepX on SideStep {
  bool get isUnknown => this == SideStep.unknown;
  bool get isToOtp => this == SideStep.toOtp;
  bool get isInOtp => this == SideStep.inOtp;
}