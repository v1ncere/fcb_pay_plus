import 'package:formz/formz.dart';

enum EmailValidationError { required, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();
  static final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
  
  @override
  EmailValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? EmailValidationError.required
      : _emailRegExp.hasMatch(value!)
        ? null
        : EmailValidationError.invalid;
  }
}

extension EmailValidationErrorX on EmailValidationError {
  String text() {
    switch (this) {
      case EmailValidationError.required:
        return 'Please enter your email address.';
      case EmailValidationError.invalid:
        return 'Please enter a valid email address.';
    }
  }
}