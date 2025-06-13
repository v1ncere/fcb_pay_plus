part of 'widgets_bloc.dart';

sealed class WidgetsEvent extends Equatable {
  const WidgetsEvent();

  @override
  List<Object> get props => [];
}

final class SourceAccountFetched extends WidgetsEvent {
  const SourceAccountFetched(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

final class UserIdFetched extends WidgetsEvent {}

final class WidgetsFetched extends WidgetsEvent {
  const WidgetsFetched(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class ExtraWidgetFetched extends WidgetsEvent {
  const ExtraWidgetFetched(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

final class DynamicWidgetsValueChanged extends WidgetsEvent {
  const DynamicWidgetsValueChanged({
    required this.id,
    required this.title,
    required this.value,
    required this.type
  });
  final String id;
  final String title;
  final String value;
  final String type;

  @override
  List<Object> get props => [id, title, value, type];
}

final class ExtraWidgetsValueChanged extends WidgetsEvent {
  const ExtraWidgetsValueChanged({
    required this.id,
    required this.title,
    required this.value,
    required this.type
  });
  final String id;
  final String title;
  final String value;
  final String type;

  @override
  List<Object> get props => [id, title, value, type];
}

final class ButtonSubmitted extends WidgetsEvent {
  const ButtonSubmitted(this.button);
  final Button button;

  @override
  List<Object> get props => [button];
}