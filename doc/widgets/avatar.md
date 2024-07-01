# AvatarMakerAvatar

![1608830483994](https://user-images.githubusercontent.com/37346450/103071632-009ec100-45ea-11eb-97c4-96c9ec67e204.gif)

This widget renders the avatar of the user on screen.

## Parameters
- [radius] : double - Radius of the circle which contains the avatar.
Default : 75.0
- [backgroundColor] : Color? - Background color to define for the circle.
- [customizedPropertyCategories] : List<CustomizedPropertyCategory>? -
List of the customized property categories you want to use. If a property
category is not override, it will use the default one instead.
- [locale] : Locale? - Locale to use. If nothing is defined, the default
language will be used.

## Note
- The locale is defined here as this component initialize the [AvatarMakerController] which is responsible to define which title must be display.