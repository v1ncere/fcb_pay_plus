import 'package:formz/formz.dart';

enum AccountDropdownValidationError { invalid, empty }

class AccountDropdown extends FormzInput<String?, AccountDropdownValidationError> {
  const AccountDropdown.pure() : super.pure(null);
  const AccountDropdown.dirty([super.value = '']) : super.dirty();

  @override
  AccountDropdownValidationError? validator(String? value) {
    return value == null
      ? AccountDropdownValidationError.empty
      : null;
  }
}

extension AccountDropdownValidationErrorX on AccountDropdownValidationError {
  String text() {
    switch(this) {
      case AccountDropdownValidationError.empty:
        return 'Please make a selection.';
      case AccountDropdownValidationError.invalid:
        return 'We couldn\'t load the options. Please try again later.';
    }
  }
}