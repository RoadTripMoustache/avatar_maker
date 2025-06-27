import "package:avatar_maker/src/core/controllers/controllers.dart";
import "package:avatar_maker/src/core/models/customized_property_category.dart";
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
/// - [locale] : Locale? - Locale to use. If nothing is defined, the default
/// language will be used.
class AvatarMakerAvatar extends StatelessWidget {
  final double radius;
  final Color? backgroundColor;
  final List<CustomizedPropertyCategory>? customizedPropertyCategories;
  final AvatarMakerController? controller;
  final Widget? progressIndicator;

  AvatarMakerAvatar(
      {Key? key,
      this.radius = 75.0,
      this.backgroundColor,
      this.customizedPropertyCategories,
      this.progressIndicator,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarController = controller ??
        Provider.of<AvatarMakerController?>(context, listen: true) ??
        PersistentAvatarMakerController(customizedPropertyCategories: []);
    final loader = progressIndicator ?? CircularProgressIndicator.adaptive();

    return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: ListenableBuilder(
          listenable: avatarController,
          builder: (context, child) {

            /// Returns an activity indicator if the initialization of the
            /// controller isn't fully done.
            if (avatarController.displayedAvatarSVG.isEmpty) {
              return loader;
            }
            return SvgPicture.string(
              avatarController.drawAvatarSVG(),
              height: radius * 1.6,
              semanticsLabel: "Your avatar",
              placeholderBuilder: (context) => Center(
                child: loader,
              ),
            );
          },
        ));
  }
}
