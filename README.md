# Avatar_Maker

![Pub Version](https://img.shields.io/pub/v/avatar_maker) [![Generic badge](https://img.shields.io/badge/demo-LIVE-green.svg)](https://RoadTripMoustache.github.io/avatar_maker/) [![GitHub stars](https://img.shields.io/github/stars/RoadTripMoustache/avatar_maker?style=social)](https://github.com/psk907/fluttermoji/stargazers)

A light-weight and highly customizable SVG graphic set for Flutter, which provides an Avatar,
Customizer and other utility widgets/functions.

## Available widgets

This package provides you three easy-to-use widgets

| Name                                                  | Description                                                                                                                                                                                        | Screenshot                                                                                                                         | 
|-------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| [AvatarMakerAvatar](./docs/widgets/avatar.md)         | Use your avatar anywhere in your Flutter app with a simple customizable widget. Supports material dark theme too.                                                                                  | ![1608830483994](https://user-images.githubusercontent.com/37346450/103071632-009ec100-45ea-11eb-97c4-96c9ec67e204.gif)            |
| [AvatarMakerCustomizer](./docs/widgets/customizer.md) | A comprehensize UI to customize the user's avatar. Offers previews of each individual component and whose looks can be tweaked with a `AvatarMakerThemeData`                                       | ![1608827561239](https://user-images.githubusercontent.com/37346450/154008536-a687828c-dc9d-4a62-aa11-b800d4fb7763.jpg)            |
| [AvatarMakerRandomWidget](./docs/widgets/random.md)   | Renders a randomizer button by default OR can be used as an [InkWell] wrapper for the [child] widget. It changes the avatar with random properties for every displayed property categories.        | ![AvatarMakerRandomWidget](https://github.com/RoadTripMoustache/avatar_maker/assets/36586573/2f81c840-9c16-40db-852b-f1da1aad8811) |
| [AvatarMakerResetWidget](./docs/widgets/reset.md)     | Renders a reset button by default OR can be used as an [InkWell] wrapper for the [child] widget. It resets the avatar to the last avatar saved state.  ⚠ Useless with a non persistant controller. | ![AvatarMakerResetWidget](https://github.com/RoadTripMoustache/avatar_maker/assets/36586573/ef052b05-1b23-4f77-8a47-1d08fc734958)  |
| [AvatarMakerSaveWidget](./docs/widgets/save.md)       | Renders a save button by default OR can be used as an [InkWell] wrapper for the [child] widget. ⚠ Useless with a non persistant controller.                                                        | ![1608827561239](https://user-images.githubusercontent.com/37346450/154008545-8325af7b-58a2-4419-8544-929ffbdbb9ff.jpg)            |

******

## Customization

### Theme

The appearance of the widgets can be tweaked with `AvatarMakerThemeData`. It lets you change things
like the customizer's background colours, the box decoration, etc.

### Categories and properties

**All the categories** *(like outfits or hairs)* **and all the properties** *(like all the colors
available for hairs or facial hairs)* are also fully customizable! You want to change a title? hide
a category? or add some custom properties? AvatarMaker is fully customizable to fulfill all your
needs. Check [this documentation](./docs/how-to/define_custom_theme.md) to know how to do it easily.

### Localization

By defining a locale, you can change the language of the displayed titles !

#### Supported languages

- English *[Default]*
- Français *(French)*

******

Use the given utility functions to send and receive Avatar_Maker data from your server/DB
efficiently.

| Function Prototype                                                | Description                                                  | 
|-------------------------------------------------------------------|--------------------------------------------------------------|
| `AvatarMakerController.fromSvg(String svg)`                       | Import the avatar to the controller.                         | 
| `Future<String> PersistentAvatarMakerController.getJsonOptions()` | Extract the selected options to JSON for an external save.   | 
| `Future<String> PersistentAvatarMakerController.getAvatarSVG()`   | Import the given options in a JSON format to the controller. | 
| `Future<void> PersistentAvatarMakerController.clearAvatarMaker()` | Delete the saved avatar                                      |

SVG Assets used are derived from [getavataaars.com](https://getavataaars.com/) .

## Screenshots

### Example app

<a href="https://roadtripmoustache.github.io/avatar_maker/" >Try out the demo on your browser now</a> <i>(The demo is with a Non Persistant controller)</i>
<br />
<br />
<img src="https://user-images.githubusercontent.com/37346450/103443014-fd0dd880-4c80-11eb-8955-309bfb66fb4c.jpg" height ="400" />
<img src="https://user-images.githubusercontent.com/37346450/103443015-fed79c00-4c80-11eb-8219-5edab76c9f0f.jpg" height="400" />
<img src="https://user-images.githubusercontent.com/37346450/103443018-01d28c80-4c81-11eb-8336-ebc19de61220.jpg" height="400" />

**Use them in your games or social media apps**

<a href="https://play.google.com/store/apps/details?id=com.statefullyfidgeting.tugofwar" ><img src="https://user-images.githubusercontent.com/37346450/103443017-00a15f80-4c81-11eb-8223-3404a35079aa.jpg" height="400" /></a>

## Usage Instructions

1. Depend on it by importing your package in the ```pubspec.yaml```  file.
   ```yaml
   dependencies:
         avatar_maker: latest_version
   ```
2. Add the following import to your .dart file
   ```dart
   import "package:avatar_maker/avatar_maker.dart";
   ```
3. Add the `AvatarMakerProvider` widget to your widget tree, preferably at the top level
   of your app. This widget provides the necessary context for the other widgets to function
   correctly.
   ```dart
   AvatarMakerProvider(
     child: MaterialApp(
       home: MyHomePage(),
     ),
   );
   ```
4. Add the AvatarMakerAvatar widget to display your avatar where needed.
   ```dart
   AvatarMakerAvatar();
   ```
5. To allow your users to personalize their avatar, add the following widget and pair it with
   the above one on your page.
   ```dart
   AvatarMakerCustomizer();
   ```

That's all it takes, simple, right? The two widgets communicate with each other and update in
real-time throughout your widget tree.

## Usage Guidelines

The package offers a ton of features in the simplest way possible; however, there are some points
worth noting.

- If you create a controller instance with no `customizedPropertyCategories`, it will take all the values in `defaultPropertyCategories` instead. 
- If you create a controller instance with some items in `customizedPropertyCategories`, the customized property categories will **replace the categories 
  with the same id in `defaultPropertyCategories`. It won't remove all other default categories.**
- `AvatarMakerAvatar` only renders the local user's avatar. To display the avatar of other
  users', you'll have to use the `SvgPicture.string()` method from `flutter_svg` .
- `AvatarMakerAvatar` would render a default avatar until customized and saved by the local
  user for the first time.
- Use the `canvaskit` renderer when building for web, the default `html` renderer will not work with
  SVGs.
- The avatar maker's attributes are saved to local app/browser storage. Clearing app/browser data
  would mean clearing these attributes as well.
- You can create a `AvatarMakerThemeData` instance to configure the look and feel of the widgets to
  your liking.

More details can be found in the widgets documentations or in the how-to :

- Widgets
    - [AvatarMakerAvatar](./doc/widgets/avatar.md)
    - [AvatarMakerCustomizer](./doc/widgets/customizer.md)
    - [AvatarMakerRandomWidget](./doc/widgets/random.md)
    - [AvatarMakerResetWidget](./doc/widgets/reset.md)
    - [AvatarMakerSaveWidget](./doc/widgets/save.md)
- How-to
    - [define a custom theme ?](./doc/how-to/define_custom_theme.md)
    - [customize property category ?](./doc/how-to/define_customized_property_category.md)
    - [support a new language ?](./doc/how-to/support_new_language.md)    
    - [lock items?](./doc/how-to/lock_items.md)

## Attributions

- SVG assets from [Fang-Pen Lin](getAvataars.com)'
  s  [GitHub repository](https://github.com/fangpenlin/avataaars-generator)
- Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a>
  from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
-

Animated [GIF](https://user-images.githubusercontent.com/37346450/103071632-009ec100-45ea-11eb-97c4-96c9ec67e204.gif)
designed by [Reesha Shenoy](https://github.com/reeshaa)

- Original code from [psk907/fluttermoji](https://github.com/psk907/fluttermoji)

## Community

If you find any issues or have some feedback, please raise the same on the GitHub repo.

If you want to contribute to the project, please follow the [CONTRIBUTING](./CONTRIBUTING.md)
section.

Do leave a thumbs up if you liked it.

**Happy Fluttering 😀**
