enum AccountType { unknown, wallet, pitakard, plc, sa, dd, loans }

extension AccountTypeX on AccountType {
  bool get isUnknown => this == AccountType.unknown;
  bool get isWallet => this == AccountType.wallet;
  bool get isSavings => this == AccountType.sa;
  bool get isPitakard => this == AccountType.pitakard;
  bool get isPLC => this == AccountType.plc;
  bool get isDD => this == AccountType.dd;
  bool get isLoans => this == AccountType.loans;
}

String accountTypeName(AccountType type) {
  switch(type) {
    case AccountType.wallet:
      return 'Wallet';
    case AccountType.pitakard:
      return 'PITAKArd';
    case AccountType.plc:
      return 'PITAKArd Line of Credit';
    case AccountType.sa:
      return 'Savings Account';
    case AccountType.dd:
      return 'Demand Draft';
    case AccountType.loans:
      return 'Loans';
    case AccountType.unknown:
      return '';
  }
}

String accountTypeNameString(String type) {
  switch(type) {
    case 'wallet':
      return 'Wallet';
    case 'pitakard':
      return 'PITAKArd';
    case 'plc':
      return 'PITAKArd Line of Credit';
    case 'sa':
      return 'Savings Account';
    case 'dd':
      return 'Demand Draft';
    case 'loans':
      return 'Loans';
    default:
      return type;
  }
}

