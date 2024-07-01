# AvatarMakerResetWidget

![AvatarMakerResetWidget](https://github.com/RoadTripMoustache/avatar_maker/assets/36586573/ef052b05-1b23-4f77-8a47-1d08fc734958)

Renders a reset button by default OR can be used as a [InkWell] wrapper for the [child] widget. It resets the avatar to the last avatar saved state.

Additional callbacks may be triggered by passing a Function to [onTap].

## Parameters
- [theme] : AvatarMakerThemeData - Pass in your `theme` to customize the appearance of the default reset button.
- [onTap] : Function? - Additional callbacks to be triggered on tapping the widget after the reset operation is executed.
- [child] : Widget? - A widget to render as the child of a [InkWell]. If [null], then a default reset button is shown to the user.
- [splashFactory] : InteractiveInkFeatureFactory? - Defines the appearance of the splash.
- [splashColor] : Color? - The splash color of the ink response.
- [radius] : double? - The radius of the ink splash.