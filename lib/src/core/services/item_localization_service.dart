import "package:avatar_maker/l10n/app_localizations.dart";
import "package:avatar_maker/src/core/enums/property_items/outfit_types.dart";
import "package:avatar_maker/src/core/enums/property_items/skin_colors.dart";
import "package:avatar_maker/src/core/models/cosmetic_property_item.dart";
import "package:avatar_maker/src/core/models/property_item.dart";

extension PropertyItemLocalization on PropertyItem {
  /// Returns a localized label using the given [l10n].
  /// Falls back to [label] if no localization is available.
  String localizedLabel(AppLocalizations l10n) {
    if (this is CosmeticPropertyItem) {
      return (this as CosmeticPropertyItem).localizedLabel(l10n);
    }
    if (this is SkinColors) {
      return _localizeSkinColor(this as SkinColors, l10n);
    }
    if (this is OutfitTypes) {
      return _localizeOutfitType(this as OutfitTypes, l10n);
    }
    return label;
  }

  String _localizeSkinColor(SkinColors color, AppLocalizations l10n) {
    switch (color) {
      case SkinColors.Tanned:
        return l10n.item_skin_tanned;
      case SkinColors.Yellow:
        return l10n.item_skin_yellow;
      case SkinColors.White:
        return l10n.item_skin_white;
      case SkinColors.Peach:
        return l10n.item_skin_peach;
      case SkinColors.Brown:
        return l10n.item_skin_brown;
      case SkinColors.DarkBrown:
        return l10n.item_skin_dark_brown;
      case SkinColors.Black:
        return l10n.item_skin_black;
    }
  }

  String _localizeOutfitType(OutfitTypes type, AppLocalizations l10n) {
    switch (type) {
      case OutfitTypes.BlazerTShirt:
        return l10n.item_outfit_blazer_t_shirt;
      case OutfitTypes.BlazerSweater:
        return l10n.item_outfit_blazer_sweater;
      case OutfitTypes.CollarSweater:
        return l10n.item_outfit_collar_sweater;
      case OutfitTypes.GraphicShirt:
        return l10n.item_outfit_graphic_shirt;
      case OutfitTypes.Hoodie:
        return l10n.item_outfit_hoodie;
      case OutfitTypes.Overall:
        return l10n.item_outfit_overall;
      case OutfitTypes.ShirtCrewNeck:
        return l10n.item_outfit_shirt_crew_neck;
      case OutfitTypes.ShirtScoopNeck:
        return l10n.item_outfit_shirt_scoop_neck;
      case OutfitTypes.ShirtVNeck:
        return l10n.item_outfit_shirt_v_neck;
    }
  }
}
