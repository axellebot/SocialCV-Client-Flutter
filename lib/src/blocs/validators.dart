import 'dart:async';

import 'package:cv/src/commons/logger.dart';

enum ValidationErrors {
  ERROR_LOGIN_NO_EMAIL,
  ERROR_LOGIN_NOT_EMAIL,
  ERROR_LOGIN_NO_PASSWORD
}

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    logger.info('PerformEmailValidation : $email');
    final RegExp regExp =
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    if (email.isEmpty) {
      sink.addError(ValidationErrors.ERROR_LOGIN_NO_EMAIL);
    } else if (!regExp.hasMatch(email)) {
      sink.addError(ValidationErrors.ERROR_LOGIN_NOT_EMAIL);
    } else {
      logger.info('PerformEmailValidation : $email is correct');
      sink.add(email);
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    logger.info('PerformPasswordValidation : $password');
    if (password.isEmpty) {
      sink.addError(ValidationErrors.ERROR_LOGIN_NO_PASSWORD);
    } else {
      print('PerformPasswordValidation : $password is correct');
      sink.add(password);
    }
  });
}
