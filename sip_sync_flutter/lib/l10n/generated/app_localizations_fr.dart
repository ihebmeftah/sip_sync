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

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Retour';

  @override
  String get menu => 'Menu';

  @override
  String availableTables(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tables libres',
      one: '1 table libre',
      zero: 'Aucune table libre',
    );
    return '$_temp0';
  }

  @override
  String get previewCategories => 'Catégories phares';

  @override
  String get previewArticles => 'Plats phares';

  @override
  String articleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plats',
      one: '1 plat',
      zero: 'Aucun plat',
    );
    return '$_temp0';
  }

  @override
  String get emptyMenuPreview => 'Rien au menu pour le moment.';

  @override
  String get emptyMenu => 'Cette maison n\'a pas encore publié de carte.';

  @override
  String get emptyMenuSection => 'Rien dans cette section pour le moment.';

  @override
  String get seeAll => 'Tout voir';

  @override
  String tableNumber(int number) {
    return 'Table $number';
  }

  @override
  String get discoveryTab => 'Découverte';

  @override
  String get ordersTab => 'Commandes';

  @override
  String get filterToday => 'Aujourd\'hui';

  @override
  String get filterLastWeek => 'Semaine dernière';

  @override
  String get filterLastMonth => 'Mois dernier';

  @override
  String get emptyOrders => 'Aucune commande sur cette période.';

  @override
  String orderItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plats',
      one: '1 plat',
    );
    return '$_temp0';
  }

  @override
  String get orderStatusProgress => 'En cours';

  @override
  String get orderStatusPayed => 'Payée';

  @override
  String get orderStatusCancelled => 'Annulée';

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
  String get openOrderNote => 'La cuisine a votre commande';

  @override
  String get openOrderLead => 'Suivez chaque plat, jusqu\'au moment de régler.';

  @override
  String get openOrderDetails => 'Détails';

  @override
  String get itemStatusPicked => 'En cuisine';

  @override
  String get itemStatusReady => 'Prêt';

  @override
  String get itemStatusServed => 'Servi';

  @override
  String get scanTable => 'Scanner la table';

  @override
  String get changeTable => 'Changer de table';

  @override
  String get scanTableHint => 'Pointez la caméra vers le QR de votre table.';

  @override
  String get tableScanInvalid => 'Ce code n\'est pas un QR de table Sip Sync.';

  @override
  String get tableScanUnknown =>
      'Ce code ne correspond pas à une table active.';

  @override
  String get tableScanCamera =>
      'Caméra indisponible. Autorisez l\'accès et réessayez.';

  @override
  String get yourTable => 'Votre table';

  @override
  String seatedAt(int number) {
    return 'Vous êtes à la table $number';
  }

  @override
  String tableChanged(int number) {
    return 'Table changée. Vous êtes maintenant à la table $number.';
  }

  @override
  String get addArticle => 'Ajouter';

  @override
  String articleOutOfStock(String names) {
    return 'En rupture : $names';
  }

  @override
  String get removeArticle => 'Retirer';

  @override
  String get passOrder => 'Passer la commande';

  @override
  String get yourOrder => 'Votre commande';

  @override
  String get orderEmpty => 'Ajoutez un plat avant d\'envoyer la commande.';

  @override
  String get scanTableToOrder =>
      'Scannez le QR de votre table pour envoyer la commande.';

  @override
  String cartSummary(int count, String total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plats',
      one: '1 plat',
    );
    return '$_temp0 · $total';
  }

  @override
  String get total => 'Total';

  @override
  String get orderSent => 'Envoyée en cuisine';

  @override
  String orderRef(int ref) {
    return 'Commande n° $ref';
  }

  @override
  String lineQuantity(int count, String name) {
    return '$count × $name';
  }

  @override
  String get errorTableOccupied => 'Cette table a déjà une commande ouverte.';

  @override
  String get errorInsufficientStock =>
      'Un article de cette commande n\'est plus disponible.';

  @override
  String get errorAppendNotAllowed =>
      'Cette maison n\'autorise pas l\'ajout de plats à une commande ouverte.';

  @override
  String get currentOrder => 'Commande en cours';

  @override
  String get orderHistory => 'Historique';

  @override
  String get addToOrder => 'Ajouter à la commande';

  @override
  String get scanDisabled =>
      'Le scan est indisponible tant qu\'une commande est en cours.';

  @override
  String get orderKeepsYouHere =>
      'Réglez cette commande avant de revenir à la carte.';

  @override
  String seatCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count places',
      one: '1 place',
    );
    return '$_temp0';
  }

  @override
  String get venueTypeCafe => 'Café';

  @override
  String get venueTypeRestaurant => 'Restaurant';

  @override
  String get venueTypeLounge => 'Lounge';

  @override
  String get venueTypeBar => 'Bar';

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
  String get reserveTable => 'Demander une réservation';

  @override
  String get signInToReserve => 'Connectez-vous pour demander une réservation';

  @override
  String get reservationBook => 'Demander';

  @override
  String get reservationMine => 'Mes réservations';

  @override
  String get reservationEmpty => 'Vous n\'avez pas de réservation à venir.';

  @override
  String get reservationDate => 'Date';

  @override
  String get reservationStart => 'Début';

  @override
  String get reservationEnd => 'Fin';

  @override
  String get reservationCancel => 'Annuler la réservation';

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
  String get reservationAwaitingConfirmation =>
      'En attente de confirmation du lieu';

  @override
  String get reservationAwaitingTable =>
      'Confirmée. Le lieu assignera une table.';

  @override
  String get reservationSoon => 'Bientôt';

  @override
  String get reservationHolding => 'En attente de confirmation du lieu';

  @override
  String get reservationHeldOrder =>
      'Cette table est réservée jusqu\'à ce que le lieu confirme l\'arrivée.';

  @override
  String get reservationWindow => 'Choisissez une heure de début plus tard.';

  @override
  String get errorPackFeatureReservations =>
      'Ce pack n\'inclut pas les réservations.';

  @override
  String get errorPackLimitReservations =>
      'Ce pack a atteint sa limite de réservations pour la journée.';

  @override
  String get errorOrderReservationHeld =>
      'Cette table est réservée jusqu\'à confirmation de l\'arrivée.';

  @override
  String get errorCustomerOrderingDisabled =>
      'Ce lieu a désactivé les commandes.';

  @override
  String get errorReservationsDisabled =>
      'Ce lieu a désactivé les réservations.';

  @override
  String get errorReservationOverlap =>
      'Une table est déjà réservée à cette heure.';

  @override
  String get errorReservationNotFound => 'Aucune réservation ne correspond.';

  @override
  String get errorPackPaidActive => 'Ce lieu a déjà un pack payant.';

  @override
  String get orderingUnavailable =>
      'Le pack de ce lieu n\'inclut pas la commande dans l\'application. Vous pouvez consulter la carte.';

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
  String get venueOverview => 'Aperçu';

  @override
  String get venueScan => 'Scanner';

  @override
  String get venueProfile => 'Profil';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsReady => 'Rien de nouveau pour le moment.';

  @override
  String get notificationThisVenue => 'Ce lieu';

  @override
  String get notificationThisMonth => 'Ce mois-ci';

  @override
  String get notificationUnreadOnly => 'Non lues';

  @override
  String get notificationMarkAllRead => 'Tout marquer comme lu';

  @override
  String notificationLineStatus(String article, String status) {
    return '$article est maintenant $status';
  }

  @override
  String notificationLineCancelled(String article, String reason) {
    return '$article a été annulé. $reason';
  }

  @override
  String notificationOrderStatus(int ref, String status) {
    return 'La commande $ref est maintenant $status';
  }

  @override
  String notificationOrderCancelled(int ref, String reason) {
    return 'La commande $ref a été annulée. $reason';
  }

  @override
  String get notificationReservationAccepted =>
      'Votre réservation a été acceptée';

  @override
  String get notificationReservationCancelled =>
      'Votre réservation a été annulée';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileReady => 'Votre profil est prêt.';

  @override
  String get reserveNow => 'Réserver maintenant';

  @override
  String get ordersThisVenue => 'Ce lieu';

  @override
  String get emptyVenueOrders =>
      'Aucune commande dans ce lieu sur cette période.';
}
