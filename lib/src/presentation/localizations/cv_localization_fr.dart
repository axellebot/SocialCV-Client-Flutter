import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/presentation/localizations/cv_localization.dart';

class CVLocalizationsFR implements CVLocalizations {
  const CVLocalizationsFR();

  /// --------------------------------------------------------------------------
  ///                                Common
  /// --------------------------------------------------------------------------

  @override
  String get token => 'Jeton';

  @override
  String get cancelCTA => 'Annuler';

  @override
  String get account => 'Compte';

  @override
  String get home => 'Accueil';

  @override
  String get resume => 'CV';

  @override
  String get profile => 'Profil';

  @override
  String get search => 'Rechercher';

  @override
  String get history => 'Historique';

  @override
  String get loadMore => 'Charger plus';

  @override
  String get retryCTA => 'Re-éssayer';

  @override
  String get yesCTA => 'Oui';

  @override
  String get noCTA => 'Non';

  @override
  String get authLoginSucceed => 'Connecté';

  @override
  String get moreCTA => 'Plus';

  @override
  String get errorOccurred => 'Une erreur s\'est produite.';

  /// --------------------------------------------------------------------------
  ///                                   App
  /// --------------------------------------------------------------------------

  @override
  String get appName => 'Social CV';

  /// --------------------------------------------------------------------------
  ///                             Menu Widget
  /// --------------------------------------------------------------------------

  @override
  String get menuPPCTA => 'Politique de confidentialité';

  @override
  String get menuToSCTA => 'Termes de Service';

  /// --------------------------------------------------------------------------
  ///                               Home Page
  /// --------------------------------------------------------------------------

  @override
  String get homeTitle => 'Social CV';

  @override
  String get homeCTA => 'Accueil';

  @override
  String get homeWelcome => 'Bienvenue sur notre nouveau réseau social de CV !';

  /// --------------------------------------------------------------------------
  ///                 Authentication Page - Login - SignUp
  /// --------------------------------------------------------------------------

  @override
  String get authTitle => 'Connexion';

  @override
  String get authBubbleLoginCTA => 'Login';

  @override
  String get authBubbleRegisterCTA => 'Register';

  @override
  String get authNoEmailTitle => 'E-mail vide';

  @override
  String get authNotEmailExplain => 'Merci de renseigner un e-mail existant.';

  @override
  String get authNoEmailExplain => 'Merci de renseigner un e-mail';

  @override
  String get authNoPasswordTitle => 'Mot de passe vide';

  @override
  String get authNoPasswordExplain => 'Merci de renseigner un mot de passe';

  @override
  String get authCreateYourAccount => 'Créez votre compte';

  @override
  String get authRegisterTitle => 'Inscription';

  @override
  String get authRegisterCTA => 'S\'inscrire';

  @override
  String get authRegisterFailed => 'Inscription échoué !';

  @override
  String get authRegisterSucceed => 'Inscription réussite !';

  @override
  String get authLoginTitle => 'Connectez vous avec votre compte';

  @override
  String get authLoginCTA => 'Se connecter';

  @override
  String get authLoginGoogleCTA => 'Se connecter avec Google';

  @override
  String get authLoginFacebookCTA => 'Se connecter avec Facebook';

  @override
  String get authLoginFailed => 'Connexion échoué !';

  @override
  String get authLogout => 'Se déconnecter';

  @override
  String get authLogoutCTA => 'Se déconnecter';

  @override
  String get authAccountAlreadyExistsFailure =>
      'Un compte avec le même nom d\'utilisateur ou e-mail existe déjà.';

  @override
  String get authLogoutSucceed => 'Déconnexion réussite !';

  @override
  String get authPrivacyExplain =>
      'Vous aimez votre vie privée ? Nous le savons. Nous n\'utilisons, ni '
      'vendons vos données.';

  @override
  String get authPrivacyReadCTA =>
      'Touchez ici pour lire notre politique de confidentialité.';

  @override
  String get authAlreadyHaveAccountCTA =>
      'Vous avez déjà un compte ? Connectez-vous';

  @override
  String get authForgotPasswordCTA => 'Mot de passe oublié ?';

  @override
  String get authNoAccountCTA => 'Vous n\'avez pas de compte ? Inscrivez-vous';

  @override
  String get authNotPasswordExplain => 'Ceci n\'est pas un mot de passe';

  @override
  String get authOr => 'OU';

  /// --------------------------------------------------------------------------
  ///                              Account Page
  /// --------------------------------------------------------------------------

  @override
  String get accountTitle => 'Compte';

  @override
  String get accountCTA => 'Compte';

  @override
  String get accountMyProfile => 'Mes profils';

  /// Settings Pages

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsCTA => 'Paramètres';

  @override
  String get settingsDarkModeCTA => 'Mode Sombre';

  @override
  String get settingsThemeLight => 'Claire';

  @override
  String get settingsThemeDark => 'Sombre';

  /// Search Page

  @override
  String get searchTitle => 'Recherche';

  @override
  String get searchSearchBarHint => 'Rechercher un profil ...';

  /// --------------------------------------------------------------------------
  ///                            Profile Widget
  /// --------------------------------------------------------------------------

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileWidgetDetails => 'Détails du profile';

  @override
  String get profileListOptions => 'Options profiles';

  @override
  String get profileListSorting => 'Trier Profiles';

  @override
  String get profileListItemPerPage => 'Profils par page';

  @override
  String get profileListLoadMore => 'Charger plus de profiles';

  /// --------------------------------------------------------------------------
  ///                            Part Widget
  /// --------------------------------------------------------------------------

  @override
  String get partWidgetDetails => 'Détails de la partie';

  @override
  String get partListOptions => 'Options';

  @override
  String get partListSorting => 'Trier les parties';

  @override
  String get partListItemPerPage => 'Parties par page';

  @override
  String get partListLoadMore => 'charger plus de parties';

  /// --------------------------------------------------------------------------
  ///                            Group Widget
  /// --------------------------------------------------------------------------

  @override
  String get groupWidgetDetails => 'Détails du groupe';

  @override
  String get groupListOptions => 'Options';

  @override
  String get groupListSorting => 'Trier les groupes';

  @override
  String get groupListItemPerPage => 'Groupes par page';

  @override
  String get groupListLoadMore => 'charger plus de groupes';

  /// --------------------------------------------------------------------------
  ///                            Entry Widget
  /// --------------------------------------------------------------------------

  @override
  String get entryWidgetDetails => 'Détails de l\'entrée';

  @override
  String get entryListOptions => 'Options';

  @override
  String get entryListSorting => 'Trier les entrées';

  @override
  String get entryListItemPerPage => 'Entrées par page';

  @override
  String get entryListLoadMore => 'Charger plus de entrées';

  /// Sort Dialog

  @override
  String get sortDialogCancel => 'Annuler';

  @override
  String get sortDialogConfirm => 'Valider';

  /// --------------------------------------------------------------------------
  ///                                Forms
  /// --------------------------------------------------------------------------

  @override
  String get formUsernameLabel => 'Nom d\'utilisateur';

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
  String get errorNotYetImplemented => 'Pas encore implémenté';

  @override
  String get errorNotSupported => 'Non supporté';

  /// --------------------------------------------------------------------------
  ///                            Others Exceptions
  /// --------------------------------------------------------------------------

  @override
  String get exceptionFormatException => 'Exception : Mauvais Format';

  @override
  String get exceptionTimeoutException => 'Exception : Requete Expiré';

  /// --------------------------------------------------------------------------
  ///                       HTTP Client Error (4XX)
  /// --------------------------------------------------------------------------

  @override
  String get http400ClientErrorBadRequest => 'Mauvaise requete';

  @override
  String get http401ClientErrorUnauthorized => 'Non authorisé';

  @override
  String get http402ClientErrorPaymentRequired => 'Paiement requis';

  @override
  String get http403ClientErrorForbidden => 'Interdit';

  @override
  String get http404ClientErrorNotFound => 'Introuvable';

  @override
  String get http405ClientErrorMethodNotAllowed => 'Non autorisé';

  @override
  String get http406ClientErrorNotAcceptable => 'Non acceptable';

  @override
  String get http408ClientErrorRequestTimeout => 'Requete expirée';

  @override
  String get http409ClientErrorConflict => 'Conflit';

  @override
  String get http410ClientErrorGone => 'Disparu';

  @override
  String get http411ClientErrorLengthRequired => 'Taille requise';

  @override
  String get http413ClientErrorPayloadTooLarge => 'Payload trop large';

  @override
  String get http414ClientErrorURITooLong => 'Lien trop long';

  @override
  String get http415ClientErrorUnsupportedMediaType =>
      'Type de média non supporté';

  @override
  String get http417ClientErrorExpectationFailed => 'Échoué';

  @override
  String get http426ClientErrorUpgradeRequired => 'Mise à jour requise';

  /// --------------------------------------------------------------------------
  ///                       HTTP Server Error (5XX)
  /// --------------------------------------------------------------------------

  @override
  String get http500ServerErrorInternalServerError => 'Erreur Serveur interne';

  @override
  String get http501ServerErrorNotImplemented => 'Non implementé';

  @override
  String get http502ServerErrorBadGateway => 'Mauvaise passerelle';

  @override
  String get http503ServerErrorServiceUnavailable => 'Service non disponible ';

  @override
  String get http504ServerErrorGatewayTimeout => 'Temps ecoulé';

  @override
  String get http505ServerErrorHttpVersionNotSupported =>
      'Version HTTP non supporté';

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
    return SynchronousFuture<CVLocalizations>(const CVLocalizationsFR());
  }

  /// A [LocalizationsDelegate] that uses [CVLocalizationsFR.load]
  /// to create an instance of this class.
  ///
  /// [MaterialApp] automatically adds this value to [MaterialApp.localizationsDelegates].
  static const LocalizationsDelegate<CVLocalizations> delegate =
      CVLocalizationsDelegate();
}
