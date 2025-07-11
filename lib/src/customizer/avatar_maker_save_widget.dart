import "package:flutter/material.dart";
import "package:avatar_maker/src/core/models/theme_data.dart";
import "package:provider/provider.dart";
import "package:avatar_maker/src/core/controllers/controllers.dart";

/// Renders a save button by default OR can be used as a [InkWell]
/// wrapper for the [child] widget.
///
/// Additional callbacks may be triggered by passing a
/// Function to [onTap].
class AvatarMakerSaveWidget extends StatelessWidget {
  /// Pass in your `theme` to customize the appearance of the default
  /// save button.
  final AvatarMakerThemeData theme;

  /// Additional callbacks to be triggered on tapping the widget
  /// after the save operation is executed.
  /// [avatarSvg] is the SVG string of the avatar that was saved.
  /// *******
  /// Example: \
  /// You may pass a function that triggers a snackbar saying "Saved!" on
  /// the screen.
  final Function(String avatarSvg)? onTap;

  /// A widget to render as the child of a [InkWell].
  ///
  /// If [null], then a default save button is shown to the user.
  final Widget? child;

  /// The [AvatarMakerController] to use for saving the avatar.
  ///
  /// If not provided, it will be fetched from Provider or a new controller will be created.
  final AvatarMakerController? controller;

  /// Defines the appearance of the splash.
  final InteractiveInkFeatureFactory? splashFactory;

  /// The splash color of the ink response.
  final Color? splashColor;

  final double? radius;

  AvatarMakerSaveWidget({
    Key? key,
    AvatarMakerThemeData? theme,
    this.onTap,
    this.child,
    this.controller,
    this.splashFactory,
    this.splashColor,
    this.radius,
  })  : theme = theme ?? AvatarMakerThemeData.defaultTheme,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the provided controller or fetch it from Provider if not provided
    final avatarController = controller ??
        Provider.of<AvatarMakerController?>(context, listen: false) ??
        PersistentAvatarMakerController(customizedPropertyCategories: []);

    return InkWell(
      onTap: () async {
        await avatarController.saveAvatarSVG();
        if (onTap != null) onTap!(avatarController.drawAvatarSVG());
      },
      splashFactory: splashFactory,
      radius: radius,
      splashColor: splashColor,
      child: child == null
          ? Icon(
              Icons.save,
              color: theme.iconColor,
            )
          : child,
    );
  }
}
