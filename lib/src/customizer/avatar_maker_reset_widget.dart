import "package:flutter/material.dart";
import "package:avatar_maker/src/core/controllers/avatar_maker_controller.dart";
import "package:avatar_maker/src/core/models/theme_data.dart";
import "package:provider/provider.dart";

/// Renders a reset button by default OR can be used as a [InkWell]
/// wrapper for the [child] widget.
/// It resets the avatar to the last avatar saved state.
///
/// Additional callbacks may be triggered by passing a
/// Function to [onTap].
class AvatarMakerResetWidget extends StatelessWidget {
  /// Pass in your `theme` to customize the appearance of the default
  /// reset button.
  final AvatarMakerThemeData theme;

  /// Additional callbacks to be triggered on tapping the widget
  /// after the reset operation is executed.
  /// *******
  /// Example: \
  /// You may pass a function that triggers a snackbar saying "Reset done!" on
  /// the screen.
  final VoidCallback? onTap;

  /// A widget to render as the child of a [InkWell].
  ///
  /// If [null], then a default reset button is shown to the user.
  final Widget? child;

  /// The [AvatarMakerController] to use for resetting the avatar.
  ///
  /// If not provided, it will be fetched from Provider.
  final AvatarMakerController? controller;

  /// Defines the appearance of the splash.
  final InteractiveInkFeatureFactory? splashFactory;

  /// The splash color of the ink response.
  final Color? splashColor;

  final double? radius;

  AvatarMakerResetWidget({
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
        avatarMakerController.restoreState();
        if (onTap != null) onTap!();
      },
      splashFactory: splashFactory,
      radius: radius,
      splashColor: splashColor,
      child: child == null
          ? Icon(
              Icons.replay,
              color: theme.iconColor,
            )
          : child,
    );
  }
}