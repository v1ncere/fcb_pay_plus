import 'package:formz/formz.dart';

enum FilterPopUpMenuValidationError { invalid, empty }

class FilterPopUpMenu extends FormzInput<String?, FilterPopUpMenuValidationError> {
  const FilterPopUpMenu.pure() : super.pure(null);
  const FilterPopUpMenu.dirty([super.value = '']) : super.dirty();

  @override
  FilterPopUpMenuValidationError? validator(String? value) {
    return value?.isEmpty == true
      ? FilterPopUpMenuValidationError.empty
      : null;
  }
}

extension FilterPopUpMenuValidationErrorX on FilterPopUpMenuValidationError {
  String text() {
    switch(this) {
      case FilterPopUpMenuValidationError.empty:
        return 'Please make a selection.';
      case FilterPopUpMenuValidationError.invalid:
        return 'We couldn\'t load the options. Please try again later.';
    }
  }
}