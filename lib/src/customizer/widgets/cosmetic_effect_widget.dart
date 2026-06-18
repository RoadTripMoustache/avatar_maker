import "package:avatar_maker/src/core/enums/effect_type.dart";
import "package:avatar_maker/src/customizer/widgets/cosmetic_effect_painter.dart";
import "package:flutter/material.dart";

/// Animated widget for rendering cosmetic effects.
///
/// Uses [AnimationController] and [CustomPainter] to render
/// continuously animated effects like stars, hearts, sparkles, etc.
class CosmeticEffectWidget extends StatefulWidget {
  /// Type of the effect to render.
  final EffectType effectType;

  /// Size of the effect widget.
  final double size;

  /// Colors used by the effect.
  final List<Color> colors;

  /// Duration of one animation cycle.
  final Duration duration;

  const CosmeticEffectWidget({
    Key? key,
    required this.effectType,
    required this.size,
    this.colors = const [],
    this.duration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  State<CosmeticEffectWidget> createState() => _CosmeticEffectWidgetState();
}

class _CosmeticEffectWidgetState extends State<CosmeticEffectWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void didUpdateWidget(CosmeticEffectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: CosmeticEffectPainter(
            effectType: widget.effectType,
            phase: _controller.value,
            colors: widget.colors,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
