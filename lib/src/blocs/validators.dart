import 'dart:async';

import 'package:cv/src/localizations/localization.dart';
import 'package:flutter/material.dart';

class Validators extends Object {
  StreamTransformer performEmailValidation(BuildContext context) {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (email, sink) {
      print('PerformEmailValidation : $email');
      final RegExp regExp =
          RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
      if (email.isEmpty) {
        sink.addError(Localization.of(context).loginNoEmailExplain);
      } else if (!regExp.hasMatch(email)) {
        sink.addError(Localization.of(context).loginNotEmailExplain);
      } else {
        print('PerformEmailValidation : $email is correct');
        sink.add(email);
      }
    });
  }

  StreamTransformer performPasswordValidation(BuildContext context) {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (password, sink) {
      print('PerformPasswordValidation : $password');
      if (password.isEmpty) {
        sink.addError(Localization.of(context).loginNoPasswordExplain);
      } else {
        print('PerformPasswordValidation : $password is correct');
        sink.add(password);
      }
    });
  }
}
