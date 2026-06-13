# AvatarMakerCustomizer

![1608827561239](https://user-images.githubusercontent.com/37346450/154008536-a687828c-dc9d-4a62-aa11-b800d4fb7763.jpg)

This widget provides the user with a UI for customizing their Avatar_Maker

## Parameters
- [theme] : AvatarMakerThemeData - Configuration for the overall visual theme for this widget and the components within it.
- [autosave] : bool - Will save the selection automatically everytime the user selects something when set to `true`. If set to `false` you may want to implement a [AvatarMakerSaveWidget] in your app to let users save their selection manually. *Default : `false`*
- [customizedPropertyCategories] : List<CustomizedPropertyCategory>? - List of all the customized property categories you want to use instead of the default ones.
- [scaffoldHeight] : double? - To define the height of the component.
- [scaffoldWidth] : double? - To define the width of the component.
- [isItemLocked] : `bool Function(PropertyCategoryIds categoryId, String itemId)?` - Optional callback used to determine whether an item should be locked.
- [lockWidget] : `Widget?` - Optional widget displayed over locked items.
- [onTapLockedItem] : `void Function(PropertyCategoryIds categoryId, String itemId)?` - Optional callback triggered when a locked item is tapped.
- [onChange] : `Function(String avatarSvg)?` - Called after an unlocked item is selected.

## Locked items and previews

Use [isItemLocked] for level, premium, ownership, or purchase checks. Use [onTapLockedItem] to show an unlock dialog, paywall, or temporary preview.

Temporary previews can be applied with `controller.previewOption(item, category)` or `controller.previewCosmetic(cosmeticItem)`. They render on the avatar but do not modify `selectedOptions`, JSON exports, or persistent storage.

## Notes
- It is advised that a [AvatarMakerCircleAvatar] also be present in the same page to show the user a preview of the changes being made.
- By default the [autosave] is set to false.
- When the [AvatarMakerCustomizer] is disposed, the controller is called to restore the avatar to the last saved state.