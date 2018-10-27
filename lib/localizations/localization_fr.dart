import 'package:cv/localizations/localization.dart';

class LocalizationFR implements Localization {
  @override
  String get appName => "Social CV";

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
  String get loginSignUp => "S'inscrire";
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

  @override
  String get homeTitle => "Social CV";
  @override
  String get homeWelcome => "Bienvenue sur notre nouveau réseau social de CV !";

  @override
  String get email => "Email";
  @override
  String get password => "Mot de passe";
  @override
  String get cancel => "Annuler";
  @override
  String get settings => "Paramètre";
  @override
  String get account => "Compte";
  @override
  String get login => "Se connecter";
  @override
  String get logout => "Déconnection";
  @override
  String get home => "Accueil";
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
}
