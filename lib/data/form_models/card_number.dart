import 'package:formz/formz.dart';

enum CardNumberValidationError { required, invalid }

class CardNumber extends FormzInput<String, CardNumberValidationError> {
  const CardNumber.pure() : super.pure('');
  const CardNumber.dirty([super.value = '']) : super.dirty();

  static final RegExp _regExp = RegExp(r'^\d{4} \d{4} \d{4} \d{4}$');

  @override
  CardNumberValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? CardNumberValidationError.required
      : _regExp.hasMatch(value!)
        ? null
        : CardNumberValidationError.invalid;
  }
}

extension CardNumberValidationErrorX on CardNumberValidationError {
  String text() {
    switch (this) {
      case CardNumberValidationError.required:
        return 'A card number is required.';
      case CardNumberValidationError.invalid:
        return 'Please enter a valid card number.';
    }
  }
}