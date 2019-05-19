import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';

class CVLocalizationsEN implements CVLocalizations {
  const CVLocalizationsEN();

  /// App

  @override
  String get appName => 'Social CV';

  /// Auth Page

  @override
  String get authTitle => 'Connection';

  @override
  String get authNoEmailTitle => 'Empty email';

  @override
  String get authNotEmailExplain => 'Please enter a real e-mail.';

  @override
  String get authNoEmailExplain => 'Please provide an email';

  @override
  String get authNoPasswordTitle => 'Empty password';

  @override
  String get authNoPasswordExplain => 'Please provide a password';

  @override
  String get authCreateYourAccount => 'Create your account';

  @override
  String get authPrivacyExplain =>
      'Like privacy? We feel you. We don’t use or sell your data.';

  @override
  String get authPrivacyReadCTA => 'Touch to read our privacy policy.';

  @override
  String get authAlreadyHaveAccountCTA => 'Already have an account? Sign-in';

  @override
  String get authNotPasswordExplain => 'This is not a password';

  @override
  String get authSignUp => 'Register';

  @override
  String get authSignUpCTA => 'Sign-up';

  @override
  String get authSignUpFailed => 'Registration failed!';

  @override
  String get authSignUpSucceed => 'Registration succeed!';

  @override
  String get authSignIn => 'Sign-in';

  @override
  String get authSignInCTA => 'Sign-in';

  @override
  String get authSignInGoogleCTA => 'Sign-in with Google';

  @override
  String get authSignInFacebookCTA => 'Sign-in with Facebook';

  @override
  String get authSignInSucceed => 'Login succeed!';

  @override
  String get authSignInFailed => 'Login failed!';

  @override
  String get authLogout => 'Logout';

  @override
  String get authLogoutCTA => 'Logout';

  @override
  String get authLogoutFailed => 'Logout failed!';

  @override
  String get authLogoutSucceed => 'Logout succeed!';

  @override
  String get authForgotPasswordCTA => 'Forgot password?';

  @override
  String get authNoAccountCTA => 'Don\'t have an account yet? Sign-up';

  @override
  String get authOr => 'OR';

  /// Home Page

  @override
  String get homeTitle => 'Social CV';

  @override
  String get homeCTA => 'Home';

  @override
  String get homeWelcome => 'Welcome on our new resume social network !';

  /// Account Page

  @override
  String get accountTitle => 'Account';

  @override
  String get accountCTA => 'Account';

  @override
  String get accountMyProfile => 'My profiles';

  /// Profile Page

  @override
  String get profileTitle => 'Profile';

  /// Settings Page

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsThemeCTA => 'Dark Mode';

  @override
  String get settingsThemeDefault => 'Default';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  /// Search Page

  @override
  String get searchTitle => 'Search';

  @override
  String get searchSearchBarHint => 'Search resume...';

  /// Profile Widget

  String get profileWidgetDetails => 'Profile details';

  /// Profile Widget List

  String get profileListOptions => 'Profile options';

  String get profileListSorting => 'Sorting Profiles';

  String get profileListItemPerPage => 'Profile per page';

  String get profileListLoadMore => 'Load more profiles';

  /// Part Widget

  String get partWidgetDetails => 'Part détails';

  /// Part Widget List

  @override
  String get partListOptions => 'Part list options';

  @override
  String get partListSorting => 'Sorting parts';

  @override
  String get partListItemPerPage => 'Parts per page';

  @override
  String get partListLoadMore => 'Load more parts';

  /// Group Widget

  String get groupWidgetDetails => 'Group détails';

  /// Group Widget List

  @override
  String get groupListOptions => 'Group list options';

  @override
  String get groupListSorting => 'Sorting groups';

  @override
  String get groupListItemPerPage => 'Groups per page';

  @override
  String get groupListLoadMore => 'Load more groups';

  /// Entry Widget

  String get entryWidgetDetails => 'Entry détails';

  /// Entry Widget List

  @override
  String get entryListOptions => 'Entry list options';

  @override
  String get entryListSorting => 'Sorting entries';

  @override
  String get entryListItemPerPage => 'Entries per page';

  @override
  String get entryListLoadMore => 'Load more entries';

  /// Sort Dialog
  @override
  String get sortDialogCancel => 'Cancel';

  @override
  String get sortDialogConfirm => 'Confirm';

  /// Menu Widget

  @override
  String get menuPPCTA => 'Privacy Policy';

  @override
  String get menuToSCTA => 'Terms of Service';

  /// Others

  @override
  String get middleDot => '·';

  @override
  String get username => 'Username';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordRepeat => 'Repeat Password';

  @override
  String get token => 'Token';

  @override
  String get cancelCTA => 'Cancel';

  @override
  String get settingsCTA => 'Settings';

  @override
  String get account => 'Account';

  @override
  String get home => 'Home';

  @override
  String get resume => 'Resume';

  @override
  String get profile => 'Profile';

  @override
  String get search => 'Search';

  @override
  String get history => 'History';

  @override
  String get loadMore => 'Load more';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get retryCTA => 'Retry';

  @override
  String get yesCTA => 'Yes';

  @override
  String get noCTA => 'No';

  @override
  String get moreCTA => 'More';

  @override
  String get notYetImplemented => 'Not yet implemented';

  @override
  String get notSupported => 'Not supported';

  /// Exception Error
  @override
  String get exceptionFormatException => 'Exception : Wrong Format';

  @override
  String get exceptionTimeoutException => 'Exception : Request Timeout';

  /// Api Error

  @override
  String get apiErrorWrongPasswordError => 'Wrong password';

  @override
  String get apiErrorUserNotFoundError => 'User not found';

  /// Server Error : HTTP 400

  @override
  String get httpClientErrorBadRequest => 'Bad request';

  @override
  String get httpClientErrorPaymentRequired => 'Payment required';

  @override
  String get httpClientErrorForbidden => 'Forbidden';

  @override
  String get httpClientErrorNotFound => 'Not found';

  @override
  String get httpClientErrorMethodNotAllowed => 'Not allowed';

  @override
  String get httpClientErrorNotAcceptable => 'Not acceptable';

  @override
  String get httpClientErrorRequestTimeout => 'Request timeout';

  @override
  String get httpClientErrorConflict => 'Conflict';

  @override
  String get httpClientErrorGone => 'Gone';

  @override
  String get httpClientErrorLengthRequired => 'Length required';

  @override
  String get httpClientErrorPayloadTooLarge => 'Payload too large';

  @override
  String get httpClientErrorURITooLong => 'URI too long';

  @override
  String get httpClientErrorUnsupportedMediaType => 'Unsupported media type';

  @override
  String get httpClientErrorExpectationFailed => 'Expectation Failed';

  @override
  String get httpClientErrorUpgradeRequired => 'Upgrade required';

  /// Server Error : HTTP 500

  @override
  String get httpServerErrorInternalServerError => 'Internal Server Error';

  @override
  String get httpServerErrorNotImplemented => 'Not implemented';

  @override
  String get httpServerErrorBadGateway => 'Bad Gateway';

  @override
  String get httpServerErrorServiceUnavailable => 'Service Unavailable';

  @override
  String get httpServerErrorGatewayTimeout => 'Gateway Timeout';

  @override
  String get httpServerErrorHttpVersionNotSupported =>
      'HTTP Version Not Supported';

  /// Creates an object that provides US English resource values for the
  /// application.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  /// The [MaterialApp] does so by default.
  static Future<CVLocalizations> load(Locale locale) {
    return SynchronousFuture<CVLocalizations>(const CVLocalizationsEN());
  }

  /// A [LocalizationsDelegate] that uses [CVLocalizationsEN.load]
  /// to create an instance of this class.
  ///
  /// [MaterialApp] automatically adds this value to [MaterialApp.localizationsDelegates].
  static const LocalizationsDelegate<CVLocalizations> delegate =
      CVLocalizationsDelegate();
}
