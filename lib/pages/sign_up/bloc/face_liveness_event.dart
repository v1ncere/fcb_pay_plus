part of 'face_liveness_bloc.dart';

sealed class FaceLivenessEvent extends Equatable {
  const FaceLivenessEvent();

  @override
  List<Object> get props => [];
}

final class FaceLivenessSessionIdFetched extends FaceLivenessEvent {}

final class FaceLivenessMethodChannelInvoked extends FaceLivenessEvent {}

final class FaceLivenessResultFetched extends FaceLivenessEvent {}
