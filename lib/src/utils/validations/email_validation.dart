import 'package:formz/formz.dart';

class Email extends FormzInput<String, String> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return 'Field is Empty';
    } else if (value.length > 256) {
      return 'Input Value is Too Long';
    } else {
      return null;
    }
  }
}
