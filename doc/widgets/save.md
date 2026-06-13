# AvatarMakerSaveWidget

![1608827561239](https://user-images.githubusercontent.com/37346450/154008545-8325af7b-58a2-4419-8544-929ffbdb99ff.jpg)

Renders a save button by default OR can be used as an [InkWell] wrapper for the [child] widget.

Additional callbacks may be triggered by passing a Function to [onTap].

## Preview protection

When a temporary preview is active, the save button is visually disabled and ignores taps. This prevents users from saving a previewed avatar by accident.

`AvatarMakerController.saveAvatarSVG()` also clears temporary previews before persisting, so direct controller calls cannot save preview-only selections.

Temporary previews never modify `selectedOptions`, JSON exports, or persistent storage.

## Parameters
- [theme] : AvatarMakerThemeData - Pass in your `theme` to customize the appearance of the default save button.
- [onTap] : Function? - Additional callbacks to be triggered on tapping the widget after the save operation is executed.
- [child] : Widget? - A widget to render as the child of a [InkWell]. If [null], then a default save button is shown to the user.
- [splashFactory] : InteractiveInkFeatureFactory? - Defines the appearance of the splash.
- [splashColor] : Color? - The splash color of the ink response.
- [radius] : double? - The radius of the ink splash.
