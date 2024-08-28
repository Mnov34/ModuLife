import 'package:formz/formz.dart';

enum AgeValidationError { empty }

class Age extends FormzInput<String, AgeValidationError> {
  const Age.pure() : super.pure('');
  const Age.dirty([super.value = '']) : super.dirty();

  @override
  AgeValidationError? validator(String value) {
    if (value.isEmpty) return AgeValidationError.empty;
    return null;
  }
}