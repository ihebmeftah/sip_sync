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
  String get notifications => 'Notifications';

  @override
  String get notificationsReady => 'Rien de nouveau pour le moment.';

  @override
  String get notificationThisMonth => 'Ce mois-ci';

  @override
  String get notificationUnreadOnly => 'Non lues';

  @override
  String get notificationMarkAllRead => 'Tout marquer comme lu';

  @override
  String get notificationMarkRead => 'Marquer comme lu';

  @override
  String get notificationViewAll => 'Tout voir';

  @override
  String get notificationReservationAccepted =>
      'Une réservation a été acceptée';

  @override
  String get notificationReservationCancelled =>
      'Une réservation a été annulée';

  @override
  String notificationReservationRequested(String venue) {
    return 'Un client a demandé une réservation à $venue';
  }

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
  String get errorCannotReachServer =>
      'Impossible de joindre le serveur. Sur un appareil physique, lancez avec --dart-define=SERVER_URL=http://IP_LOCALE_DU_MAC:8080 (même Wi‑Fi).';

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
  String get errorInvalidResetCode =>
      'Ce code de réinitialisation est invalide.';

  @override
  String get errorResetCodeExpired =>
      'Ce code a expiré. Demandez-en un nouveau.';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get forgotPasswordTitle => 'Réinitialiser le mot de passe';

  @override
  String get forgotPasswordHint =>
      'Entrez l’e-mail du propriétaire. Nous enverrons un code.';

  @override
  String get forgotPasswordCodeHint =>
      'Entrez le code et choisissez un nouveau mot de passe.';

  @override
  String get forgotPasswordEmployeeHint =>
      'Demandez à votre responsable de réinitialiser votre mot de passe.';

  @override
  String forgotPasswordDevCode(String code) {
    return 'Code dév : $code';
  }

  @override
  String get sendResetCode => 'Envoyer le code';

  @override
  String get resetCode => 'Code de réinitialisation';

  @override
  String get resetPassword => 'Réinitialiser';

  @override
  String get passwordResetDone =>
      'Mot de passe mis à jour. Connectez-vous avec le nouveau.';

  @override
  String get backToSignIn => 'Retour à la connexion';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get changePasswordHint => 'Les autres appareils seront déconnectés.';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get updatePassword => 'Mettre à jour';

  @override
  String get passwordChanged => 'Mot de passe mis à jour.';

  @override
  String get validationPasswordMatch =>
      'Les mots de passe ne correspondent pas.';

  @override
  String get validationResetCode => 'Entrez le code de réinitialisation.';

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
  String get navScanTable => 'Scan';

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
  String get navOrders => 'Commandes';

  @override
  String get navTables => 'Tables';

  @override
  String get navConfiguration => 'Configuration';

  @override
  String get configurationTitle => 'Configuration du lieu';

  @override
  String get configurationHint => 'Ces réglages concernent uniquement ce lieu.';

  @override
  String get configurationSaved => 'Configuration enregistrée.';

  @override
  String get saveConfiguration => 'Enregistrer';

  @override
  String get buildingCustomerOrdering => 'Commandes clients';

  @override
  String get buildingCustomerOrderingHint =>
      'Activé, les clients peuvent commander depuis l\'application. Le forfait doit inclure les commandes clients.';

  @override
  String get buildingReservations => 'Réservations';

  @override
  String get buildingReservationsHint =>
      'Activé, les clients et l\'équipe peuvent créer des réservations. Le forfait doit inclure les réservations.';

  @override
  String get buildingAllowOutOfStockOrders =>
      'Autoriser la commande si un ingrédient est en rupture';

  @override
  String get buildingAllowOutOfStockOrdersHint =>
      'Activé, une commande peut passer même si un ingrédient ne couvre pas un plat de plus. Désactivé, ce plat ne peut pas être ajouté dans l\'application client et la commande est refusée.';

  @override
  String orderIngredientOutOfStock(String names) {
    return 'En rupture : $names';
  }

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
      'Commandes du jour, réservations et stock à recharger.';

  @override
  String get dashboardToday => 'Aujourd\'hui';

  @override
  String get dashboardCurrentDay => 'Jour en cours';

  @override
  String get dashboardRangeStart => 'Début';

  @override
  String get dashboardRangeEnd => 'Fin';

  @override
  String get dashboardOrderTotal => 'Commandes';

  @override
  String get dashboardOrdersByStatus => 'Commandes par statut';

  @override
  String get dashboardCustomerOrders => 'Application client';

  @override
  String get dashboardItemsByStatus => 'Articles par statut';

  @override
  String get dashboardPendingReservations => 'Demandes en attente';

  @override
  String get dashboardReservationsToday => 'Réservations du jour';

  @override
  String get dashboardRestock => 'À réapprovisionner';

  @override
  String get dashboardRestockHint => 'Moins de 10 % du stock plein';

  @override
  String get dashboardHouse => 'Réservations et stock';

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
  String get yourAccess => 'Votre accès';

  @override
  String get profileAccessHint =>
      'Voici les actions que votre profil autorise dans ce lieu.';

  @override
  String get accessFlagsNone => 'Ce profil n’autorise aucune action.';

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
  String get buildingTableMultiOrder => 'Plusieurs commandes par table';

  @override
  String get buildingTableMultiOrderHint =>
      'Activé : le personnel peut ouvrir une autre commande sur une table déjà occupée. Désactivé : il faut d’abord encaisser ou annuler la commande en cours.';

  @override
  String get buildingAllowAppendingItems =>
      'Autoriser l’ajout d’articles aux commandes ouvertes';

  @override
  String get buildingAllowAppendingItemsHint =>
      'Activé : le personnel peut ajouter des articles à une commande ouverte. Désactivé : le bouton Ajouter des articles est grisé.';

  @override
  String get buildingStrictMode => 'Workflow d’articles strict';

  @override
  String get buildingStrictModeHint =>
      'Activé : chaque ligne suit les étapes activées dans l’ordre. Désactivé : pris, prêt et servi restent coupés, et une ligne passe de en cours à payé ou est annulée.';

  @override
  String get buildingStrictModeStepsTitle => 'Étapes du workflow';

  @override
  String get buildingStrictModeStepsHint =>
      'Activez ou désactivez les étapes seulement. L’ordre est fixe.';

  @override
  String buildingStrictModeStepRank(int rank) {
    return 'Étape $rank';
  }

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
  String get validationPhone =>
      'Saisissez un téléphone avec indicatif, ex. +216…';

  @override
  String get validationPhoneCountry =>
      'Indicatif non pris en charge. Choisissez un code supporté.';

  @override
  String get validationSocialLink =>
      'Saisissez un identifiant ou une URL plus courte.';

  @override
  String get validationOtherLink =>
      'Les autres liens doivent être des URL http(s).';

  @override
  String get phoneCountryCode => 'Indicatif';

  @override
  String phoneCountryHint(String code) {
    return 'Pays : $code';
  }

  @override
  String get buildingPhone => 'Téléphone du lieu';

  @override
  String get buildingWhatsapp => 'WhatsApp';

  @override
  String get buildingInstagram => 'Instagram';

  @override
  String get buildingFacebook => 'Facebook';

  @override
  String get buildingOtherLinks => 'Autres liens';

  @override
  String get buildingOtherLinksHint => 'Une URL http(s) par ligne.';

  @override
  String get buildingSocialHint => 'Identifiant ou URL complète.';

  @override
  String get buildingCountry => 'Pays';

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
      'Touchez une table pour modifier, voir les commandes ou en créer une.';

  @override
  String get tablesEmployeeOrderHint =>
      'Touchez une table pour voir les commandes ouvertes ou en démarrer une.';

  @override
  String get tableOpenOrderHeading => 'Commande en cours';

  @override
  String get tableOpenOrdersHeading => 'Commandes en cours';

  @override
  String get tableNoOpenOrders => 'Aucune commande ouverte sur cette table.';

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
  String get tableQrExportPdf => 'Exporter PDF QR';

  @override
  String get tableQrExportEmpty =>
      'Ajoutez des tables avant d’exporter les QR.';

  @override
  String get tableQrExportFailed => 'Impossible de créer le PDF QR. Réessayez.';

  @override
  String get tableQrScanTitle => 'Scanner une table';

  @override
  String get tableQrScanHint =>
      'Pointez la caméra sur le QR de la table pour démarrer une commande.';

  @override
  String tableQrScanSuccess(int number) {
    return 'Table $number prête — ajoutez des articles.';
  }

  @override
  String get tableQrInvalid => 'Ce code n’est pas un QR de table Sip Sync.';

  @override
  String get tableQrWrongBuilding =>
      'Ce QR appartient à un autre établissement.';

  @override
  String get tableQrUnknownTable => 'Aucune table correspondante sur ce plan.';

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

  @override
  String get delete => 'Supprimer';

  @override
  String get ingredientsHint =>
      'Suivez le stock par unité. Alerte quand le stock actuel atteint le seuil.';

  @override
  String get ingredientsEmptyOwner =>
      'Ajoutez votre premier ingrédient pour démarrer le stock.';

  @override
  String get ingredientsEmpty =>
      'Aucun ingrédient dans ce lieu pour l’instant.';

  @override
  String get addIngredient => 'Ajouter un ingrédient';

  @override
  String get deleteIngredient => 'Supprimer l’ingrédient';

  @override
  String deleteIngredientConfirm(String name) {
    return 'Supprimer $name ? Action irréversible.';
  }

  @override
  String get ingredientFormHint =>
      'Le nom est unique dans ce lieu. Choisissez l’unité de réapprovisionnement.';

  @override
  String get ingredientName => 'Nom de l’ingrédient';

  @override
  String get ingredientUnit => 'Unité';

  @override
  String get ingredientCurrentStock => 'Stock actuel';

  @override
  String get ingredientThresholdStock => 'Seuil bas';

  @override
  String get ingredientThresholdHint =>
      'Alerte quand le stock atteint ce niveau.';

  @override
  String ingredientStockLine(String current, String unit, String threshold) {
    return '$current $unit · seuil $threshold';
  }

  @override
  String get ingredientRestock => 'Réapprovisionner';

  @override
  String ingredientRestockHint(String name) {
    return 'Ajouter la quantité entrante pour $name.';
  }

  @override
  String get ingredientRestockQuantity => 'Quantité entrante';

  @override
  String get validationIngredientRestock =>
      'Entrez une quantité supérieure à 0.';

  @override
  String get ingredientLowStockBadge => 'Bas';

  @override
  String ingredientLowStockBanner(int count) {
    return '$count ingrédients au seuil ou en dessous';
  }

  @override
  String ingredientStockPercent(int percent) {
    return '$percent% de la capacité';
  }

  @override
  String get validationIngredientName => 'Entrez un nom de 1 à 80 caractères.';

  @override
  String get validationIngredientStock => 'Entrez 0 ou un nombre positif.';

  @override
  String get errorIngredientNameTaken =>
      'Ce nom d’ingrédient est déjà utilisé ici.';

  @override
  String get errorIngredientInUse =>
      'Retirez cet ingrédient des recettes avant de le supprimer.';

  @override
  String get errorCompositionIngredientTaken =>
      'Cet ingrédient est déjà sur cet article.';

  @override
  String get save => 'Enregistrer';

  @override
  String get close => 'Fermer';

  @override
  String articleCompositionTitle(String name) {
    return 'Recette · $name';
  }

  @override
  String get articleCompositionHint =>
      'Facultatif. Ajoutez les ingrédients pour une portion de cet article.';

  @override
  String get compositionEmpty => 'Aucune ligne de recette — c’est normal.';

  @override
  String get compositionNone => 'Sans recette';

  @override
  String compositionCount(int count) {
    return '$count ingrédients';
  }

  @override
  String get compositionNeedIngredients =>
      'Ajoutez d’abord des ingrédients, puis la recette.';

  @override
  String get compositionAllIngredientsUsed =>
      'Tous les ingrédients sont déjà sur cet article.';

  @override
  String get compositionIngredient => 'Ingrédient';

  @override
  String get compositionQuantity => 'Quantité par article';

  @override
  String get addCompositionLine => 'Ajouter à la recette';

  @override
  String get editCompositionQuantity => 'Modifier la quantité';

  @override
  String get removeCompositionLine => 'Retirer de la recette';

  @override
  String removeCompositionLineConfirm(String name) {
    return 'Retirer $name de cette recette ?';
  }

  @override
  String get unitGram => 'Gramme (g)';

  @override
  String get unitKilogram => 'Kilogramme (kg)';

  @override
  String get unitMilliliter => 'Millilitre (ml)';

  @override
  String get unitCentiliter => 'Centilitre (cl)';

  @override
  String get unitLiter => 'Litre (L)';

  @override
  String get unitPiece => 'Pièce (unité)';

  @override
  String get unitBottle => 'Bouteille';

  @override
  String get unitCan => 'Boîte de conserve';

  @override
  String get unitPack => 'Paquet';

  @override
  String get unitBox => 'Carton';

  @override
  String get unitBunch => 'Botte';

  @override
  String get unitTeaspoon => 'Cuillère à café (c. à c.)';

  @override
  String get unitTablespoon => 'Cuillère à soupe (c. à s.)';

  @override
  String get unitCup => 'Tasse';

  @override
  String get unitAbbrevGram => 'g';

  @override
  String get unitAbbrevKilogram => 'kg';

  @override
  String get unitAbbrevMilliliter => 'ml';

  @override
  String get unitAbbrevCentiliter => 'cl';

  @override
  String get unitAbbrevLiter => 'L';

  @override
  String get unitAbbrevPiece => 'pce';

  @override
  String get unitAbbrevBottle => 'btl';

  @override
  String get unitAbbrevCan => 'boîte';

  @override
  String get unitAbbrevPack => 'paq.';

  @override
  String get unitAbbrevBox => 'ctn';

  @override
  String get unitAbbrevBunch => 'botte';

  @override
  String get unitAbbrevTeaspoon => 'c.à.c.';

  @override
  String get unitAbbrevTablespoon => 'c.à.s.';

  @override
  String get unitAbbrevCup => 'tasse';

  @override
  String get ordersHint =>
      'Créez des commandes, avancez le statut cuisine et enregistrez le paiement.';

  @override
  String get orderBoardHint =>
      'Glissez une ligne, ou maintenez et déposez la table sur la colonne suivante.';

  @override
  String get orderBoardCancel => 'Annulé';

  @override
  String get orderBoardCancelHint =>
      'Sélectionnez des articles ou toute la commande, puis confirmez.';

  @override
  String get orderBoardCancelConfirm => 'Confirmer';

  @override
  String get orderBoardEmpty => 'Aucun ticket en cours.';

  @override
  String get orderBoardColumnEmpty => 'Rien ici';

  @override
  String get orderBoardNewOrder => 'Nouvelle commande';

  @override
  String get orderBoardItemAdded => 'Ajouté';

  @override
  String get orderBoardNoTable => 'Sans table';

  @override
  String get orderViewItems => 'Articles';

  @override
  String get orderViewList => 'Liste des commandes';

  @override
  String get ordersEmpty =>
      'Aucune commande. Appuyez sur Nouvelle commande pour commencer.';

  @override
  String get ordersFilterAll => 'Toutes';

  @override
  String get ordersFilterEmpty => 'Aucune commande pour ce statut.';

  @override
  String get ordersFilterToday => 'Aujourd\'hui';

  @override
  String get ordersFilterLast3Days => '3 derniers jours';

  @override
  String get ordersFilterLastWeek => 'Semaine dernière';

  @override
  String get ordersFilterPickDay => 'Choisir un jour';

  @override
  String get ordersDayFilterEmpty => 'Aucune commande sur cette période.';

  @override
  String get newOrder => 'Nouvelle commande';

  @override
  String get cancelOrderDraft => 'Annuler la sélection';

  @override
  String get orderResetArticles => 'Réinitialiser les articles';

  @override
  String get orderChangeTable => 'Changer de table';

  @override
  String get orderCancelCreate => 'Annuler la commande';

  @override
  String get createOrder => 'Créer la commande';

  @override
  String get newOrderHint =>
      'Choisissez une table, puis ajoutez des articles. Vous êtes enregistré comme lanceur.';

  @override
  String get orderSelectTablePrompt =>
      'Sélectionnez une table pour cette commande.';

  @override
  String get orderSelectTableFloorHint =>
      'Touchez une table sur le plan de salle pour continuer avec les articles.';

  @override
  String get orderTableInactive =>
      'Cette table est inactive. Choisissez une table active.';

  @override
  String get orderTableOccupied => 'Cette table a déjà une commande ouverte.';

  @override
  String get orderAppendArticles => 'Ajouter des articles';

  @override
  String get orderAppendArticlesDisabled =>
      'Ce lieu n’autorise pas l’ajout d’articles aux commandes ouvertes.';

  @override
  String get orderNoActiveTables =>
      'Aucune table active. Créez d’abord des tables.';

  @override
  String get orderSearchArticles => 'Rechercher des articles par nom';

  @override
  String get orderAllCategories => 'Tous';

  @override
  String get orderNoArticlesMatch => 'Aucun article ne correspond à ce filtre.';

  @override
  String get orderConfirm => 'Confirmer la commande';

  @override
  String get orderAddUnit => 'Ajouter une unité';

  @override
  String get orderRemoveUnit => 'Retirer une unité';

  @override
  String get orderTableOptional => 'Table (facultatif)';

  @override
  String get orderNoTable => 'Sans table';

  @override
  String orderTableNumber(int number) {
    return 'Table $number';
  }

  @override
  String get orderNeedArticles =>
      'Ajoutez des articles dans Produits avant de commander.';

  @override
  String get validationOrderItems => 'Ajoutez au moins un article.';

  @override
  String get orderItemsLabel => 'articles';

  @override
  String get orderItemsHeading => 'Articles';

  @override
  String orderDetailTitle(String table) {
    return 'Commande · $table';
  }

  @override
  String orderRefTitle(int ref) {
    return 'Commande · #$ref';
  }

  @override
  String orderRefLabel(int ref) {
    return '#$ref';
  }

  @override
  String orderLaunchedBy(String actor) {
    return 'Lancée par $actor';
  }

  @override
  String orderLastPaidBy(String actor) {
    return 'Dernier paiement par $actor';
  }

  @override
  String get cancelOrder => 'Annuler la commande';

  @override
  String get cancelOrderConfirm =>
      'Annuler cette commande et les lignes ouvertes ?';

  @override
  String get cancelReasonTitle => 'Pourquoi annuler ?';

  @override
  String get cancelReasonConfirm => 'Annuler';

  @override
  String get cancelReasonOutOfStock => 'Ingrédient en rupture de stock';

  @override
  String get cancelReasonClosingSoon => 'L\'heure de fermeture approche';

  @override
  String get cancelReasonWorkBreakdown =>
      'Panne au travail, réessayez plus tard';

  @override
  String get cancelReasonCustomerRequest => 'Annulé à la demande du client';

  @override
  String get cancelOrderItem => 'Annuler l’article';

  @override
  String get orderItemInfo => 'Détails de l’article';

  @override
  String get orderInfo => 'Dates de la commande';

  @override
  String get orderFieldCreatedAt => 'Créé';

  @override
  String get orderFieldUpdatedAt => 'Mis à jour';

  @override
  String get orderFieldPreparedAt => 'Préparé';

  @override
  String get orderFieldServedAt => 'Servi';

  @override
  String get orderFieldPaidAt => 'Payé';

  @override
  String orderFieldPaidAtLabel(String when) {
    return 'Payé $when';
  }

  @override
  String get orderFieldPreparedBy => 'Préparé par';

  @override
  String get orderFieldServedBy => 'Servi par';

  @override
  String get orderFieldPaidTo => 'Encaissé par';

  @override
  String get orderFieldLaunchedBy => 'Lancée par';

  @override
  String get orderFieldCancelledBy => 'Annulé par';

  @override
  String get orderFieldCancelledAt => 'Annulé';

  @override
  String orderCancelledBy(String actor) {
    return 'Annulé par $actor';
  }

  @override
  String orderActorLabel(String role, String name) {
    return '$role - $name';
  }

  @override
  String get actorRoleOwner => 'Propriétaire';

  @override
  String get actorRoleEmployee => 'Employé';

  @override
  String get actorRoleCustomer => 'Client';

  @override
  String get actorRoleSuperAdmin => 'Admin';

  @override
  String orderFieldCancelledAtLabel(String when) {
    return 'Annulé $when';
  }

  @override
  String orderFieldCreatedAtLabel(String when) {
    return 'Créé $when';
  }

  @override
  String orderFieldUpdatedAtLabel(String when) {
    return 'Mis à jour $when';
  }

  @override
  String get orderStatusProgress => 'En cours';

  @override
  String get orderStatusPayed => 'Payée';

  @override
  String get orderStatusCancelled => 'Annulée';

  @override
  String get orderItemStatusProgress => 'En cours';

  @override
  String get orderItemStatusPicked => 'Prise';

  @override
  String get orderItemStatusReady => 'Préparé';

  @override
  String get orderItemStatusServed => 'Servie';

  @override
  String get orderItemStatusPayed => 'Payée';

  @override
  String get orderItemStatusCancelled => 'Annulée';

  @override
  String get orderItemPayNow => 'Encaisser';

  @override
  String get errorOrderInvalidStatus =>
      'Ce changement de statut n’est pas autorisé.';

  @override
  String get errorOrderInsufficientStock =>
      'Stock d’ingrédients insuffisant pour cette commande.';

  @override
  String get errorOrderTableOccupied =>
      'Cette table a déjà une commande ouverte.';

  @override
  String get errorOrderAppendNotAllowed =>
      'L’ajout d’articles aux commandes ouvertes n’est pas autorisé pour ce lieu.';

  @override
  String get errorOrderPermissionDenied =>
      'Votre profil d’accès n’autorise pas cette action.';

  @override
  String get errorOrderCancelLocked =>
      'Cette ligne ou cette commande ne peut plus être annulée.';

  @override
  String get errorAccessNameTaken => 'Ce nom d’accès est déjà utilisé ici.';

  @override
  String get errorAccessInUse =>
      'Réassignez le personnel avant de supprimer ce profil d’accès.';

  @override
  String get navAccessProfiles => 'Accès';

  @override
  String get accessProfilesHint =>
      'Jeux de permissions nommés à assigner aux employés.';

  @override
  String get accessProfilesEmpty =>
      'Aucun profil d’accès. Créez-en un avant d’ajouter du personnel.';

  @override
  String get addAccessProfile => 'Ajouter un accès';

  @override
  String get editAccessProfile => 'Modifier l’accès';

  @override
  String get saveAccessProfile => 'Enregistrer l’accès';

  @override
  String get deleteAccessProfile => 'Supprimer l’accès';

  @override
  String deleteAccessProfileConfirm(String name) {
    return 'Supprimer « $name » ? Réassignez d’abord le personnel.';
  }

  @override
  String get accessProfileName => 'Nom de l’accès';

  @override
  String get accessProfile => 'Profil d’accès';

  @override
  String get accessProfileNone => 'Aucun';

  @override
  String get employeeNeedsAccessProfile =>
      'Créez un profil d’accès avant d’ajouter un employé.';

  @override
  String get validationAccessName => 'Saisissez un nom de 80 caractères max.';

  @override
  String get validationAccessRequired => 'Choisissez un profil d’accès.';

  @override
  String get accessOrderCreation => 'Créer des commandes';

  @override
  String get accessOrderCreationHint =>
      'Créer des commandes et ajouter des articles.';

  @override
  String get accessOrderPayment => 'Encaisser';

  @override
  String get accessOrderPaymentHint =>
      'Marquer articles et commandes comme payés.';

  @override
  String get accessCancelOrder => 'Annuler des commandes';

  @override
  String get accessCancelOrderHint => 'Annuler une commande ou une ligne.';

  @override
  String get accessPreparation => 'Préparation';

  @override
  String get accessPreparationHint => 'Marquer pris ou prêt.';

  @override
  String get accessServing => 'Service';

  @override
  String get accessServingHint => 'Marquer servi.';

  @override
  String get accessConsultAllOrders => 'Voir toutes les commandes';

  @override
  String get accessConsultAllOrdersHint =>
      'Désactivé : seulement celles lancées ou auxquelles ils ont ajouté des lignes.';

  @override
  String get accessFlagCreate => 'Créer';

  @override
  String get accessFlagPay => 'Payer';

  @override
  String get accessFlagCancel => 'Annuler';

  @override
  String get accessFlagPrep => 'Préparer';

  @override
  String get accessFlagServe => 'Servir';

  @override
  String get accessFlagConsultAll => 'Toutes';

  @override
  String get accessNoFlags => 'Aucune permission';

  @override
  String packBannerTitle(String name) {
    return 'Pack : $name';
  }

  @override
  String get packBannerHint =>
      'Pour changer de pack, contactez l\'équipe support.';

  @override
  String get errorPackLimit => 'Ce pack a atteint sa limite.';

  @override
  String get errorPackFeature => 'Ce pack n\'inclut pas cela.';

  @override
  String get errorPackLimitEmployees =>
      'Ce pack a atteint la limite d\'employés.';

  @override
  String get errorPackLimitTables => 'Ce pack a atteint la limite de tables.';

  @override
  String get errorPackLimitCategories =>
      'Ce pack a atteint la limite de catégories.';

  @override
  String get errorPackLimitArticles =>
      'Ce pack a atteint la limite d\'articles.';

  @override
  String get errorPackLimitIngredients =>
      'Ce pack a atteint la limite d\'ingrédients.';

  @override
  String get errorPackFeatureOrdering =>
      'Ce pack n\'inclut pas les commandes client.';

  @override
  String get errorPackFeatureInventory =>
      'Ce pack n\'inclut pas l\'inventaire.';

  @override
  String get errorPackFeatureAppend =>
      'Ce pack n\'inclut pas l\'ajout d\'articles à une commande ouverte.';

  @override
  String get errorPackFeatureMultiOrder =>
      'Ce pack n\'inclut pas plusieurs commandes sur une table.';

  @override
  String get errorPackFeatureStrict =>
      'Ce pack n\'inclut pas les étapes strictes.';

  @override
  String get errorPackFeatureAccess =>
      'Ce pack n\'inclut pas les profils d\'accès personnalisés.';

  @override
  String get errorPackFeatureQr => 'Ce pack n\'inclut pas les QR de table.';

  @override
  String get navReservations => 'Réservations';

  @override
  String reservationPendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count demandes en attente',
      one: '1 demande en attente',
    );
    return '$_temp0';
  }

  @override
  String get reservationsTitle => 'Réservations';

  @override
  String get reservationNew => 'Nouvelle réservation';

  @override
  String get reservationPreviousDay => 'Jour précédent';

  @override
  String get reservationNextDay => 'Jour suivant';

  @override
  String get reservationEmpty => 'Aucune réservation ce jour.';

  @override
  String get reservationGuestName => 'Nom de l\'invité';

  @override
  String get reservationGuestPhone => 'Téléphone';

  @override
  String get reservationPaidAmount => 'Montant payé';

  @override
  String get reservationPaidInvalid => 'Saisissez un montant de 0 à 1000000.';

  @override
  String get reservationFee => 'Frais de réservation';

  @override
  String get reservationFeeHint =>
      'Préremplit le montant d\'une réservation du personnel, dans la devise du lieu.';

  @override
  String get reservationDate => 'Date';

  @override
  String get reservationStart => 'Début';

  @override
  String get reservationEnd => 'Fin';

  @override
  String get reservationTables => 'Tables';

  @override
  String get reservationFindCustomer => 'Trouver le client';

  @override
  String get reservationGuestInstead => 'Saisir un invité plutôt qu\'un compte';

  @override
  String get reservationCancel => 'Annuler la réservation';

  @override
  String get reservationCancelConfirm => 'Annuler cette réservation ?';

  @override
  String get reservationConfirm => 'Confirmer';

  @override
  String get reservationAssignTable => 'Assigner une table';

  @override
  String get reservationNoTable => 'Aucune table';

  @override
  String get reservationCreateHint =>
      'Cette réservation est confirmée. Assignez une table depuis la liste.';

  @override
  String get reservationStatusRequested => 'Demandée';

  @override
  String get reservationStatusConfirmed => 'Confirmée';

  @override
  String get reservationStatusArrived => 'Arrivée';

  @override
  String get reservationStatusCancelled => 'Annulée';

  @override
  String get reservationStatusNoShow => 'Absent';

  @override
  String get reservationSoon => 'Bientôt';

  @override
  String get reservationHolding => 'En attente d\'arrivée';

  @override
  String get reservationHeldOrder =>
      'Cette table est réservée. Scannez-la pour confirmer l\'arrivée avant de prendre une commande.';

  @override
  String get reservationScanNeedsAccess =>
      'Seul un profil avec l\'accès réservations peut confirmer cette table.';

  @override
  String get reservationWindow =>
      'Choisissez un début qui n\'est pas déjà terminé.';

  @override
  String get reservationSearchHint => 'Nom, téléphone ou e-mail';

  @override
  String get reservationCustomerAccount => 'Compte client';

  @override
  String get reservationSearchEmpty => 'Aucun client ne correspond.';

  @override
  String get reservationSelectTables => 'Choisissez au moins une table.';

  @override
  String get accessReservations => 'Réservations';

  @override
  String get accessReservationsHint =>
      'Créer, confirmer, annuler et assigner les tables des réservations.';

  @override
  String get errorPackFeatureReservations =>
      'Ce pack n\'inclut pas les réservations.';

  @override
  String get errorPackLimitReservations =>
      'Ce pack a atteint sa limite de réservations pour la journée.';

  @override
  String get errorOrderReservationHeld =>
      'Confirmez la réservation avant de prendre une commande.';

  @override
  String get errorCustomerOrderingDisabled =>
      'Ce lieu a désactivé les commandes clients.';

  @override
  String get errorReservationsDisabled =>
      'Ce lieu a désactivé les réservations.';

  @override
  String get errorReservationOverlap =>
      'Une table est déjà réservée à cette heure.';

  @override
  String get errorReservationNotFound =>
      'Aucun client ou aucune réservation ne correspond.';

  @override
  String get packCapReservations => 'Réservations';

  @override
  String get packCapReservationsPerDay => 'Réservations / jour';

  @override
  String get errorPackPaidActive => 'Ce lieu a déjà un pack payant.';

  @override
  String get previousPage => 'Précédent';

  @override
  String get nextPage => 'Suivant';

  @override
  String pageOf(int current, int total) {
    return '$current / $total';
  }

  @override
  String get loadingMore => 'Chargement…';

  @override
  String get packUpgrade => 'Améliorer';

  @override
  String get packCatalogTitle => 'Packs';

  @override
  String get packCatalogIntro =>
      'Comparez les packs publics. Changer le pack de ce lieu passe toujours par l\'équipe support.';

  @override
  String packCatalogIntroCurrent(String name) {
    return 'Ce lieu est sur $name. Changer de pack passe toujours par l\'équipe support.';
  }

  @override
  String get packCatalogEmpty => 'Aucun pack public n\'est disponible.';

  @override
  String get packCurrent => 'Actuel';

  @override
  String packPriceMonth(String price) {
    return '$price TND / mois';
  }

  @override
  String packPriceYear(String price) {
    return '$price TND / an';
  }

  @override
  String packFeeLine(String percent) {
    return 'Frais app client $percent %';
  }

  @override
  String get packUnlimited => 'Illimité';

  @override
  String get packLimits => 'Limites';

  @override
  String get packCapabilities => 'Capacités';

  @override
  String packLimitValue(String label, String value) {
    return '$label : $value';
  }

  @override
  String get packCapEmployees => 'Employés';

  @override
  String get packCapTables => 'Tables';

  @override
  String get packCapCategories => 'Catégories';

  @override
  String get packCapArticles => 'Articles';

  @override
  String get packCapIngredients => 'Ingrédients';

  @override
  String get packCapDiscovery => 'Carte client';

  @override
  String get packCapQr => 'QR des tables';

  @override
  String get packCapOrdering => 'Commande client';

  @override
  String get packCapInventory => 'Stock et recettes';

  @override
  String get packCapAppend => 'Ajouter des articles à une commande';

  @override
  String get packCapMultiOrder => 'Plusieurs commandes par table';

  @override
  String get packCapStrict => 'Étapes cuisine strictes';

  @override
  String get packCapAccess => 'Profils d\'accès personnalisés';
}
