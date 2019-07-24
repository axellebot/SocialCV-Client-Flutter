import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/presentation/localizations/cv_localization.dart';

class CVLocalizationsEN implements CVLocalizations {
  const CVLocalizationsEN();

  /// --------------------------------------------------------------------------
  ///                                Common
  /// --------------------------------------------------------------------------

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
  String get retryCTA => 'Retry';

  @override
  String get yesCTA => 'Yes';

  @override
  String get noCTA => 'No';

  @override
  String get moreCTA => 'More';

  @override
  String get errorOccurred => 'An error occurred';

  /// --------------------------------------------------------------------------
  ///                                   App
  /// --------------------------------------------------------------------------

  @override
  String get appName => 'Social CV';

  /// --------------------------------------------------------------------------
  ///                             Menu Widget
  /// --------------------------------------------------------------------------

  @override
  String get menuPPCTA => 'Privacy Policy';

  @override
  String get menuToSCTA => 'Terms of Service';

  /// --------------------------------------------------------------------------
  ///                               Home Page
  /// --------------------------------------------------------------------------

  @override
  String get homeTitle => 'Social CV';

  @override
  String get homeCTA => 'Home';

  @override
  String get homeWelcome => 'Welcome on our new resume social network !';

  /// --------------------------------------------------------------------------
  ///                 Authentication Page - Login - SignUp
  /// --------------------------------------------------------------------------

  @override
  String get authTitle => 'Connection';

  @override
  String get authBubbleLoginCTA => 'Login';

  @override
  String get authBubbleRegisterCTA => 'Register';

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
  String get authRegisterTitle => 'Register';

  @override
  String get authRegisterCTA => 'Sign-up';

  @override
  String get authRegisterFailed => 'Registration failed!';

  @override
  String get authRegisterSucceed => 'Registration succeed!';

  @override
  String get authLoginTitle => 'Sign-in';

  @override
  String get authLoginCTA => 'Sign-in';

  @override
  String get authLoginGoogleCTA => 'Sign-in with Google';

  @override
  String get authLoginFacebookCTA => 'Sign-in with Facebook';

  @override
  String get authLoginSucceed => 'Login succeed!';

  @override
  String get authLoginFailed => 'Login failed!';

  @override
  String get authLogout => 'Logout';

  @override
  String get authLogoutCTA => 'Logout';

  @override
  String get authAccountAlreadyExistsFailure =>
      'An account with this username or email already exists.';

  @override
  String get authLogoutSucceed => 'Logout succeed!';

  @override
  String get authForgotPasswordCTA => 'Forgot password?';

  @override
  String get authNoAccountCTA => 'Don\'t have an account yet? Sign-up';

  @override
  String get authOr => 'OR';

  /// --------------------------------------------------------------------------
  ///                              Account Page
  /// --------------------------------------------------------------------------

  @override
  String get accountTitle => 'Account';

  @override
  String get accountCTA => 'Account';

  @override
  String get accountMyProfile => 'My profiles';

  /// --------------------------------------------------------------------------
  ///                              Setting Page
  /// --------------------------------------------------------------------------

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsDarkModeCTA => 'Dark Mode';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  /// Search Page

  @override
  String get searchTitle => 'Search';

  @override
  String get searchSearchBarHint => 'Search resume...';

  /// --------------------------------------------------------------------------
  ///                            Profile Widget
  /// --------------------------------------------------------------------------

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileWidgetDetails => 'Profile details';

  @override
  String get profileListOptions => 'Profile options';

  @override
  String get profileListSorting => 'Sorting Profiles';

  @override
  String get profileListItemPerPage => 'Profile per page';

  @override
  String get profileListLoadMore => 'Load more profiles';

  /// --------------------------------------------------------------------------
  ///                            Part Widget
  /// --------------------------------------------------------------------------

  @override
  String get partWidgetDetails => 'Part détails';

  @override
  String get partListOptions => 'Part list options';

  @override
  String get partListSorting => 'Sorting parts';

  @override
  String get partListItemPerPage => 'Parts per page';

  @override
  String get partListLoadMore => 'Load more parts';

  /// --------------------------------------------------------------------------
  ///                            Group Widget
  /// --------------------------------------------------------------------------

  @override
  String get groupWidgetDetails => 'Group détails';

  @override
  String get groupListOptions => 'Group list options';

  @override
  String get groupListSorting => 'Sorting groups';

  @override
  String get groupListItemPerPage => 'Groups per page';

  @override
  String get groupListLoadMore => 'Load more groups';

  /// --------------------------------------------------------------------------
  ///                            Entry Widget
  /// --------------------------------------------------------------------------

  @override
  String get entryWidgetDetails => 'Entry détails';

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

  /// --------------------------------------------------------------------------
  ///                                Forms
  /// --------------------------------------------------------------------------

  @override
  String get formUsernameLabel => 'Username';

  @override
  String get formEmailLabel => 'Email';

  @override
  String get formEmailHint => 'someone@email.com';

  @override
  String get formNotEmailExplain => 'Please enter a real e-mail.';

  @override
  String get formNoEmailExplain => 'Please provide an email';

  @override
  String get formPasswordLabel => 'Password';

  @override
  String get formNoPasswordExplain => 'Please provide a password';

  @override
  String get formPassword2Label => 'Repeat password';

  @override
  String get formPasswordWrongPolicy =>
      'The password do not fit to our password policy.';

  /// --------------------------------------------------------------------------
  ///                            App Exceptions
  /// --------------------------------------------------------------------------

  @override
  String get appErrorUserNotFound => 'User not found';

  @override
  String get appErrorAuthForbidden => 'Access forbidden';

  @override
  String get appErrorAuthNoToken => 'No token emitted';

  @override
  String get appErrorAuthUnauthorized => 'Not authorized';

  @override
  String get appErrorAuthAccountDisabled => 'Account disabled';

  @override
  String get appErrorServerSideProblem => 'A server side error occured';

  /// --------------------------------------------------------------------------
  ///                            App Errors
  /// --------------------------------------------------------------------------

  @override
  String get errorNotYetImplemented => 'Not yet implemented';

  @override
  String get errorNotSupported => 'Not supported';

  /// --------------------------------------------------------------------------
  ///                            Others Exceptions
  /// --------------------------------------------------------------------------

  @override
  String get exceptionFormatException => 'Exception : Wrong Format';

  @override
  String get exceptionTimeoutException => 'Exception : Request Timeout';

  /// --------------------------------------------------------------------------
  ///                       HTTP Client Error (4XX)
  /// --------------------------------------------------------------------------

  @override
  String get http400ClientErrorBadRequest => 'Bad request';

  @override
  String get http401ClientErrorUnauthorized => 'Unauthorized';

  @override
  String get http402ClientErrorPaymentRequired => 'Payment required';

  @override
  String get http403ClientErrorForbidden => 'Forbidden';

  @override
  String get http404ClientErrorNotFound => 'Not found';

  @override
  String get http405ClientErrorMethodNotAllowed => 'Not allowed';

  @override
  String get http406ClientErrorNotAcceptable => 'Not acceptable';

  @override
  String get http408ClientErrorRequestTimeout => 'Request timeout';

  @override
  String get http409ClientErrorConflict => 'Conflict';

  @override
  String get http410ClientErrorGone => 'Gone';

  @override
  String get http411ClientErrorLengthRequired => 'Length required';

  @override
  String get http413ClientErrorPayloadTooLarge => 'Payload too large';

  @override
  String get http414ClientErrorURITooLong => 'URI too long';

  @override
  String get http415ClientErrorUnsupportedMediaType => 'Unsupported media type';

  @override
  String get http417ClientErrorExpectationFailed => 'Expectation Failed';

  @override
  String get http426ClientErrorUpgradeRequired => 'Upgrade required';

  /// --------------------------------------------------------------------------
  ///                       HTTP Server Error (5XX)
  /// --------------------------------------------------------------------------

  @override
  String get http500ServerErrorInternalServerError => 'Internal Server Error';

  @override
  String get http501ServerErrorNotImplemented => 'Not implemented';

  @override
  String get http502ServerErrorBadGateway => 'Bad Gateway';

  @override
  String get http503ServerErrorServiceUnavailable => 'Service Unavailable';

  @override
  String get http504ServerErrorGatewayTimeout => 'Gateway Timeout';

  @override
  String get http505ServerErrorHttpVersionNotSupported =>
      'HTTP Version Not Supported';

  /// --------------------------------------------------------------------------
  ///                                 Misc
  /// --------------------------------------------------------------------------

  /// Creates an object that provides US English resource values for the
  /// application.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  /// The [MaterialApp] does so by default.
  static FutureOr<CVLocalizations> load(Locale locale) {
    return SynchronousFuture<CVLocalizations>(const CVLocalizationsEN());
  }

  /// A [LocalizationsDelegate] that uses [CVLocalizationsEN.load]
  /// to create an instance of this class.
  ///
  /// [MaterialApp] automatically adds this value to [MaterialApp.localizationsDelegates].
  static const LocalizationsDelegate<CVLocalizations> delegate =
      CVLocalizationsDelegate();
}
