// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'S&S office';

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
  String get noticeSaved => 'Enregistré.';

  @override
  String get noticeRemoved => 'Supprimé.';

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
  String get navStats => 'Statistiques';

  @override
  String get navUsers => 'Utilisateurs';

  @override
  String get navCustomers => 'Clients';

  @override
  String get navBuildings => 'Établissements';

  @override
  String get navCountries => 'Pays / Cartes';

  @override
  String get navPacks => 'Packs';

  @override
  String get navSection => 'Plateforme';

  @override
  String get statsTitle => 'Statistiques';

  @override
  String get customersTitle => 'Clients';

  @override
  String get customersSubtitle => 'Propriétaires et clients de la plateforme.';

  @override
  String get tabOwners => 'Propriétaires';

  @override
  String get tabCustomers => 'Clients';

  @override
  String get createdAt => 'Créé';

  @override
  String accountCreated(String when) {
    return 'Créé le $when';
  }

  @override
  String get packsTitle => 'Packs';

  @override
  String get screenWorking => 'Cet écran fonctionne.';

  @override
  String get usersTitle => 'Utilisateurs';

  @override
  String get usersSubtitle =>
      'Comptes backoffice autorisés à ouvrir cette console.';

  @override
  String get buildingsTitle => 'Établissements';

  @override
  String get buildingsSubtitle =>
      'Tous les lieux de la plateforme. Recherchez par nom, propriétaire ou adresse, et filtrez par pack.';

  @override
  String get buildingSearchLabel => 'Recherche';

  @override
  String get buildingSearchHint => 'Nom du lieu, du propriétaire ou adresse';

  @override
  String get buildingSearchAction => 'Rechercher';

  @override
  String get buildingPackFilter => 'Pack';

  @override
  String get buildingPackAll => 'Tous les packs';

  @override
  String get buildingsFilterEmpty =>
      'Aucun lieu ne correspond à cette recherche.';

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
  String countryLabeled(String name, String code) {
    return '$name ($code)';
  }

  @override
  String get countriesTitle => 'Pays / Cartes';

  @override
  String get countriesSubtitle =>
      'Combien de lieux se trouvent dans chaque pays.';

  @override
  String countryVenueCount(int count) {
    return '$count lieux';
  }

  @override
  String get osmAttribution => '© Contributeurs OpenStreetMap';

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

  @override
  String get packsSubtitle =>
      'Les packs publics apparaissent dans les apps pour qu\'un propriétaire puisse changer d\'offre. Les packs privés sont accordés à des propriétaires précis.';

  @override
  String get createPack => 'Créer un pack';

  @override
  String get editPack => 'Mettre à jour le pack';

  @override
  String get packCode => 'Code';

  @override
  String get packName => 'Nom';

  @override
  String get packMonthly => 'Prix mensuel (TND)';

  @override
  String get packAnnual => 'Prix annuel (TND)';

  @override
  String get packAnnualHint =>
      'Laissez le prix annuel vide pour ne proposer que le mensuel.';

  @override
  String get packFee => 'Frais app client (%)';

  @override
  String get packFeeHint =>
      'Appliqué aux commandes de l\'app client. Les tickets du personnel restent à 0 %.';

  @override
  String get packPublic => 'Public';

  @override
  String get packPrivate => 'Privé';

  @override
  String get packPublicHint =>
      'Les propriétaires voient ce pack dans les apps et peuvent y passer.';

  @override
  String get packPrivateHint => 'Ce pack n\'apparaît pas dans les apps.';

  @override
  String get packEnabled => 'Activé';

  @override
  String get packEnabledHint =>
      'Un pack désactivé reste hors de la liste publique. Les lieux déjà dessus le gardent.';

  @override
  String get packSortOrder => 'Ordre';

  @override
  String get packLimits => 'Limites';

  @override
  String get packUnlimitedHint =>
      'Laissez une limite vide pour ne pas plafonner.';

  @override
  String get packCapabilities => 'Capacités';

  @override
  String get capMaxEmployees => 'Employés';

  @override
  String get capMaxEmployeesHint =>
      'Nombre de comptes employés que ce lieu peut avoir.';

  @override
  String get capMaxTables => 'Tables';

  @override
  String get capMaxTablesHint => 'Nombre de tables que ce lieu peut ajouter.';

  @override
  String get capMaxCategories => 'Catégories';

  @override
  String get capMaxCategoriesHint =>
      'Nombre de catégories de carte que ce lieu peut ajouter.';

  @override
  String get capMaxArticles => 'Articles';

  @override
  String get capMaxArticlesHint =>
      'Nombre d\'articles vendables que ce lieu peut ajouter.';

  @override
  String get capMaxIngredients => 'Ingrédients';

  @override
  String get capMaxIngredientsHint =>
      'Nombre d\'ingrédients de stock que ce lieu peut ajouter.';

  @override
  String get capCustomerDiscovery => 'Carte client';

  @override
  String get capCustomerDiscoveryHint =>
      'Le lieu apparaît sur la carte des clients.';

  @override
  String get capTableQr => 'QR des tables';

  @override
  String get capTableQrHint =>
      'L\'équipe peut imprimer et scanner les QR des tables.';

  @override
  String get capCustomerOrdering => 'Commande client';

  @override
  String get capCustomerOrderingHint =>
      'Un client peut passer une commande depuis le menu après avoir scanné une table.';

  @override
  String get capInventory => 'Stock et recettes';

  @override
  String get capInventoryHint =>
      'Recettes, niveaux de stock, réassort, et déduction à la commande.';

  @override
  String get capAllowAppending => 'Ajouter des articles à une commande';

  @override
  String get capAllowAppendingHint =>
      'Le lieu peut autoriser d\'ajouter des articles à une commande ouverte.';

  @override
  String get capTableMultiOrder => 'Plusieurs commandes par table';

  @override
  String get capTableMultiOrderHint =>
      'Le lieu peut autoriser plus d\'une commande ouverte sur la même table.';

  @override
  String get capStrictMode => 'Étapes cuisine strictes';

  @override
  String get capStrictModeHint =>
      'Le lieu peut imposer les étapes dans l\'ordre : pris, prêt, servi, puis payé.';

  @override
  String get capCustomAccess => 'Profils d\'accès personnalisés';

  @override
  String get capCustomAccessHint =>
      'Le propriétaire peut ajouter des profils au-delà de Serveur, Gérant et Barista.';

  @override
  String get capReservations => 'Réservations';

  @override
  String get capReservationsHint =>
      'Le personnel et les clients peuvent réserver. Un plafond quotidien s\'applique s\'il est renseigné.';

  @override
  String get capCashRegister => 'Caisse';

  @override
  String get capCashRegisterHint =>
      'Le lieu peut exiger une caisse ouverte. Les commandes et le tableau de bord suivent alors ce service.';

  @override
  String get errorPackFeatureCashRegister => 'Ce pack n\'inclut pas la caisse.';

  @override
  String get capMaxReservations => 'Réservations par jour';

  @override
  String get capMaxReservationsHint =>
      'Laissez vide pour aucun plafond. Compte les réservations non annulées dont le début tombe sur une date UTC.';

  @override
  String packPriceMonth(String price) {
    return '$price TND / mois';
  }

  @override
  String packPriceYear(String price) {
    return '$price TND / an';
  }

  @override
  String get packSystem => 'système';

  @override
  String get deletePack => 'Supprimer le pack';

  @override
  String deletePackConfirm(String name) {
    return 'Supprimer $name ?';
  }

  @override
  String get errorPackCodeTaken => 'Ce code est déjà utilisé.';

  @override
  String get errorCannotDeleteSystemPack =>
      'Le pack gratuit ne peut pas être supprimé.';

  @override
  String get errorPackInUse => 'Un lieu est encore sur ce pack.';

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
  String get errorPackFeatureReservations =>
      'Ce pack n\'inclut pas les réservations.';

  @override
  String get errorPackLimitReservations =>
      'Ce pack a atteint sa limite de réservations pour la journée.';

  @override
  String get errorPackPaidActive =>
      'Ce lieu a déjà un pack payant. Assignez un autre pack après la fin du terme.';

  @override
  String get packHistoryTitle => 'Historique des packs';

  @override
  String get packHistoryCurrent => 'En cours';

  @override
  String get packEndReplaced => 'Remplacé';

  @override
  String get packEndExpired => 'Expiré';

  @override
  String get packPaidLocked =>
      'Ce lieu est sur un pack payant. Un autre pack pourra être assigné à la fin du terme.';

  @override
  String get buildingDetailTitle => 'Lieu';

  @override
  String get buildingDetailSubtitle =>
      'Contact, pack, gain et compteurs de ce lieu.';

  @override
  String get buildingTabDetails => 'Détails';

  @override
  String get buildingTabPack => 'Pack';

  @override
  String get buildingTabGain => 'Gain';

  @override
  String get buildingTabStats => 'Stats';

  @override
  String get assignPack => 'Affecter un pack';

  @override
  String get packBillingDaily => 'Quotidien';

  @override
  String get packBillingMonthly => 'Mensuel';

  @override
  String get packBillingYearly => 'Annuel';

  @override
  String packExpiresOn(String date) {
    return 'Revient au gratuit le $date';
  }

  @override
  String get packExpiresNever => 'Pack gratuit. Pas de date de fin.';

  @override
  String get packTermHint =>
      'Un terme quotidien dure au plus 20 jours. Un terme mensuel se termine au plus tôt dans un mois. Un terme annuel se termine au plus tôt dans un an. Vous pouvez repousser la date.';

  @override
  String get packChangeDate => 'Changer la date';

  @override
  String get packAssignConfirm => 'Affecter';

  @override
  String get packDailyStartsMonthly =>
      'Plus de 20 jours démarre un terme mensuel.';

  @override
  String get validationPackExpiry => 'Choisissez une date après aujourd\'hui.';

  @override
  String get validationPackMonthlyMin =>
      'Un terme mensuel se termine au plus tôt un mois après aujourd\'hui.';

  @override
  String get validationPackYearlyMin =>
      'Un terme annuel se termine au plus tôt un an après aujourd\'hui.';

  @override
  String get quickCreatePack => 'Créer un pack privé';

  @override
  String get quickCreatePackHint =>
      'Un nouveau pack est privé. Il reste hors de la liste publique.';

  @override
  String packFeeLabel(String fee) {
    return '$fee % sur les commandes de l\'appli client';
  }

  @override
  String get packNoLimit => 'Sans limite';

  @override
  String get gainHint =>
      'Prix mensuel du pack, plus la commission sur les commandes client. Les tickets du personnel ne sont pas inclus.';

  @override
  String get gainMonthly => 'Abonnement mensuel';

  @override
  String get gainFeeRate => 'Frais appli client';

  @override
  String get gainCustomerOrders => 'Commandes client';

  @override
  String get gainCustomerSales => 'Ventes appli client';

  @override
  String get gainFeeEarned => 'Commission gagnée';

  @override
  String get statCategories => 'Catégories';

  @override
  String get statArticles => 'Articles';

  @override
  String get statTables => 'Tables';

  @override
  String get statOrders => 'Commandes';

  @override
  String get statsSubtitle =>
      'Personnes, lieux, commandes, et qui est sur chaque pack public.';

  @override
  String get statOwners => 'Propriétaires';

  @override
  String get statCustomers => 'Clients';

  @override
  String get statVenues => 'Lieux';

  @override
  String get statEmployees => 'Employés';

  @override
  String get statSubscription => 'Abonnements mensuels';

  @override
  String get publicPacksTitle => 'Packs publics';

  @override
  String get publicPacksSubtitle =>
      'Lieux et propriétaires actuellement sur chaque pack public.';

  @override
  String get validationRequired => 'Ce champ est obligatoire.';

  @override
  String get validationEmail => 'Saisissez un e-mail valide.';

  @override
  String get validationPassword =>
      'Au moins 8 caractères, sans espace au début ou à la fin.';

  @override
  String get validationPhone =>
      'Saisissez un numéro avec l\'indicatif, p. ex. +216…';

  @override
  String get validationPackCode =>
      'Commencez par une lettre, puis des lettres, chiffres ou _.';

  @override
  String get validationPackMoney =>
      'Saisissez un prix en dinars, jusqu\'à 3 décimales.';

  @override
  String get validationPackFee => 'Saisissez un pourcentage entre 0 et 100.';

  @override
  String get validationPackSort => 'Saisissez un nombre entier.';

  @override
  String get validationPackLimit =>
      'Saisissez un nombre, ou laissez vide pour illimité.';

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
}
