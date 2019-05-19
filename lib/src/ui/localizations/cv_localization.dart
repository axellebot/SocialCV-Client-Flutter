import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization_en.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization_fr.dart';

abstract class CVLocalizations {
  static CVLocalizations of(BuildContext context) {
    return Localizations.of<CVLocalizations>(context, CVLocalizations);
  }

  /// App
  ///
  String get appName;

  /// Auth Page

  String get authTitle;

  /// Auth Stuff

  String get authNoEmailTitle;

  String get authNotEmailExplain;

  String get authNoEmailExplain;

  String get authNoPasswordTitle;

  String get authNotPasswordExplain;

  String get authNoPasswordExplain;

  String get authCreateYourAccount;

  String get authSignUp;

  String get authSignUpCTA;

  String get authSignUpSucceed;

  String get authSignUpFailed;

  String get authSignIn;

  String get authSignInCTA;

  String get authSignInGoogleCTA;

  String get authSignInFacebookCTA;

  String get authSignInSucceed;

  String get authSignInFailed;

  String get authLogout;

  String get authLogoutCTA;

  String get authLogoutSucceed;

  String get authLogoutFailed;

  String get authPrivacyExplain;

  String get authPrivacyReadCTA;

  String get authAlreadyHaveAccountCTA;

  String get authForgotPasswordCTA;

  String get authNoAccountCTA;

  String get authOr;

  /// Home Page
  String get homeTitle;

  String get homeCTA;

  String get homeWelcome;

  /// Account Page

  String get accountTitle;

  String get accountCTA;

  String get accountMyProfile;

  /// Profile Page

  String get profileTitle;

  /// Settings Page

  String get settingsTitle;

  String get settingsThemeCTA;

  String get settingsThemeDefault;

  String get settingsThemeLight;

  String get settingsThemeDark;

  /// Search Page

  String get searchTitle;

  String get searchSearchBarHint;

  /// Profile Widget

  String get profileWidgetDetails;

  /// Profile Widget List

  String get profileListOptions;

  String get profileListSorting;

  String get profileListItemPerPage;

  String get profileListLoadMore;

  /// Part Widget
  String get partWidgetDetails;

  /// Part Widget List
  String get partListOptions;

  String get partListSorting;

  String get partListItemPerPage;

  String get partListLoadMore;

  /// Group Widget

  String get groupWidgetDetails;

  /// Group Widget List

  String get groupListOptions;

  String get groupListSorting;

  String get groupListItemPerPage;

  String get groupListLoadMore;

  /// Entry Widget

  String get entryWidgetDetails;

  /// Entry Widget List

  String get entryListOptions;

  String get entryListSorting;

  String get entryListItemPerPage;

  String get entryListLoadMore;

  /// Sort Dialog

  String get sortDialogCancel;

  String get sortDialogConfirm;

  /// Menu Widget

  String get menuPPCTA;

  String get menuToSCTA;

  /// Others

  String get middleDot;

  String get username;

  String get email;

  String get password;

  String get passwordRepeat;

  String get token;

  String get cancelCTA;

  String get settingsCTA;

  String get account;

  String get home;

  String get resume;

  String get profile;

  String get search;

  String get history;

  String get loadMore;

  String get errorOccurred;

  String get retryCTA;

  String get yesCTA;

  String get noCTA;

  String get moreCTA;

  String get notYetImplemented;

  String get notSupported;

  /// Exception Error

  String get exceptionFormatException;

  String get exceptionTimeoutException;

  /// Api Error

  String get apiErrorWrongPasswordError;

  String get apiErrorUserNotFoundError;

  /// Server Error : HTTP 400

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

  ///Server Error : HTTP 500

  String get httpServerErrorInternalServerError;

  String get httpServerErrorNotImplemented;

  String get httpServerErrorBadGateway;

  String get httpServerErrorServiceUnavailable;

  String get httpServerErrorGatewayTimeout;

  String get httpServerErrorHttpVersionNotSupported;
}

class CVLocalizationsDelegate extends LocalizationsDelegate<CVLocalizations> {
  const CVLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<CVLocalizations> load(Locale locale) {
    final String name =
        (locale.countryCode == null || locale.countryCode.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if (locale.languageCode == 'fr') {
      return CVLocalizationsFR.load(locale);
    } else {
      return CVLocalizationsEN.load(locale);
    }
  }

  @override
  bool shouldReload(CVLocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultCVLocalizations.delegate(en_US)';
}
