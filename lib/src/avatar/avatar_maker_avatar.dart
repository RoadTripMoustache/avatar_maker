import "package:avatar_maker/src/core/controllers/controllers.dart";
import "package:avatar_maker/src/core/models/cosmetic_property_item.dart";
import "package:avatar_maker/src/core/models/customized_property_category.dart";
import "package:avatar_maker/src/core/models/effect_color_cosmetic_item.dart";
import "package:avatar_maker/src/core/models/effect_cosmetic_item.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:provider/provider.dart";

/// This widget renders the avatar of the user on screen.
///
/// Parameters :
/// - [radius] : double - Radius of the circle which contains the avatar.
/// Default : 75.0
/// - [width] : double? - Overrides the width of the circle. If not set,
/// `radius * 2` is used (same as before).
/// - [height] : double? - Overrides the height of the circle. If not set,
/// `radius * 2` is used (same as before).
/// - [svgWidth] : double? - Overrides the width of the rendered SVG avatar
/// itself, independently of the circle size.
/// - [svgHeight] : double? - Overrides the height of the rendered SVG
/// avatar itself. If not set, `radius * 1.6` is used (same as before).
/// - [svgPadding] : double? - Padding applied around the cosmetic/avatar
/// stack, inside the circle. If not set, no padding is applied (same as
/// before).
/// - [border] : BoxBorder? - Border to draw around the circle.
/// - [backgroundColor] : Color? - Background color to define for the circle.
/// - [customizedPropertyCategories] : List<CustomizedPropertyCategory>? -
/// List of the customized property categories you want to use. If a property
/// category is not override, it will use the default one instead.
/// - [usePreview] : bool - Whether the avatar should reflect the controller's
/// temporary preview state (set via `previewOption` or `previewCosmetic`).
/// Defaults to `true`. Set to `false` on avatars that live outside the
/// customizer context (e.g. a home/profile page) so transient previews
/// produced inside the customizer do not leak into them.
class AvatarMakerAvatar extends StatelessWidget {
  final double radius;
  final double? width;
  final double? height;
  final double? svgWidth;
  final double? svgHeight;
  final double? svgPadding;
  final BoxBorder? border;
  final Color? backgroundColor;
  final List<CustomizedPropertyCategory>? customizedPropertyCategories;
  final AvatarMakerController? controller;

  /// When `false`, the avatar ignores any active temporary preview on the
  /// controller and always renders the saved selection. Defaults to `true`
  /// for backward compatibility.
  final bool usePreview;

  AvatarMakerAvatar({
    Key? key,
    this.radius = 75.0,
    this.width,
    this.height,
    this.svgWidth,
    this.svgHeight,
    this.svgPadding,
    this.border,
    this.backgroundColor,
    this.customizedPropertyCategories,
    this.controller,
    this.usePreview = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarController = controller ??
        Provider.of<AvatarMakerController?>(context, listen: true) ??
        PersistentAvatarMakerController(customizedPropertyCategories: []);

    return ListenableBuilder(
      listenable: avatarController,
      builder: (context, child) {
        return buildWithCosmetics(
          context: context,
          avatarController: avatarController,
          radius: radius,
          width: width,
          height: height,
          svgWidth: svgWidth,
          svgHeight: svgHeight,
          svgPadding: svgPadding,
          border: border,
          backgroundColor: backgroundColor,
          background: (usePreview
                  ? avatarController.previewBackgroundCosmetic
                  : null) ??
              avatarController.selectedBackgroundCosmetic,
          effect:
              (usePreview ? avatarController.previewEffectCosmetic : null) ??
                  avatarController.selectedEffectCosmetic,
          effectColor: (usePreview
                  ? avatarController.previewEffectColorCosmetic
                  : null) ??
              avatarController.selectedEffectColorCosmetic,
          usePreview: usePreview,
        );
      },
    );
  }

  /// Build avatar with cosmetic layers (background + avatar + effect).
  static Widget buildWithCosmetics({
    required BuildContext context,
    required AvatarMakerController avatarController,
    required double radius,
    double? width,
    double? height,
    double? svgWidth,
    double? svgHeight,
    double? svgPadding,
    BoxBorder? border,
    Color? backgroundColor,
    CosmeticPropertyItem? background,
    CosmeticPropertyItem? effect,
    CosmeticPropertyItem? effectColor,
    bool usePreview = true,
  }) {
    final effectiveLoader = CircularProgressIndicator.adaptive();

    // Preserve the previous default sizing (radius * 2) when width/height
    // are not explicitly provided.
    final effectiveWidth = width ?? radius * 2;
    final effectiveHeight = height ?? radius * 2;
    // Cosmetic layers (background/effect) are square and clipped to a
    // circle, so they use the smaller of the two dimensions as before.
    final cosmeticSize =
        effectiveWidth < effectiveHeight ? effectiveWidth : effectiveHeight;

    Widget stack = Stack(
      alignment: Alignment.center,
      children: [
        // Layer 1: Cosmetic background
        if (background != null)
          Positioned.fill(
            child: ClipOval(
              child: background.buildWidget(context, cosmeticSize),
            ),
          ),

        // Layer 2: Effect overlay (BEHIND avatar)
        if (effect != null)
          Positioned.fill(
            child: ClipOval(
              child: effectColor is EffectColorCosmeticItem
                  ? EffectCosmeticItemWithColor(
                      effect: effect as EffectCosmeticItem,
                      color: effectColor.color,
                      size: cosmeticSize,
                    )
                  : effect.buildWidget(context, cosmeticSize),
            ),
          ),

        // Layer 3: SVG avatar
        if (avatarController.displayedAvatarSVG.isEmpty)
          effectiveLoader
        else
          SvgPicture.string(
            usePreview
                ? avatarController.displayedAvatarSVG
                : avatarController.drawAvatarSVG(
                    selectedOptionsOverride: avatarController.selectedOptions,
                  ),
            width: svgWidth,
            height: svgHeight ?? radius * 1.6,
            semanticsLabel: "Your avatar",
            placeholderBuilder: (context) => Center(child: effectiveLoader),
          ),
      ],
    );

    if (svgPadding != null) {
      stack = Padding(padding: EdgeInsets.all(svgPadding), child: stack);
    }

    // `CircleAvatar` doesn't support a custom `border`, and it also can't
    // stretch its child to an arbitrary width/height independent of
    // `radius`. When neither `border` nor `width`/`height` overrides are
    // used, we keep the original `CircleAvatar`-based rendering so existing
    // consumers see no visual change at all.
    if (border == null && width == null && height == null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: SizedBox(
          width: effectiveWidth,
          height: effectiveHeight,
          child: stack,
        ),
      );
    }

    return Container(
      width: effectiveWidth,
      height: effectiveHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: border,
      ),
      child: ClipOval(child: stack),
    );
  }
}
