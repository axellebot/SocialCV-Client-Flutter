import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_cv_client_flutter/src/presentation/localizations/cv_localization_en.dart';
import 'package:social_cv_client_flutter/src/presentation/localizations/cv_localization_fr.dart';

abstract class CVLocalizations {
  static CVLocalizations of(BuildContext context) {
    return Localizations.of<CVLocalizations>(context, CVLocalizations);
  }

  /// --------------------------------------------------------------------------
  ///                                Common
  /// --------------------------------------------------------------------------

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

  String get retryCTA;

  String get yesCTA;

  String get noCTA;

  String get moreCTA;

  String get errorOccurred;

  /// --------------------------------------------------------------------------
  ///                                   App
  /// --------------------------------------------------------------------------

  String get appName;

  /// --------------------------------------------------------------------------
  ///                             Menu Widget
  /// --------------------------------------------------------------------------

  String get menuPPCTA;

  String get menuToSCTA;

  /// --------------------------------------------------------------------------
  ///                               Home Page
  /// --------------------------------------------------------------------------

  String get homeTitle;

  String get homeCTA;

  String get homeWelcome;

  /// --------------------------------------------------------------------------
  ///                 Authentication Page - Login - SignUp
  /// --------------------------------------------------------------------------

  String get authTitle;

  String get authBubbleLoginCTA;

  String get authBubbleRegisterCTA;

  String get authNoEmailTitle;

  String get authNotEmailExplain;

  String get authNoEmailExplain;

  String get authNoPasswordTitle;

  String get authNotPasswordExplain;

  String get authNoPasswordExplain;

  String get authCreateYourAccount;

  String get authRegisterTitle;

  String get authRegisterCTA;

  String get authRegisterSucceed;

  String get authRegisterFailed;

  String get authLoginTitle;

  String get authLoginCTA;

  String get authLoginGoogleCTA;

  String get authLoginFacebookCTA;

  String get authLoginSucceed;

  String get authLoginFailed;

  String get authLogout;

  String get authLogoutCTA;

  String get authLogoutSucceed;

  String get authAccountAlreadyExistsFailure;

  String get authForgotPasswordCTA;

  String get authAlreadyHaveAccountCTA;

  String get authNoAccountCTA;

  String get authPrivacyExplain;

  String get authPrivacyReadCTA;

  String get authOr;

  /// --------------------------------------------------------------------------
  ///                              Account Page
  /// --------------------------------------------------------------------------

  String get accountTitle;

  String get accountCTA;

  String get accountMyProfile;

  /// --------------------------------------------------------------------------
  ///                              Setting Page
  /// --------------------------------------------------------------------------

  String get settingsTitle;

  String get settingsDarkModeCTA;

  String get settingsThemeLight;

  String get settingsThemeDark;

  /// Search Page

  String get searchTitle;

  String get searchSearchBarHint;

  /// --------------------------------------------------------------------------
  ///                            Profile Widget
  /// --------------------------------------------------------------------------

  String get profileTitle;

  String get profileWidgetDetails;

  String get profileListOptions;

  String get profileListSorting;

  String get profileListItemPerPage;

  String get profileListLoadMore;

  /// --------------------------------------------------------------------------
  ///                            Part Widget
  /// --------------------------------------------------------------------------

  String get partWidgetDetails;

  String get partListOptions;

  String get partListSorting;

  String get partListItemPerPage;

  String get partListLoadMore;

  /// --------------------------------------------------------------------------
  ///                            Group Widget
  /// --------------------------------------------------------------------------

  String get groupWidgetDetails;

  String get groupListOptions;

  String get groupListSorting;

  String get groupListItemPerPage;

  String get groupListLoadMore;

  /// --------------------------------------------------------------------------
  ///                            Entry Widget
  /// --------------------------------------------------------------------------

  String get entryWidgetDetails;

  String get entryListOptions;

  String get entryListSorting;

  String get entryListItemPerPage;

  String get entryListLoadMore;

  /// Sort Dialog

  String get sortDialogCancel;

  String get sortDialogConfirm;

  /// --------------------------------------------------------------------------
  ///                                Forms
  /// --------------------------------------------------------------------------

  String get formUsernameLabel;

  String get formEmailLabel;

  String get formEmailHint;

  String get formNoEmailExplain;

  String get formNotEmailExplain;

  String get formPasswordLabel;

  String get formNoPasswordExplain;

  String get formPassword2Label;

  String get formPasswordWrongPolicy;

  /// --------------------------------------------------------------------------
  ///                             Exceptions
  /// --------------------------------------------------------------------------

  String get exceptionFormatException;

  String get exceptionTimeoutException;

  /// --------------------------------------------------------------------------
  ///                            App Exceptions
  /// --------------------------------------------------------------------------

  String get appErrorAuthUnauthorized;

  String get appErrorAuthAccountDisabled;

  String get appErrorAuthForbidden;

  String get appErrorAuthNoToken;

  String get appErrorUserNotFound;

  String get appErrorServerSideProblem;

  /// --------------------------------------------------------------------------
  ///                             Errors
  /// --------------------------------------------------------------------------

  String get errorNotYetImplemented;

  String get errorNotSupported;

  /// --------------------------------------------------------------------------
  ///                       HTTP Client Error (4XX)
  /// --------------------------------------------------------------------------

  String get http400ClientErrorBadRequest;

  String get http401ClientErrorUnauthorized;

  String get http402ClientErrorPaymentRequired;

  String get http403ClientErrorForbidden;

  String get http404ClientErrorNotFound;

  String get http405ClientErrorMethodNotAllowed;

  String get http406ClientErrorNotAcceptable;

  String get http408ClientErrorRequestTimeout;

  String get http409ClientErrorConflict;

  String get http410ClientErrorGone;

  String get http411ClientErrorLengthRequired;

  String get http413ClientErrorPayloadTooLarge;

  String get http414ClientErrorURITooLong;

  String get http415ClientErrorUnsupportedMediaType;

  String get http417ClientErrorExpectationFailed;

  String get http426ClientErrorUpgradeRequired;

  /// --------------------------------------------------------------------------
  ///                       HTTP Server Error (5XX)
  /// --------------------------------------------------------------------------

  String get http500ServerErrorInternalServerError;

  String get http501ServerErrorNotImplemented;

  String get http502ServerErrorBadGateway;

  String get http503ServerErrorServiceUnavailable;

  String get http504ServerErrorGatewayTimeout;

  String get http505ServerErrorHttpVersionNotSupported;
}

class CVLocalizationsDelegate extends LocalizationsDelegate<CVLocalizations> {
  const CVLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<CVLocalizations> load(Locale locale) async {
    final String name =
        (locale.countryCode == null || locale.countryCode.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    if (locale.languageCode == 'fr') {
      return await CVLocalizationsFR.load(locale);
    } else {
      return await CVLocalizationsEN.load(locale);
    }
  }

  @override
  bool shouldReload(CVLocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultCVLocalizations.delegate(en_US)';
}
