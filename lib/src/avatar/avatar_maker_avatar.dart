import "package:avatar_maker/src/core/controllers/avatar_maker_controller.dart";
import "package:avatar_maker/src/core/models/customized_property_category.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";

/// This widget renders the avatar of the user on screen.
///
/// Parameters :
/// - [radius] : double - Radius of the circle which contains the avatar.
/// Default : 75.0
/// - [backgroundColor] : Color? - Background color to define for the circle.
/// - [customizedPropertyCategories] : List<CustomizedPropertyCategory>? -
/// List of the customized property categories you want to use. If a property
/// category is not override, it will use the default one instead.
/// - [locale] : Locale? - Locale to use. If nothing is defined, the default
/// language will be used.
class AvatarMakerAvatar extends StatelessWidget {
  final double radius;
  final Color? backgroundColor;
  final List<CustomizedPropertyCategory>? customizedPropertyCategories;
  final Locale? locale;

  AvatarMakerAvatar({
    Key? key,
    this.radius = 75.0,
    this.backgroundColor,
    this.customizedPropertyCategories,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius, backgroundColor: backgroundColor, child: buildGetX());
  }

  /// Create the svg picture encapsulated in a [GetX] to manage dynamic updates
  /// with the [AvatarMakerController]
  GetX<AvatarMakerController> buildGetX() {
    return GetX<AvatarMakerController>(
        init: AvatarMakerController(
          customizedPropertyCategories: this.customizedPropertyCategories,
          locale: this.locale,
        ),
        autoRemove: false,
        builder: (controller) {
          /// Returns an activity indicator if the initialization of the
          /// controller isn't fully done.
          if (controller.displayedAvatarSVG.value.isEmpty) {
            return CupertinoActivityIndicator();
          }
          return SvgPicture.string(
            controller.drawAvatarSVG(),
            height: radius * 1.6,
            semanticsLabel: "Your avatar",
            placeholderBuilder: (context) => Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        });
  }
}
