import 'package:cv/src/localizations/localization.dart';

class LocalizationEN implements Localization {
  // App
  @override
  String get appName => "Social CV";

  // Login Page
  @override
  String get loginTitle => "Connection";

  @override
  String get loginNoEmailTitle => "Empty email";

  @override
  String get loginNotEmailExplain => "Please enter a real e-mail.";

  @override
  String get loginNoEmailExplain => "Please provide an email";

  @override
  String get loginNoPasswordTitle => "Empty password";

  @override
  String get loginNoPasswordExplain => "Please provide a password";

  @override
  String get loginCreateYourAccount => "Create your account";

  @override
  String get loginSignUpCTA => "Sign-up";

  @override
  String get loginPrivacyExplain =>
      "Like privacy? We feel you. We don’t use or sell your data.";

  @override
  String get loginPrivacyReadCTA => "Touch to read our privacy policy.";

  @override
  String get loginSignInGoogleCTA => "Sign-in with Google";

  @override
  String get loginSignInFacebookCTA => "Sign-in with Facebook";

  @override
  String get loginAlreadyHaveAccountCTA => "Already have an account? Sign-in";

  @override
  String get loginSignIn => "Sign-in with your account";

  @override
  String get loginSignInCTA => "Sign-in";

  @override
  String get loginForgotPasswordCTA => "Forgot password?";

  @override
  String get loginNoAccountCTA => "Don't have an account yet? Sign-up";

  @override
  String get loginOr => "OR";

  // Home Page
  @override
  String get homeTitle => "Social CV";

  @override
  String get homeWelcome => "Welcome on our new resume social network !";

  // Account Page
  @override
  String get accountMyProfile => "My profiles";

  // Profile Page
  @override
  String get profileTitle => "Profile";

  // Settings Page
  @override
  String get settingsTitle => "Settings";

  @override
  String get settingsThemeCTA => "Dark Mode";

  @override
  String get settingsThemeDefault => "Default";

  @override
  String get settingsThemeLight => "Light";

  @override
  String get settingsThemeDark => "Dark";

  // Search Page
  @override
  String get searchTitle => "Search";

  @override
  String get searchSearchBarHint => "Search resume...";

  // Menu Widget
  @override
  String get menuPPCTA => "Privacy Policy";

  @override
  String get menuToSCTA => "Terms of Service";

  // Exception Error
  @override
  String get exceptionFormatException => "Exception : Wrong Format";

  @override
  String get exceptionTimeoutException => "Exception : Request Timeout";

  // Api Error
  @override
  String get apiErrorWrongPasswordError => "Wrong password";

  @override
  String get apiErrorUserNotFoundError => "User not found";

  // Server Error : HTTP 400
  @override
  String get httpClientErrorBadRequest => "Bad request";

  @override
  String get httpClientErrorPaymentRequired => "Payment required";

  @override
  String get httpClientErrorForbidden => "Forbidden";

  @override
  String get httpClientErrorNotFound => "Not found";

  @override
  String get httpClientErrorMethodNotAllowed => "Not allowed";

  @override
  String get httpClientErrorNotAcceptable => "Not acceptable";

  @override
  String get httpClientErrorRequestTimeout => "Request timeout";

  @override
  String get httpClientErrorConflict => "Conflict";

  @override
  String get httpClientErrorGone => "Gone";

  @override
  String get httpClientErrorLengthRequired => "Length required";

  @override
  String get httpClientErrorPayloadTooLarge => "Payload too large";

  @override
  String get httpClientErrorURITooLong => "URI too long";

  @override
  String get httpClientErrorUnsupportedMediaType => "Unsupported media type";

  @override
  String get httpClientErrorExpectationFailed => "Expectation Failed";

  @override
  String get httpClientErrorUpgradeRequired => "Upgrade required";

  // Server Error : HTTP 500
  @override
  String get httpServerErrorInternalServerError => "Internal Server Error";

  @override
  String get httpServerErrorNotImplemented => "Not implemented";

  @override
  String get httpServerErrorBadGateway => "Bad Gateway";

  @override
  String get httpServerErrorServiceUnavailable => "Service Unavailable";

  @override
  String get httpServerErrorGatewayTimeout => "Gateway Timeout";

  @override
  String get httpServerErrorHttpVersionNotSupported =>
      "HTTP Version Not Supported";

  // Others
  @override
  String get middleDot => "·";

  @override
  String get username => "Username";

  @override
  String get email => "Email";

  @override
  String get password => "Password";

  @override
  String get token => "Token";

  @override
  String get cancel => "Cancel";

  @override
  String get settingsCTA => "Settings";

  @override
  String get account => "Account";

  @override
  String get login => "Login";

  @override
  String get loginCTA => "Login";

  @override
  String get logout => "Logout";

  @override
  String get logoutCTA => "Logout";

  @override
  String get home => "Home";

  @override
  String get resume => "Resume";

  @override
  String get profile => "Profile";

  @override
  String get search => "Search";

  @override
  String get history => "History";

  @override
  String get loadMore => "Load more";

  @override
  String get errorOccurred => "An error occurred";

  @override
  String get retry => "Retry";

  @override
  String get yes => "Yes";

  @override
  String get no => "No";

  @override
  String get logged => "Logged";

  @override
  String get more => "More";

  @override
  String get forgotPasswordTitle => "Retrieve password";

  @override
  String get forgotPasswordExplain =>
      "Enter your login email and we'll send you instructions to reset your password";

  @override
  String get forgotPasswordResetCTA => "Reset password";

  @override
  String get forgotPasswordNoEmailTitle => "Empty email";

  @override
  String get forgotPasswordNoEmailExplain => "Please provide an email";

  @override
  String get forgotPasswordSuccessMessage =>
      "Email with instructions has been send.";

  @override
  String get forgotPasswordErrorMessage =>
      "An error occurred while sending the email with instructions";
}
