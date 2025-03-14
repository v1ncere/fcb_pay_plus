import 'package:formz/formz.dart';

enum InstitutionDropdownValidationError { invalid, empty }

class InstitutionDropdown extends FormzInput<String?, InstitutionDropdownValidationError> {
  const InstitutionDropdown.pure() : super.pure(null);
  const InstitutionDropdown.dirty([super.value = '']) : super.dirty();

  @override
  InstitutionDropdownValidationError? validator(String? value) {
    return value == null
      ? InstitutionDropdownValidationError.empty
      : null;
  }
}

extension InstitutionDropdownValidationErrorX on InstitutionDropdownValidationError {
  String text() {
    switch(this) {
      case InstitutionDropdownValidationError.empty:
        return 'Please select an option.';
      case InstitutionDropdownValidationError.invalid:
        return 'Something went wrong. Please try again later.';
    }
  }
}