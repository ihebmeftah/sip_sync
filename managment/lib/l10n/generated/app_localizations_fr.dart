// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sip Sync Ops';

  @override
  String get tagline =>
      'Salle, cuisine, caisse — un seul accès pour la maison.';

  @override
  String get atmosphereTitle => 'Pilotez la maison depuis un écran';

  @override
  String get atmosphereBody =>
      'Propriétaires et équipe partagent un identifiant. Les droits restent côté serveur.';

  @override
  String get authLead => 'Accès équipe';

  @override
  String get registerLead => 'Créer un compte propriétaire';

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
  String get addEmployee => 'Ajouter un employé';

  @override
  String get employees => 'Équipe';

  @override
  String get staff => 'Utilisateurs backoffice';

  @override
  String get addStaff => 'Ajouter un utilisateur';

  @override
  String get adminFlag => 'admin';

  @override
  String get defaultAdminFlag => 'défaut';

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
  String get opsRailTagline => 'Commande de salle';

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String get navProfile => 'Profil';

  @override
  String get navProducts => 'Produits';

  @override
  String get navArticles => 'Articles';

  @override
  String get navIngredients => 'Ingrédients';

  @override
  String get navPos => 'Caisse';

  @override
  String get navTables => 'Tables';

  @override
  String helloScreen(String screen) {
    return 'Bonjour, $screen';
  }

  @override
  String get placeholderBody =>
      'Cet écran n’est pas encore branché au serveur.';

  @override
  String get saveProfile => 'Enregistrer le profil';

  @override
  String get profileSaved => 'Profil mis à jour.';

  @override
  String get myProfile => 'Votre profil';

  @override
  String get teamProfiles => 'Équipe ajoutée';

  @override
  String get viewProfile => 'Voir';

  @override
  String get employeeProfile => 'Profil employé';

  @override
  String get themeLight => 'Thème clair';

  @override
  String get themeDark => 'Thème sombre';

  @override
  String get dashboardEyebrow => 'La maison ce soir';

  @override
  String get dashboardSubtitle =>
      'Caisse, salle et catalogue à un geste. Les compteurs arriveront avec le serveur.';

  @override
  String get dashboardShift => 'Tableau de service';

  @override
  String get dashboardPosCue => 'Caisse et tickets — bientôt.';

  @override
  String get dashboardTablesCue => 'Plan de salle sans backend pour l’instant.';

  @override
  String get dashboardCatalogCue =>
      'Articles et ingrédients, interface seulement.';

  @override
  String get dashboardProfileCue => 'Vos informations et l’équipe ajoutée.';

  @override
  String get emailLocked =>
      'L’e-mail est lié à la connexion et ne change pas ici.';

  @override
  String get profileHint =>
      'Mettez à jour le nom vu en salle. Les propriétaires ouvrent les profils d’équipe ci-dessous.';
}
