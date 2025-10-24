part of 'merchant_add_bloc.dart';

class MerchantAddState extends Equatable {
  const MerchantAddState({
    this.scanner = Scanner.initial,
    this.merchants = const <MerchantModel>[],
    this.createStatus = Status.initial,
    this.fetchStatus = Status.initial,
    this.message = '',
  });
  
  final Scanner scanner;
  final List<MerchantModel> merchants;
  final Status createStatus;
  final Status fetchStatus;
  final String message;

  MerchantAddState copyWith({
    Scanner? scanner,
    List<MerchantModel>? merchants,
    Status? createStatus,
    Status? fetchStatus,
    String? message,
  }) {
    return MerchantAddState(
      scanner: scanner ?? this.scanner,
      merchants: merchants ?? this.merchants,
      createStatus: createStatus ?? this.createStatus,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object> get props => [scanner, merchants, createStatus, fetchStatus, message];
}

enum Scanner { initial, scanner, display }

extension ScannerX on Scanner {
  bool get isInitial => this == Scanner.initial;
  bool get isScanner => this == Scanner.scanner;
  bool get isDisplay => this == Scanner.display;
}