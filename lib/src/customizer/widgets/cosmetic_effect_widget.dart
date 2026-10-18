import "package:avatar_maker/src/core/enums/effect_type.dart";
import "package:avatar_maker/src/customizer/widgets/cosmetic_effect_painter.dart";
import "package:flutter/foundation.dart";
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

  /// Painter for the animated particle layer.
  ///
  /// It is created *once* and subscribes to [_controller] itself, so an
  /// animation tick only invalidates this layer's paint. Previously an
  /// `AnimatedBuilder` rebuilt the subtree (and allocated a fresh painter) on
  /// every single frame.
  late CosmeticEffectPainter _particlePainter;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
    _particlePainter = _createParticlePainter();
  }

  CosmeticEffectPainter _createParticlePainter() {
    return CosmeticEffectPainter(
      effectType: widget.effectType,
      phase: 0,
      colors: widget.colors,
      animation: _controller,
    );
  }

  @override
  void didUpdateWidget(CosmeticEffectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
    if (oldWidget.effectType != widget.effectType ||
        !listEquals(oldWidget.colors, widget.colors)) {
      _particlePainter = _createParticlePainter();
    }
  }

  @override
  Widget build(BuildContext context) {
    // The effect is split into two independently composited layers:
    //
    //  1. The *static* outer glow (large `MaskFilter.blur` rings). It does not
    //     depend on the animation phase, so it is painted once into its own
    //     [RepaintBoundary] and reused for every frame.
    //  2. The animated particles, isolated in their own [RepaintBoundary] so
    //     their per-frame repaint cannot bubble up and repaint the rest of the
    //     screen (avatar SVG, home screen content, ...).
    //
    // Sizing mirrors the previous single `CustomPaint(size: ...)`: under tight
    // constraints the box fills them, under loose constraints it is the
    // requested effect size.
    return SizedBox.fromSize(
      size: Size(widget.size, widget.size),
      child: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              painter: CosmeticEffectGlowPainter(
                effectType: widget.effectType,
                colors: widget.colors,
              ),
            ),
          ),
          RepaintBoundary(
            // The painter listens to the controller directly: an animation tick
            // repaints this layer without rebuilding any widget.
            child: CustomPaint(
              willChange: true,
              painter: _particlePainter,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
