import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:cv/localizations/localization_en.dart';
import 'package:cv/localizations/localization_fr.dart';

abstract class Localization {
  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  String get appName;

  String get loginNoEmailTitle;
  String get loginNotEmailExplain;
  String get loginNoEmailExplain;
  String get loginNoPasswordTitle;
  String get loginNoPasswordExplain;
  String get loginCreateYourAccount;
  String get loginSignUp;
  String get loginPrivacyExplain;
  String get loginPrivacyReadCTA;
  String get loginSignInGoogleCTA;
  String get loginSignInFacebookCTA;
  String get loginAlreadyHaveAccountCTA;
  String get loginSignIn;
  String get loginSignInCTA;
  String get loginForgotPasswordCTA;
  String get loginNoAccountCTA;
  String get loginOr;

  String get forgotPasswordTitle;
  String get forgotPasswordExplain;
  String get forgotPasswordResetCTA;
  String get forgotPasswordNoEmailTitle;
  String get forgotPasswordNoEmailExplain;
  String get forgotPasswordSuccessMessage;
  String get forgotPasswordErrorMessage;

  String get homeTitle;
  String get homeWelcome;

  String get profileMyResume;

  String get settingsTitle;
  String get settingsToS;

  String get email;
  String get password;
  String get cancel;
  String get settings;
  String get account;
  String get login;
  String get logout;
  String get home;
  String get resume;
  String get profile;
  String get search;
  String get history;
  String get loadMore;
  String get errorOccurred;
  String get retry;
  String get yes;
  String get no;
  String get logged;
}

class CVLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const CVLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    final String name =
        (locale.countryCode == null || locale.countryCode.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if (locale.languageCode == "fr") {
      return LocalizationFR();
    } else {
      return LocalizationEN();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}
