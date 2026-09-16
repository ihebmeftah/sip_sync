import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';

/// Client-side checks that match account and building rules on the server.
abstract final class FormValidators {
  static String? requiredName(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationRequired;
    }
    return null;
  }

  static String? email(AppLocalizations l10n, String? value) {
    final text = value?.trim() ?? '';
    if (!text.contains('@') || text.length < 5) {
      return l10n.validationEmail;
    }
    return null;
  }

  static String? password(AppLocalizations l10n, String? value) {
    final text = value ?? '';
    if (text.trim() != text || text.length < 8) {
      return l10n.validationPassword;
    }
    return null;
  }

  static String? loginIdentifier(AppLocalizations l10n, String? value) {
    final text = value?.trim() ?? '';
    if (text.contains('@')) {
      return email(l10n, text);
    }
    if (text.length < 3) {
      return l10n.validationLoginIdentifier;
    }
    return null;
  }

  static String? phone(AppLocalizations l10n, String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8) {
      return l10n.validationPhone;
    }
    return null;
  }

  static String? venueName(AppLocalizations l10n, String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty || text.length > 80) {
      return l10n.validationVenueName;
    }
    return null;
  }

  static String? venueType(AppLocalizations l10n, String? value) {
    final text = (value ?? '').trim().toLowerCase();
    if (text.length < 2 ||
        text.length > 40 ||
        !RegExp(r'^[a-z0-9][a-z0-9 \-]*$').hasMatch(text)) {
      return l10n.validationVenueType;
    }
    return null;
  }

  static String? address(AppLocalizations l10n, String? value) {
    final text = value?.trim() ?? '';
    if (text.length < 3 || text.length > 200) {
      return l10n.validationAddress;
    }
    return null;
  }

  static String? latitude(AppLocalizations l10n, String? value) {
    final parsed = double.tryParse((value ?? '').trim());
    if (parsed == null || parsed < -90 || parsed > 90) {
      return l10n.validationLatitude;
    }
    return null;
  }

  static String? longitude(AppLocalizations l10n, String? value) {
    final parsed = double.tryParse((value ?? '').trim());
    if (parsed == null || parsed < -180 || parsed > 180) {
      return l10n.validationLongitude;
    }
    return null;
  }

  static String? currency(AppLocalizations l10n, String? value) {
    final text = (value ?? '').trim().toUpperCase();
    if (!RegExp(r'^[A-Z]{3}$').hasMatch(text)) {
      return l10n.validationCurrency;
    }
    return null;
  }
}

String formatMinutes(int minutes) {
  final clamped = minutes.clamp(0, 1439);
  final hour = clamped ~/ 60;
  final minute = clamped % 60;
  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

int minutesFromTimeOfDay(TimeOfDay time) => time.hour * 60 + time.minute;
