part of 'filter_bloc.dart';

class FilterState extends Equatable {
  const FilterState({
    this.filters = const [],
    this.status = Status.initial,
    this.message = ''
  });
  final List<String> filters;
  final Status status;
  final String message;

  FilterState copyWith({
    List<String>? filters,
    Status? status,
    String? message
  }) {
    return FilterState(
      filters: filters ?? this.filters,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }

  @override
  List<Object> get props => [filters, status, message];
}
