enum AccountType { unknown, wlt, ppr, psa, plc }

extension AccountTypeX on AccountType {
  bool get isUnknown => this == AccountType.unknown;
  bool get isWallet => this == AccountType.wlt;
  bool get isSavings => this == AccountType.psa;
  bool get isPayroll => this == AccountType.ppr;
  bool get isPLC => this == AccountType.plc;
}

String accountTypeName(AccountType type) {
  switch(type) {
    case AccountType.wlt:
      return 'Wallet';
    case AccountType.ppr:
      return 'Pitakard Payroll';
    case AccountType.psa:
      return 'Pitakard Savings';
    case AccountType.plc:
      return 'Pitakard Line of Credit';
    case AccountType.unknown:
      return '';
  }
}

String accountTypeNameString(String type) {
  switch(type) {
    case 'wlt':
      return 'Wallet';
    case 'ppr':
      return 'Pitakard Payroll';
    case 'psa':
      return 'Pitakard Savings';
    case 'plc':
      return 'Pitakard Line of Credit';
    default:
      return type;
  }
}

