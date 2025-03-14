import 'package:formz/formz.dart';

enum IntegerValidationError { required, invalid }

class Integer extends FormzInput<String, IntegerValidationError> {
  const Integer.pure() : super.pure('');
  const Integer.dirty([super.value = '']) : super.dirty();
  // match to only number
  static final _integerRegex = RegExp(r'^\d+$');

  @override
  IntegerValidationError? validator(String? value) {
    return value?.isEmpty == true
    ? IntegerValidationError.required
    : _integerRegex.hasMatch(value!)
      ? null
      : IntegerValidationError.invalid;
  }
}

extension IntegerValidationErrorX on IntegerValidationError {
  String text() {
    switch (this) {
      case IntegerValidationError.required:
        return 'Input is required.';
      case IntegerValidationError.invalid:
        return 'Input is invalid. Please try again.';
    }
  }
}