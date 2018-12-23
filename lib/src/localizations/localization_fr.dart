import 'package:cv/src/localizations/localization.dart';

class LocalizationFR implements Localization {
  @override
  String get appName => "Social CV";

  // Login Page
  @override
  String get loginTitle => "Connexion";

  @override
  String get loginNoEmailTitle => "E-mail vide";

  @override
  String get loginNotEmailExplain => "Merci de renseigner un e-mail existant.";

  @override
  String get loginNoEmailExplain => "Merci de renseigner un e-mail";

  @override
  String get loginNoPasswordTitle => "Mot de passe vide";

  @override
  String get loginNoPasswordExplain => "Merci de renseigner un mot de passe";

  @override
  String get loginCreateYourAccount => "Créez votre compte";

  @override
  String get loginSignUpCTA => "S'inscrire";

  @override
  String get loginPrivacyExplain =>
      "Vous aimez votre vie privée ? Nous le savons. Nous n'utilisons, ni vendons vos données.";

  @override
  String get loginPrivacyReadCTA =>
      "Touchez ici pour lire notre politique de confidentialité.";

  @override
  String get loginSignInGoogleCTA => "Se connecter avec Google";

  @override
  String get loginSignInFacebookCTA => "Se connecter avec Facebook";

  @override
  String get loginAlreadyHaveAccountCTA =>
      "Vous avez déjà un compte ? Connectez-vous";

  @override
  String get loginSignIn => "Connectez vous avec votre compte";

  @override
  String get loginSignInCTA => "Se connecter";

  @override
  String get loginForgotPasswordCTA => "Mot de passe oublié ?";

  @override
  String get loginNoAccountCTA => "Vous n'avez pas de compte ? Inscrivez-vous";

  @override
  String get loginOr => "OU";

  // Home Page
  @override
  String get homeTitle => "Social CV";

  @override
  String get homeWelcome => "Bienvenue sur notre nouveau réseau social de CV !";

  // Account Page
  @override
  String get accountMyProfile => "Mes profils";

  // Profile Page
  @override
  String get profileTitle => "Profil";

  // Settings Pages

  @override
  String get settingsTitle => "Paramètres";

  @override
  String get settingsCTA => "Paramètres";

  @override
  String get settingsThemeCTA => "Mode Sombre";

  @override
  String get settingsThemeDefault => "Défaut";

  @override
  String get settingsThemeLight => "Claire";

  @override
  String get settingsThemeDark => "Sombre";

  // Search Page
  @override
  String get searchTitle => "Recherche";

  @override
  String get searchSearchBarHint => "Rechercher un profil ...";

  // Exception Error
  @override
  String get exceptionFormatException => "Exception : Mauvais Format";

  @override
  String get exceptionTimeoutException => "Exception : Requete Expiré";

  // Api Error
  @override
  String get apiErrorWrongPasswordError => "Mauvais mot de passe";

  @override
  String get apiErrorUserNotFoundError => "Utilisateur introuvable";

  // Server Error : HTTP 400
  @override
  String get httpClientErrorBadRequest => "Mauvaise requete";

  @override
  String get httpClientErrorPaymentRequired => "Paiement requis";

  @override
  String get httpClientErrorForbidden => "Interdit";

  @override
  String get httpClientErrorNotFound => "Introuvable";

  @override
  String get httpClientErrorMethodNotAllowed => "Non autorisé";

  @override
  String get httpClientErrorNotAcceptable => "Non acceptable";

  @override
  String get httpClientErrorRequestTimeout => "Requete expirée";

  @override
  String get httpClientErrorConflict => "Conflit";

  @override
  String get httpClientErrorGone => "Disparu";

  @override
  String get httpClientErrorLengthRequired => "Taille requise";

  @override
  String get httpClientErrorPayloadTooLarge => "Payload trop large";

  @override
  String get httpClientErrorURITooLong => "Lien trop long";

  @override
  String get httpClientErrorUnsupportedMediaType =>
      "Type de média non supporté";

  @override
  String get httpClientErrorExpectationFailed => "Échoué";

  @override
  String get httpClientErrorUpgradeRequired => "Mise à jour requise";

  // Server Error : HTTP 500
  @override
  String get httpServerErrorInternalServerError => "Erreur Serveur interne";

  @override
  String get httpServerErrorNotImplemented => "Non implementé";

  @override
  String get httpServerErrorBadGateway => "Mauvaise passerelle";

  @override
  String get httpServerErrorServiceUnavailable => "Service non disponible ";

  @override
  String get httpServerErrorGatewayTimeout => "Temps ecoulé";

  @override
  String get httpServerErrorHttpVersionNotSupported =>
      "Version HTTP non supporté";

  // Menu Widget

  @override
  String get menuPPCTA => "Politique de confidentialité";

  @override
  String get menuToSCTA => "Termes de Service";

  // Others
  @override
  String get middleDot => "·";

  @override
  String get username => "Nom d'utilisateur";

  @override
  String get email => "Email";

  @override
  String get password => "Mot de passe";

  @override
  String get token => "Jeton";

  @override
  String get cancel => "Annuler";

  @override
  String get account => "Compte";

  @override
  String get login => "Se connecter";

  @override
  String get loginCTA => "Se connecter";

  @override
  String get logout => "Se déconnecter";

  @override
  String get logoutCTA => "Se déconnecter";

  @override
  String get home => "Accueil";

  @override
  String get resume => "CV";

  @override
  String get profile => "Profil";

  @override
  String get search => "Rechercher";

  @override
  String get history => "Historique";

  @override
  String get loadMore => "Charger plus";

  @override
  String get errorOccurred => "Une erreur s'est produite";

  @override
  String get retry => "Re-éssayer";

  @override
  String get yes => "Oui";

  @override
  String get no => "Non";

  @override
  String get logged => "Connecté";

  @override
  String get more => "Plus";

  @override
  String get forgotPasswordTitle => "Retrouvez votre mot de passe";

  @override
  String get forgotPasswordExplain =>
      "Renseignez votre e-mail et nous vous enverrons les instructions pour réinitialiser votre mote de passe";

  @override
  String get forgotPasswordResetCTA => "Réinitialiser mon mot de passe";

  @override
  String get forgotPasswordNoEmailTitle => "Email non renseigné";

  @override
  String get forgotPasswordNoEmailExplain =>
      "Mercie de renseigner votre e-mail";

  @override
  String get forgotPasswordSuccessMessage =>
      "Email with instructions has been send.";

  @override
  String get forgotPasswordErrorMessage =>
      "Une érreur c'est produite pendant l'envoie de l'e-mail avec les instructions";
}
