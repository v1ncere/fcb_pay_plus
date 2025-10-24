import 'package:formz/formz.dart';

enum UsernameValidationError { required, invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();
  
  @override
  UsernameValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? UsernameValidationError.required
      : null;
  }
}

extension UsernameValidationErrorX on UsernameValidationError {
  String text() {
    switch (this) {
      case UsernameValidationError.required:
        return 'Please enter a username.';
      case UsernameValidationError.invalid:
        return 'Invalid username. Please try again.';
    }
  }
}