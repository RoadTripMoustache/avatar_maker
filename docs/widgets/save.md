# AvatarMakerSaveWidget

Renders a save button by default OR can be used as a [InkWell] wrapper for the [child] widget.

Additional callbacks may be triggered by passing a Function to [onTap].

## Parameters
- [theme] : AvatarMakerThemeData - Pass in your `theme` to customize the appearance of the default save button.
- [onTap] : Function? - Additional callbacks to be triggered on tapping the widget after the save operation is executed.
- [child] : Widget? - A widget to render as the child of a [InkWell]. If [null], then a default save button is shown to the user.
- [splashFactory] : InteractiveInkFeatureFactory? - Defines the appearance of the splash.
- [splashColor] : Color? - The splash color of the ink response.
- [radius] : double? - The radius of the ink splash.