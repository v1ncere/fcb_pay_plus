part of 'dropdown_bloc.dart';

sealed class DropdownEvent extends Equatable {
  const DropdownEvent();

  @override
  List<Object?> get props => [];
}

final class DropdownFetched extends DropdownEvent {
  const DropdownFetched({
    required this.node, 
    required this.uid
  });
  final String node;
  final String uid;

  @override
  List<Object?> get props => [node, uid];
}