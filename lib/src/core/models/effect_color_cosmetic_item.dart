import "package:avatar_maker/src/core/models/cosmetic_property_item.dart";
import "package:flutter/material.dart";

/// A cosmetic effect color item with visual preview support.
///
/// This allows users to select the color of their effect separately from
/// the effect type.
class EffectColorCosmeticItem extends CosmeticPropertyItem {
  @override
  final String cosmeticId;

  @override
  final String label;

  @override
  final String category = "effect_color";

  @override
  final String tier;

  @override
  final int cost;

  @override
  final bool locked;

  /// The color value for this effect color item.
  final Color color;

  EffectColorCosmeticItem({
    required this.cosmeticId,
    required this.label,
    required this.tier,
    required this.cost,
    required this.color,
    this.locked = false,
  });

  @override
  Widget buildWidget(BuildContext context, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.95),
            color.withValues(alpha: 0.55),
            color.withValues(alpha: 0.15),
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
    );
  }

  @override
  Widget buildThumbnail(BuildContext context, double size) {
    return buildWidget(context, size);
  }
}
