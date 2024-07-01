# AvatarMakerRandomWidget

![AvatarMakerRandomWidget](https://github.com/RoadTripMoustache/avatar_maker/assets/36586573/5a20d383-2287-417c-975f-99373fe59b70)

Renders a randomizer button by default OR can be used as an [InkWell] wrapper for the [child] widget. It changes the avatar with random properties for every displayed property categories.

Additional callbacks may be triggered by passing a Function to [onTap].

## Parameters
- [theme] : AvatarMakerThemeData - Pass in your `theme` to customize the appearance of the default randomizer button.
- [onTap] : Function? - Additional callbacks to be triggered on tapping the widget after the randomize operation is executed.
- [child] : Widget? - A widget to render as the child of a [InkWell]. If [null], then a default randomizer button is shown to the user.
- [splashFactory] : InteractiveInkFeatureFactory? - Defines the appearance of the splash.
- [splashColor] : Color? - The splash color of the ink response.
- [radius] : double? - The radius of the ink splash.