import "package:avatar_maker/l10n/app_localizations.dart";
import "package:avatar_maker/src/core/models/property_item.dart";
import "package:flutter/material.dart";

/// Represents a cosmetic item with widget-based rendering support.
///
/// Unlike standard [PropertyItem]s that use SVG strings, cosmetic items
/// use [buildWidget] and [buildThumbnail] for rendering. This allows
/// for gradient backgrounds, animated effects, and other widget-based
/// visual elements.
///
/// Cosmetic items extend [PropertyItem] and can be used with the
/// [AvatarMakerController.selectCosmetic] method.
abstract class CosmeticPropertyItem extends PropertyItem {
  /// Unique identifier for the cosmetic item (catalog key).
  String get cosmeticId;

  /// Category of the cosmetic: 'background' or 'effect'.
  String get category;

  /// Tier of the cosmetic: 'basic', 'illustrated', or 'premium'.
  String get tier;

  /// Purchase cost in gold.
  int get cost;

  /// Whether the cosmetic is locked (not yet owned).
  bool get locked;

  @override
  String get id => "Cosmetic/$category/$cosmeticId";

  @override
  String get value => "";

  /// Build the full-size widget for this cosmetic.
  Widget buildWidget(BuildContext context, double size);

  /// Build the thumbnail widget for grid display.
  Widget buildThumbnail(BuildContext context, double size);

  /// Returns a localized label using the given [l10n].
  /// Falls back to [label] if no localization is available.
  String localizedLabel(AppLocalizations l10n) => label;
}
