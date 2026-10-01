// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sip Sync';

  @override
  String get tagline =>
      'Des tables, des goûts, une place qui connaît votre nom.';

  @override
  String get atmosphereTitle => 'Une place qui connaît votre nom';

  @override
  String get atmosphereBody =>
      'Entrez, commandez, récupérez — la maison a déjà votre table.';

  @override
  String get authLead => 'Bon retour';

  @override
  String get registerLead => 'Créez votre place';

  @override
  String get showPassword => 'Afficher le mot de passe';

  @override
  String get hidePassword => 'Masquer le mot de passe';

  @override
  String get signIn => 'Connexion';

  @override
  String get register => 'Créer un compte';

  @override
  String get signOut => 'Déconnexion';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get phone => 'Téléphone';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get noAccount => 'Nouveau ? Inscription';

  @override
  String get hasAccount => 'Déjà inscrit ? Connexion';

  @override
  String welcome(String name) {
    return 'Bienvenue, $name';
  }

  @override
  String get rolesLabel => 'Vos rôles';

  @override
  String get homeHint =>
      'Le même e-mail servira si vous devenez propriétaire ou employé.';

  @override
  String get loading => 'Chargement';

  @override
  String get retry => 'Réessayer';

  @override
  String get empty => 'Rien pour le moment';

  @override
  String get language => 'Langue';

  @override
  String get errorGeneric => 'Une erreur s\'est produite. Réessayez.';

  @override
  String get errorInvalidInput => 'Vérifiez le formulaire et réessayez.';

  @override
  String get errorEmailTaken =>
      'Cet e-mail est déjà utilisé avec un autre mot de passe.';

  @override
  String get errorUsernameTaken => 'Ce nom d\'utilisateur est pris.';

  @override
  String get errorPhoneTaken => 'Ce numéro est déjà utilisé.';

  @override
  String get errorInvalidCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get errorAppAccessDenied =>
      'Ce compte ne peut pas encore utiliser cette application.';

  @override
  String get errorNotAuthorized => 'Permission refusée.';

  @override
  String get errorNotFound => 'Introuvable.';

  @override
  String get errorCannotDeleteDefaultAdmin =>
      'L\'admin par défaut ne peut pas être supprimé.';

  @override
  String get errorPasswordTooWeak =>
      'Au moins 8 caractères, sans espaces aux extrémités.';

  @override
  String get errorProfileIncomplete =>
      'Terminez l\'inscription avec un identifiant et un téléphone.';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingStart => 'Commencer';

  @override
  String get onboardingFindTitle => 'Trouvez un lieu proche';

  @override
  String get onboardingFindBody =>
      'Cafés, restaurants et salons autour de vous, avec la distance de chacun.';

  @override
  String get onboardingPlaceTitle => 'Indiquez où vous êtes';

  @override
  String get onboardingPlaceBody =>
      'Saisissez une adresse ou utilisez votre position. Elle sert seulement à classer les lieux.';

  @override
  String get onboardingWalkTitle => 'Voyez la marche';

  @override
  String get onboardingWalkBody =>
      'La distance en kilomètres et un temps de marche approximatif, ou ouvrez la carte.';

  @override
  String get discoverLead => 'Lieux près de vous';

  @override
  String get placeHint => 'Adresse ou quartier';

  @override
  String get useMyLocation => 'Utiliser ma position';

  @override
  String get currentPosition => 'Position actuelle';

  @override
  String get listMode => 'Liste';

  @override
  String get mapMode => 'Carte';

  @override
  String get nearbyFilter => 'À proximité · 15 km';

  @override
  String get allVenues => 'Tous les lieux';

  @override
  String get nearbyEmpty =>
      'Rien dans un rayon de 15 km. Afficher tous les lieux.';

  @override
  String get showAllVenues => 'Tout afficher';

  @override
  String get setPlacePrompt =>
      'Ajoutez votre adresse ou votre position pour voir la distance et le temps de marche.';

  @override
  String walkAway(int minutes) {
    return '~$minutes min à pied';
  }

  @override
  String distanceKm(String distance) {
    return '$distance km';
  }

  @override
  String hoursRange(String open, String close) {
    return '$open–$close';
  }

  @override
  String get errorPlaceLookup => 'Impossible de trouver cette adresse.';

  @override
  String get errorLocationDenied =>
      'La localisation est refusée. Saisissez une adresse.';

  @override
  String get errorLocationDisabled =>
      'Les services de localisation sont désactivés.';

  @override
  String get errorLocationFailed => 'Impossible de lire votre position.';

  @override
  String get osmAttribution => '© Contributeurs OpenStreetMap';

  @override
  String get noVenues => 'Aucun lieu pour le moment.';

  @override
  String get validationRequired => 'Ce champ est obligatoire.';

  @override
  String get validationEmail => 'Saisissez un e-mail valide.';

  @override
  String get validationPassword =>
      'Au moins 8 caractères, sans espaces en tête ou en fin.';

  @override
  String get validationPhone =>
      'Saisissez un téléphone avec indicatif, ex. +216…';

  @override
  String get validationPhoneCountry =>
      'Indicatif non pris en charge. Choisissez un code supporté.';

  @override
  String get phoneCountryCode => 'Indicatif';

  @override
  String phoneCountryHint(String code) {
    return 'Pays : $code';
  }
}
