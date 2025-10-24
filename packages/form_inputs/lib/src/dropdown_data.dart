import 'package:formz/formz.dart';

enum DropdownDataError { required, invalid }

class DropdownData extends FormzInput<String?, DropdownDataError> {
  const DropdownData.pure() : super.pure(null);
  const DropdownData.dirty([super.value]) : super.dirty();

  // static final _noDigits = RegExp(r'^(?!.*\d).+$');
  
  @override
  DropdownDataError? validator(String? value) {
    return value == null || value.isEmpty 
    ? DropdownDataError.required 
    : null;
  }
}

extension DropdownDataErrorX on DropdownDataError {
  String text() {
    switch (this) {
      case DropdownDataError.required:
        return 'This field is required.';
      case DropdownDataError.invalid:
        return 'Please enter a valid value.';
    }
  }
}