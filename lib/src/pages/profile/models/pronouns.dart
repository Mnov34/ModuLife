import 'package:formz/formz.dart';

enum PronounsValidationError { empty }

class Pronouns extends FormzInput<String, PronounsValidationError> {
  const Pronouns.pure() : super.pure('');
  const Pronouns.dirty([super.value = '']) : super.dirty();

  @override
  PronounsValidationError? validator(String value) {
    if (value.isEmpty) return PronounsValidationError.empty;
    return null;
  }
}