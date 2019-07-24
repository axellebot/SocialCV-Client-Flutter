import 'dart:async';

enum ValidationErrors {
  ERROR_LOGIN_NO_EMAIL,
  ERROR_LOGIN_NOT_EMAIL,
  ERROR_LOGIN_NO_PASSWORD
}

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    print('PerformEmailValidation : $email');
    final RegExp regExp =
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    if (email.isEmpty) {
      sink.addError(ValidationErrors.ERROR_LOGIN_NO_EMAIL);
    } else if (!regExp.hasMatch(email)) {
      sink.addError(ValidationErrors.ERROR_LOGIN_NOT_EMAIL);
    } else {
      print('PerformEmailValidation : $email is correct');
      sink.add(email);
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    print('PerformPasswordValidation : HIDDEN');
    if (password.isEmpty) {
      sink.addError(ValidationErrors.ERROR_LOGIN_NO_PASSWORD);
    } else {
      print('PerformPasswordValidation : HIDDEN is correct');
      sink.add(password);
    }
  });
}
