import 'dart:async';

import 'package:cv/src/localizations/localization_en.dart';
import 'package:cv/src/localizations/localization_fr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class Localization {
  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  // App
  String get appName;

  // Login Page
  String get loginTitle;

  String get loginNoEmailTitle;

  String get loginNotEmailExplain;

  String get loginNoEmailExplain;

  String get loginNoPasswordTitle;

  String get loginNoPasswordExplain;

  String get loginCreateYourAccount;

  String get loginSignUpCTA;

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

  // Home
  String get homeTitle;

  String get homeWelcome;

  // Account Page
  String get accountMyProfile;

  // Profile Page
  String get profileTitle;

  // Settings Page
  String get settingsTitle;

  String get settingsThemeCTA;

  String get settingsThemeDefault;

  String get settingsThemeLight;

  String get settingsThemeDark;

  // Search Page
  String get searchTitle;

  String get searchSearchBarHint;

  // Part Widget
  String get partWidgetDetails;

  // Part List
  String get partListOptions;

  String get partListSorting;

  String get partListItemPerPage;

  String get partListLoadMore;

  // Sort Dialog
  String get sortDialogCancel;

  String get sortDialogConfirm;

  // Exception Error
  String get exceptionFormatException;

  String get exceptionTimeoutException;

  // Api Error
  String get apiErrorWrongPasswordError;

  String get apiErrorUserNotFoundError;

  // Server Error : HTTP 400
  String get httpClientErrorBadRequest;

  String get httpClientErrorPaymentRequired;

  String get httpClientErrorForbidden;

  String get httpClientErrorNotFound;

  String get httpClientErrorMethodNotAllowed;

  String get httpClientErrorNotAcceptable;

  String get httpClientErrorRequestTimeout;

  String get httpClientErrorConflict;

  String get httpClientErrorGone;

  String get httpClientErrorLengthRequired;

  String get httpClientErrorPayloadTooLarge;

  String get httpClientErrorURITooLong;

  String get httpClientErrorUnsupportedMediaType;

  String get httpClientErrorExpectationFailed;

  String get httpClientErrorUpgradeRequired;

  // Server Error : HTTP 500
  String get httpServerErrorInternalServerError;

  String get httpServerErrorNotImplemented;

  String get httpServerErrorBadGateway;

  String get httpServerErrorServiceUnavailable;

  String get httpServerErrorGatewayTimeout;

  String get httpServerErrorHttpVersionNotSupported;

  // Menu Widget

  String get menuPPCTA;

  String get menuToSCTA;

  // Others
  String get middleDot;

  String get username;

  String get email;

  String get password;

  String get token;

  String get cancel;

  String get settingsCTA;

  String get account;

  String get login;

  String get loginCTA;

  String get logout;

  String get logoutCTA;

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

  String get more;

  String get forgotPasswordTitle;

  String get forgotPasswordExplain;

  String get forgotPasswordResetCTA;

  String get forgotPasswordNoEmailTitle;

  String get forgotPasswordNoEmailExplain;

  String get forgotPasswordSuccessMessage;

  String get forgotPasswordErrorMessage;
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
