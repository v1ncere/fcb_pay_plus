enum AccountType { unknown, wallet, pitakard, plc, sa, dd, loans, card, deposit }

extension AccountTypeX on AccountType {
  bool get isUnknown => this == AccountType.unknown;
  bool get isWallet => this == AccountType.wallet;
  bool get isSavings => this == AccountType.sa;
  bool get isPitakard => this == AccountType.pitakard;
  bool get isPLC => this == AccountType.plc;
  bool get isDD => this == AccountType.dd;
  bool get isLoans => this == AccountType.loans;
  bool get isCard => this == AccountType.card;
  bool get isDeposit => this == AccountType.deposit;
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
    case AccountType.card:
      return 'PITAKArd (Card)';
    case AccountType.deposit:
      return 'Regular Deposit';
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
    case 'card':
      return 'PITAKArd (Card)';
    case 'deposit':
      return 'Regular Deposit';
    default:
      return type;
  }
}

