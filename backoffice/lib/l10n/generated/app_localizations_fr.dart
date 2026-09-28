// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sip Sync Console';

  @override
  String get tagline => 'Opérateurs, établissements et admin plateforme.';

  @override
  String get atmosphereTitle => 'Gardez la plateforme saine';

  @override
  String get atmosphereBody =>
      'Super-admins et opérateurs. Les privilèges restent hors du client.';

  @override
  String get authLead => 'Accès console';

  @override
  String get registerLead => 'Demander un accès console';

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
  String get errorAccountDisabled => 'Ce compte est désactivé.';

  @override
  String get errorCannotDisableDefaultAdmin =>
      'L\'admin par défaut ne peut pas être désactivé.';

  @override
  String get errorCannotDisableSelf =>
      'Vous ne pouvez pas désactiver votre propre compte.';

  @override
  String get navUsers => 'Utilisateurs';

  @override
  String get navBuildings => 'Établissements';

  @override
  String get usersTitle => 'Utilisateurs';

  @override
  String get usersSubtitle =>
      'Comptes backoffice autorisés à ouvrir cette console.';

  @override
  String get buildingsTitle => 'Établissements';

  @override
  String get buildingsSubtitle =>
      'Tous les lieux de la plateforme, avec le propriétaire et le contact.';

  @override
  String get createUser => 'Créer un utilisateur';

  @override
  String get editUser => 'Mettre à jour';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get close => 'Fermer';

  @override
  String get enabled => 'Activé';

  @override
  String get disabled => 'Désactivé';

  @override
  String get status => 'Statut';

  @override
  String get owner => 'Propriétaire';

  @override
  String get contact => 'Contact';

  @override
  String get buildingType => 'Type';

  @override
  String get address => 'Adresse';

  @override
  String get location => 'Emplacement';

  @override
  String get currency => 'Devise';

  @override
  String get country => 'Pays';

  @override
  String coordinates(String lat, String lng) {
    return '$lat, $lng';
  }

  @override
  String get passwordOptional => 'Nouveau mot de passe (facultatif)';

  @override
  String get deleteUser => 'Supprimer l\'utilisateur';

  @override
  String deleteUserConfirm(String name) {
    return 'Supprimer $name ? L\'accès à la console sera retiré.';
  }

  @override
  String get viewDetails => 'Détails';

  @override
  String get enabledLockedDefault => 'L\'admin par défaut reste activé.';

  @override
  String get enabledLockedSelf =>
      'Vous ne pouvez pas désactiver le compte en cours.';
}
