# AvatarMakerCustomizer

This widget provides the user with a UI for customizing their Avatar_Maker

## Parameters
- [theme] : AvatarMakerThemeData - Configuration for the overall visual theme for this widget and the components within it.
- [autosave] : bool - Will save the selection automatically everytime the user selects something when set to `true`. If set to `false` you may want to implement a [AvatarMakerSaveWidget] in your app to let users save their selection manually. *Default : `false`*
- [customizedPropertyCategories] : List<CustomizedPropertyCategory>? - List of all the customized property categories you want to use instead of the default ones.
- [scaffoldHeight] : double? - To define the height of the component.
- [scaffoldWidth] : double? - To define the width of the component.

## Notes
- It is advised that a [AvatarMakerCircleAvatar] also be present in the same page to show the user a preview of the changes being made.
- By default the [autosave] is set to false.
- When the [AvatarMakerCustomizer] is disposed, the controller is called to restore the avatar to the last saved state.