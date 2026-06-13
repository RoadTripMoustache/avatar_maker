import "package:avatar_maker/src/core/enums/effect_type.dart";
import "package:avatar_maker/src/core/models/cosmetic_property_item.dart";
import "package:avatar_maker/src/customizer/widgets/cosmetic_effect_painter.dart";
import "package:avatar_maker/src/customizer/widgets/cosmetic_effect_widget.dart";
import "package:flutter/material.dart";

/// A cosmetic effect item with animated rendering support.
///
/// Supports both built-in effects (via [effectType]) and custom effects
/// (via [customBuilder]). When [customBuilder] is provided, it takes
/// precedence over [effectType].
class EffectCosmeticItem extends CosmeticPropertyItem {
  @override
  final String cosmeticId;

  @override
  final String label;

  @override
  final String category = "effect";

  @override
  final String tier;

  @override
  final int cost;

  @override
  final bool locked;

  /// Type of the built-in effect.
  final EffectType effectType;

  /// Colors used by the effect.
  final List<Color> colors;

  /// Optional custom effect builder for advanced animations.
  /// Use this when built-in effects are insufficient.
  ///
  /// The builder receives:
  /// - [context]: BuildContext
  /// - [size]: Available size for the effect
  /// - [colors]: Effect colors
  ///
  /// Example:
  /// ```dart
  /// customBuilder: (context, size, colors) {
  ///   return CustomPaint(
  ///     painter: MyCustomEffectPainter(),
  ///     size: Size(size, size),
  ///   );
  /// }
  /// ```
  final Widget Function(
    BuildContext context,
    double size,
    List<Color> colors,
  )? customBuilder;

  EffectCosmeticItem({
    required this.cosmeticId,
    required this.label,
    required this.tier,
    required this.cost,
    required this.effectType,
    this.locked = false,
    this.colors = const [],
    this.customBuilder,
  });

  @override
  Widget buildWidget(BuildContext context, double size) {
    if (customBuilder != null) {
      return customBuilder!(context, size, colors);
    }
    return CosmeticEffectWidget(
      effectType: effectType,
      colors: colors,
      size: size,
    );
  }

  @override
  Widget buildThumbnail(BuildContext context, double size) {
    if (customBuilder != null) {
      return customBuilder!(context, size, colors);
    }
    final displayColors = colors.isEmpty
        ? <Color>[Colors.white]
        : colors
            .map((c) => c.computeLuminance() > 0.7 ? Colors.black87 : c)
            .toList();
    final borderColor =
        displayColors.isNotEmpty ? displayColors.first : Colors.black87;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.3),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.5),
          width: 1.2,
        ),
      ),
      child: CustomPaint(
        painter: EffectThumbnailPainter(
          effectType: effectType,
          colors: displayColors,
        ),
      ),
    );
  }
}

class EffectCosmeticItemWithColor extends StatelessWidget {
  final EffectCosmeticItem effect;
  final Color color;
  final double size;

  const EffectCosmeticItemWithColor({
    Key? key,
    required this.effect,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CosmeticEffectWidget(
      effectType: effect.effectType,
      colors: [color],
      size: size,
    );
  }
}
