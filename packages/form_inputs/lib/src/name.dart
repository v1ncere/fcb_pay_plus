import 'package:formz/formz.dart';

enum NameValidationError { required, invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  static final _noDigits = RegExp(r'^(?!.*\d).+$');
  
  @override
  NameValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? NameValidationError.required
      : _noDigits.hasMatch(value!)
        ? null
        : NameValidationError.invalid;
  }
}

extension NameValidationErrorX on NameValidationError {
  String text() {
    switch (this) {
      case NameValidationError.required:
        return 'This field is required.';
      case NameValidationError.invalid:
        return 'Please enter a valid value.';
    }
  }
}