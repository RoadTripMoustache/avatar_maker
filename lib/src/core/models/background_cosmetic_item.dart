import "package:avatar_maker/src/core/models/cosmetic_property_item.dart";
import "package:flutter/material.dart";

/// A cosmetic background item with gradient-based rendering.
class BackgroundCosmeticItem extends CosmeticPropertyItem {
  @override
  final String cosmeticId;

  @override
  final String label;

  @override
  final String category = "background";

  @override
  final String tier;

  @override
  final int cost;

  @override
  final bool locked;

  /// Gradient colors for the background.
  final List<Color> colors;

  /// Opacity of the background (0.0 - 1.0).
  final double opacity;

  BackgroundCosmeticItem({
    required this.cosmeticId,
    required this.label,
    required this.tier,
    required this.cost,
    this.locked = false,
    this.colors = const [],
    this.opacity = 1.0,
  });

  @override
  Widget buildWidget(BuildContext context, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: colors.length >= 2
            ? LinearGradient(
                colors:
                    colors.map((c) => c.withValues(alpha: opacity)).toList(),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : colors.isNotEmpty
                ? RadialGradient(
                    colors: [colors.first.withValues(alpha: opacity)],
                  )
                : null,
      ),
    );
  }

  @override
  Widget buildThumbnail(BuildContext context, double size) {
    return buildWidget(context, size);
  }
}
