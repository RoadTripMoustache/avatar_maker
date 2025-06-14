import "package:flutter/material.dart";
import "package:avatar_maker/src/core/controllers/avatar_maker_controller.dart";
import "package:avatar_maker/src/core/models/theme_data.dart";
import "package:provider/provider.dart";

/// Renders a randomizer button by default OR can be used as a [InkWell]
/// wrapper for the [child] widget.
///
/// Additional callbacks may be triggered by passing a
/// Function to [onTap].
class AvatarMakerRandomWidget extends StatelessWidget {
  /// Pass in your `theme` to customize the appearance of the default
  /// randomizer button.
  final AvatarMakerThemeData theme;

  /// Additional callbacks to be triggered on tapping the widget
  /// after the randomizer operation is executed.
  /// *******
  /// Example: \
  /// You may pass a function that triggers a snackbar saying "Randomized!" on
  /// the screen.
  final VoidCallback? onTap;

  /// A widget to render as the child of a [InkWell].
  ///
  /// If [null], then a default randomizer button is shown to the user.
  final Widget? child;

  /// The [AvatarMakerController] to use for randomizing the avatar.
  ///
  /// If not provided, it will be fetched from Provider.
  final AvatarMakerController? controller;

  /// Defines the appearance of the splash.
  final InteractiveInkFeatureFactory? splashFactory;

  /// The splash color of the ink response.
  final Color? splashColor;

  final double? radius;

  AvatarMakerRandomWidget({
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
    final avatarMakerController = controller ?? Provider.of<AvatarMakerController>(context, listen: false);

    return InkWell(
      onTap: () async {
        avatarMakerController.randomizedSelectedOptions();
        onTap?.call();
      },
      splashFactory: splashFactory,
      radius: radius,
      splashColor: splashColor,
      child: child == null
          ? Icon(
              Icons.shuffle,
              color: theme.iconColor,
            )
          : child,
    );
  }
}
