part of 'account_settings_bloc.dart';

sealed class AccountSettingsEvent extends Equatable {
  const AccountSettingsEvent();

  @override
  List<Object> get props => [];
}

final class AccountEventPressed extends AccountSettingsEvent {
  const AccountEventPressed({
    required this.account,
    required this.method
  });
  final Account account;
  final Settings method;

  @override
  List<Object> get props => [account, method];
}
