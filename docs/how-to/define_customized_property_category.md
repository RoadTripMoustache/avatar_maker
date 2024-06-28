# How to customize property category ?

As a lot of things in Avatar Maker, we want to make it customizable as much as possible, and one of this options is to make property categories and theirs properties customizable too !

## How to do it ?
1. Create an instance of `CustomizedPropertyCategory`
2. Set the id of this instance with the id of the category you want to update *(Must be a value from the `PropertyCategoryIds` enumeration)*
3. Update the values you want
4. Repeat it for each categories you want to customize
5. Give the list of your `CustomizedPropertyCategory` to the `AvatarMakerCustomizer` widget

And that's it ! As simple as that !

## What is customizable ?
Except the id : Everything. 

But let's have a deep dive on each parameter and the specificities they can have.

### Name
This parameter is the name of the category you want to display instead of our locale default value.

> **If you override this value and your application supports multiple language, you will be responsible to update the name if the selected language change.**

## Icon file
The path of the icon displayed in the [CustomizerBottomNavbar] to quickly select the category.

## Properties
These properties are working with [PropertyItem] instances which are key-value pairs. 

If you define properties in a category, it will override the default list. So if you want to add properties to a list, be sure to retrieve the current list from the matching enumeration before !

> #### Note for hairs, facial hairs and outfits
> 
> These kind of assets can change color automatically with the related color selected. But to be sure the color update happens, be sure to set the correct [placeholder](../../lib/src/core/enums/placeholders.dart) in your svg value!

## To Display
It's a boolean flag to know if you want a category to be displayed in the [AvatarMakerCustomizer], but **it won't automatically hide the element on the avatar**.

To do so, you must define a default value with an empty svg or a transparent color.

## Default value
Define the default value of a category, and is the value applied to an avatar is the category isn't displayed.

Also the default value must be a value available in the properties list.