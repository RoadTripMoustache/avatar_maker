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
  final Color? backgroundColor;
  final List<CustomizedPropertyCategory>? customizedPropertyCategories;
  final AvatarMakerController? controller;
  final Widget? progressIndicator;

  /// When `false`, the avatar ignores any active temporary preview on the
  /// controller and always renders the saved selection. Defaults to `true`
  /// for backward compatibility.
  final bool usePreview;

  AvatarMakerAvatar(
      {Key? key,
      this.radius = 75.0,
      this.backgroundColor,
      this.customizedPropertyCategories,
      this.progressIndicator,
      this.controller,
      this.usePreview = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarController = controller ??
        Provider.of<AvatarMakerController?>(context, listen: true) ??
        PersistentAvatarMakerController(customizedPropertyCategories: []);
    final loader = progressIndicator ?? CircularProgressIndicator.adaptive();

    return ListenableBuilder(
      listenable: avatarController,
      builder: (context, child) {
        return buildWithCosmetics(
          context: context,
          avatarController: avatarController,
          radius: radius,
          backgroundColor: backgroundColor,
          loader: loader,
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
    Color? backgroundColor,
    Widget? loader,
    CosmeticPropertyItem? background,
    CosmeticPropertyItem? effect,
    CosmeticPropertyItem? effectColor,
    bool usePreview = true,
  }) {
    final effectiveLoader = loader ?? CircularProgressIndicator.adaptive();

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Layer 1: Cosmetic background
            if (background != null)
              Positioned.fill(
                child: ClipOval(
                  child: background.buildWidget(context, radius * 2),
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
                          size: radius * 2,
                        )
                      : effect.buildWidget(context, radius * 2),
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
                        selectedOptionsOverride:
                            avatarController.selectedOptions,
                      ),
                height: radius * 1.6,
                semanticsLabel: "Your avatar",
                placeholderBuilder: (context) => Center(
                  child: effectiveLoader,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
