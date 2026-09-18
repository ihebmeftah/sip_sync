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
  String get loginAsOwner => 'Propriétaire';

  @override
  String get loginAsEmployee => 'Employé';

  @override
  String get register => 'Créer un compte';

  @override
  String get signOut => 'Déconnexion';

  @override
  String get email => 'E-mail';

  @override
  String get loginIdentifier => 'E-mail ou nom d’utilisateur';

  @override
  String get loginIdentifierHint =>
      'Les propriétaires utilisent l’e-mail. Le personnel utilise le nom d’utilisateur.';

  @override
  String get password => 'Mot de passe';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get usernameLocked =>
      'Le nom d’utilisateur est attribué automatiquement et ne peut pas être modifié.';

  @override
  String get employeeUsernameHint =>
      'Un nom d’utilisateur est généré à partir du nom après l’enregistrement.';

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
  String get errorAccountDisabled => 'Ce compte employé est désactivé.';

  @override
  String get navEmployees => 'Employés';

  @override
  String get editEmployee => 'Modifier l’employé';

  @override
  String get saveEmployee => 'Enregistrer l’employé';

  @override
  String get employeesOwnerOnly => 'Seuls les propriétaires gèrent l’équipe.';

  @override
  String get accountEnabled => 'Compte activé';

  @override
  String get accountDisabled => 'Compte désactivé';

  @override
  String get accountEnabledHint =>
      'Cette personne peut se connecter aux opérations.';

  @override
  String get accountDisabledHint =>
      'Cette personne ne peut pas se connecter aux opérations.';

  @override
  String get dashboardEmployeesCue =>
      'Ajouter, modifier et activer ou désactiver l’accès.';

  @override
  String get opsRailTagline => 'Commande de salle';

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String get navProfile => 'Profil';

  @override
  String get navProducts => 'Produits';

  @override
  String get navCategories => 'Catégories';

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
  String get dashboardTablesCue =>
      'Plan de salle avec aperçus et filtres de statut.';

  @override
  String get dashboardCatalogCue => 'Catégories et articles de ce lieu.';

  @override
  String get dashboardProfileCue => 'Votre nom et téléphone.';

  @override
  String get emailLocked =>
      'L’e-mail est lié à la connexion et ne change pas ici.';

  @override
  String get profileHint =>
      'Mettez à jour le nom vu en salle. L’identité de connexion reste verrouillée.';

  @override
  String get navBuildings => 'Établissements';

  @override
  String get addBuilding => 'Ajouter un établissement';

  @override
  String get editBuilding => 'Modifier l’établissement';

  @override
  String get saveBuilding => 'Enregistrer l’établissement';

  @override
  String get buildingName => 'Nom du lieu';

  @override
  String get buildingType => 'Type de lieu';

  @override
  String get buildingTypeRestaurant => 'Restaurant';

  @override
  String get buildingTypeLounge => 'Lounge';

  @override
  String get buildingTypeBar => 'Bar';

  @override
  String get buildingTypeCafe => 'Café';

  @override
  String get buildingTypeOther => 'Autre';

  @override
  String get buildingTypeCustom => 'Type personnalisé';

  @override
  String get buildingAddress => 'Adresse';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get openingTime => 'Ouverture';

  @override
  String get closingTime => 'Fermeture';

  @override
  String get currencyCode => 'Devise';

  @override
  String get buildingStaff => 'Équipe de ce lieu';

  @override
  String get buildingStaffEmpty =>
      'Pas encore d’employés. Ajoutez-les après avoir enregistré le lieu.';

  @override
  String get buildingsOwnerHint =>
      'Créez un lieu, puis ouvrez-le pour gérer la salle. Le reste reste verrouillé jusqu’au choix.';

  @override
  String get buildingsStaffHint =>
      'Choisissez un lieu auquel vous êtes affecté.';

  @override
  String get buildingsEmptyOwner =>
      'Ajoutez votre premier café, restaurant, lounge ou bar pour continuer.';

  @override
  String get employeesEmptyBuilding =>
      'Aucun employé affecté à ce lieu pour l’instant.';

  @override
  String dashboardBuildingMeta(
    String type,
    String address,
    String opens,
    String closes,
    String currency,
  ) {
    return '$type · $address · $opens–$closes · $currency';
  }

  @override
  String get validationRequired => 'Ce champ est obligatoire.';

  @override
  String get validationLoginIdentifier =>
      'Saisissez un e-mail ou un nom d’utilisateur (au moins 3 caractères).';

  @override
  String get validationEmail => 'Saisissez un e-mail valide.';

  @override
  String get validationPassword =>
      'Au moins 8 caractères, sans espaces en tête ou en fin.';

  @override
  String get validationPhone => 'Saisissez un numéro de téléphone valide.';

  @override
  String get validationVenueName => 'Le nom doit faire 1 à 80 caractères.';

  @override
  String get validationVenueType =>
      '2 à 40 lettres, chiffres, espaces ou tirets.';

  @override
  String get validationAddress => 'L’adresse doit faire 3 à 200 caractères.';

  @override
  String get validationLatitude => 'La latitude doit être entre -90 et 90.';

  @override
  String get validationLongitude => 'La longitude doit être entre -180 et 180.';

  @override
  String get validationCurrency => 'Utilisez un code devise à 3 lettres.';

  @override
  String get pickCurrentPosition => 'Utiliser la position actuelle';

  @override
  String get errorLocationDenied =>
      'L’autorisation de localisation est requise pour remplir l’adresse.';

  @override
  String get errorLocationDisabled => 'Activez la localisation puis réessayez.';

  @override
  String get errorLocationFailed => 'Impossible de lire la position actuelle.';

  @override
  String get cancel => 'Annuler';

  @override
  String get addTable => 'Ajouter une table';

  @override
  String get editTable => 'Modifier la table';

  @override
  String get saveTable => 'Enregistrer';

  @override
  String get tablesHint =>
      'Plan de salle selon les places. Le statut viendra des commandes et réservations.';

  @override
  String get tablesEmptyOwner =>
      'Ajoutez votre première table pour dessiner le plan.';

  @override
  String get tablesEmpty => 'Aucune table sur ce plan pour l’instant.';

  @override
  String get tablesFilterEmpty => 'Aucune table pour ce filtre.';

  @override
  String get tableFormHint =>
      'Choisissez combien de tables ajouter. Les numéros sont attribués automatiquement dans l’ordre.';

  @override
  String get tableEditHint =>
      'Vous pouvez changer les places et l’activation. Le numéro reste fixe.';

  @override
  String get tableNumber => 'Numéro de table';

  @override
  String get tableNumberLocked =>
      'Le numéro de table ne peut pas être modifié.';

  @override
  String get tableCountToAdd => 'Combien de tables';

  @override
  String tableNumberRange(int from, int to) {
    return 'Créera les numéros $from–$to';
  }

  @override
  String get tableMaxSeats => 'Places max';

  @override
  String get tableActive => 'Active au plan';

  @override
  String get tableActiveHint =>
      'Les tables inactives restent listées mais hors Disponibles.';

  @override
  String tableSeatsCount(int count) {
    return '$count places';
  }

  @override
  String get tableFilterAll => 'Toutes';

  @override
  String get tableFilterInactive => 'Inactive';

  @override
  String get tableStatusAvailable => 'Disponible';

  @override
  String get tableStatusOccupied => 'Occupée';

  @override
  String get tableStatusReserved => 'Réservée';

  @override
  String get validationTableNumber => 'Entrez un numéro entre 1 et 9999.';

  @override
  String get validationTableCount => 'Entrez un nombre entre 1 et 100.';

  @override
  String get validationTableSeats => 'Entrez entre 1 et 50 places.';

  @override
  String get errorTableNumberTaken =>
      'Ce numéro de table est déjà utilisé ici.';

  @override
  String get optionalFieldHint => 'Facultatif';

  @override
  String get noDescription => 'Sans description';

  @override
  String get categoriesHint =>
      'Regroupez le menu de ce lieu. Les noms doivent être uniques ici.';

  @override
  String get categoriesEmptyOwner =>
      'Ajoutez votre première catégorie, puis les articles.';

  @override
  String get categoriesEmpty => 'Aucune catégorie dans ce lieu pour l’instant.';

  @override
  String get addCategory => 'Ajouter une catégorie';

  @override
  String get editCategory => 'Modifier la catégorie';

  @override
  String get saveCategory => 'Enregistrer';

  @override
  String get categoryFormHint =>
      'Le nom est unique dans ce lieu. La description est facultative.';

  @override
  String get categoryName => 'Nom de la catégorie';

  @override
  String get categoryDescription => 'Description';

  @override
  String get validationCategoryName => 'Entrez un nom de 1 à 80 caractères.';

  @override
  String get validationDescription =>
      'La description doit faire au plus 500 caractères.';

  @override
  String get errorCategoryNameTaken =>
      'Ce nom de catégorie est déjà utilisé ici.';

  @override
  String get articlesHint =>
      'Articles vendables avec prix et catégorie. Noms uniques ici.';

  @override
  String get articlesEmptyOwner =>
      'Ajoutez un article une fois qu’une catégorie existe.';

  @override
  String get articlesEmpty => 'Aucun article dans ce lieu pour l’instant.';

  @override
  String get articlesNeedCategory =>
      'Créez une catégorie avant d’ajouter des articles.';

  @override
  String get addArticle => 'Ajouter un article';

  @override
  String get editArticle => 'Modifier l’article';

  @override
  String get saveArticle => 'Enregistrer';

  @override
  String get articleFormHint =>
      'Choisissez une catégorie, un prix, et un nom unique dans ce lieu.';

  @override
  String get articleName => 'Nom de l’article';

  @override
  String get articleDescription => 'Description';

  @override
  String get articlePrice => 'Prix';

  @override
  String get articleCategory => 'Catégorie';

  @override
  String get validationArticleName => 'Entrez un nom de 1 à 80 caractères.';

  @override
  String get validationArticlePrice => 'Entrez un prix supérieur à 0.';

  @override
  String get validationArticleCategory => 'Choisissez une catégorie.';

  @override
  String get errorArticleNameTaken => 'Ce nom d’article est déjà utilisé ici.';
}
