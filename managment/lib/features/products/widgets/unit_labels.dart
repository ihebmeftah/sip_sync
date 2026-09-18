import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../l10n/generated/app_localizations.dart';

/// Localized label for a stock [UnitsType].
String unitTypeLabel(AppLocalizations l10n, UnitsType unit) {
  return switch (unit) {
    UnitsType.gram => l10n.unitGram,
    UnitsType.kilogram => l10n.unitKilogram,
    UnitsType.milliliter => l10n.unitMilliliter,
    UnitsType.centiliter => l10n.unitCentiliter,
    UnitsType.liter => l10n.unitLiter,
    UnitsType.piece => l10n.unitPiece,
    UnitsType.bottle => l10n.unitBottle,
    UnitsType.can => l10n.unitCan,
    UnitsType.pack => l10n.unitPack,
    UnitsType.box => l10n.unitBox,
    UnitsType.bunch => l10n.unitBunch,
    UnitsType.teaspoon => l10n.unitTeaspoon,
    UnitsType.tablespoon => l10n.unitTablespoon,
    UnitsType.cup => l10n.unitCup,
  };
}

/// Short unit abbreviation for stock amounts in lists.
String unitTypeAbbrev(AppLocalizations l10n, UnitsType unit) {
  return switch (unit) {
    UnitsType.gram => l10n.unitAbbrevGram,
    UnitsType.kilogram => l10n.unitAbbrevKilogram,
    UnitsType.milliliter => l10n.unitAbbrevMilliliter,
    UnitsType.centiliter => l10n.unitAbbrevCentiliter,
    UnitsType.liter => l10n.unitAbbrevLiter,
    UnitsType.piece => l10n.unitAbbrevPiece,
    UnitsType.bottle => l10n.unitAbbrevBottle,
    UnitsType.can => l10n.unitAbbrevCan,
    UnitsType.pack => l10n.unitAbbrevPack,
    UnitsType.box => l10n.unitAbbrevBox,
    UnitsType.bunch => l10n.unitAbbrevBunch,
    UnitsType.teaspoon => l10n.unitAbbrevTeaspoon,
    UnitsType.tablespoon => l10n.unitAbbrevTablespoon,
    UnitsType.cup => l10n.unitAbbrevCup,
  };
}
