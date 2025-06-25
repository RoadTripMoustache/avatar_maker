import "package:avatar_maker/src/core/controllers/controllers.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

/// A provider widget for [AvatarMakerController].
///
/// This widget provides an [AvatarMakerController] to its descendants.
/// If a controller is not provided, it will create a [PersistentAvatarMakerController]
/// by default.
///
/// Usage:
/// ```dart
/// AvatarMakerControllerProvider(
///   controller: myController, // Optional
///   child: MyWidget(),
/// )
/// ```
class AvatarMakerControllerProvider extends StatelessWidget {
  /// The child widget that will have access to the controller.
  final Widget child;

  /// The controller to provide to descendants.
  ///
  /// If not provided, a [PersistentAvatarMakerController] will be created.
  final AvatarMakerController? controller;

  /// Creates a provider for [AvatarMakerController].
  ///
  /// The [child] parameter is required and represents the widget tree
  /// that will have access to the controller.
  ///
  /// The [controller] parameter is optional. If not provided, a
  /// [PersistentAvatarMakerController] will be created.
  const AvatarMakerControllerProvider({
    Key? key,
    required this.child,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AvatarMakerController>(
      create: (context) => controller ?? PersistentAvatarMakerController(),
      child: child,
    );
  }
}
