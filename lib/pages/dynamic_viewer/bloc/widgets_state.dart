part of 'widgets_bloc.dart';

class WidgetsState extends Equatable {
  const WidgetsState({
    required this.account,
    this.widgetList = const <DynamicWidget>[],
    this.extraWidgetList = const <DynamicWidget>[],
    this.uid = '',
    this.receiptId = '',
    this.accountStatus = Status.initial,
    this.userIdStatus = Status.initial,
    this.widgetStatus = Status.initial,
    this.extraWidgetStatus = Status.initial,
    this.submissionStatus = Status.initial,
    this.dropdownHasData = true,
    this.message = '',
  });
  final Account account;
  final List<DynamicWidget> widgetList;
  final List<DynamicWidget> extraWidgetList;
  final String uid;
  final String receiptId;
  final Status accountStatus;
  final Status userIdStatus;
  final Status widgetStatus;
  final Status extraWidgetStatus;
  final Status submissionStatus;
  final bool dropdownHasData;
  final String message;

  WidgetsState copyWith({
    Account? account,
    List<DynamicWidget>? widgetList,
    List<DynamicWidget>? extraWidgetList,
    String? uid,
    String? receiptId,
    Status? accountStatus,
    Status? userIdStatus,
    Status? widgetStatus,
    Status? extraWidgetStatus,
    Status? submissionStatus,
    bool? dropdownHasData,
    String? message,
  }) {
    return WidgetsState(
      account: account ?? this.account,
      widgetList: widgetList ?? this.widgetList,
      extraWidgetList: extraWidgetList ?? this.extraWidgetList,
      uid: uid ?? this.uid,
      receiptId: receiptId ?? this.receiptId,
      accountStatus: accountStatus ?? this.accountStatus,
      userIdStatus: userIdStatus ?? this.userIdStatus,
      widgetStatus: widgetStatus ?? this.widgetStatus,
      extraWidgetStatus: extraWidgetStatus ?? this.extraWidgetStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      dropdownHasData: dropdownHasData ?? this.dropdownHasData,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object?> get props => [
    account,
    widgetList,
    extraWidgetList,
    uid,
    receiptId,
    accountStatus,
    userIdStatus,
    widgetStatus,
    extraWidgetStatus,
    submissionStatus,
    dropdownHasData,
    message,
  ];
}