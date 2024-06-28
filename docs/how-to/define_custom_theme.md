# How to define a custom theme ?

In Avatar Maker almost every widgets design parameters of the customizer are updatable, which makes
it very convenient if you want to have a component in the same style of your application.

To create a new style, initialize an instance of `AvatarMakerThemeData` and define all the
parameters you want. All the empty one will be filled with our `defaultTheme` value.

| Parameter                | Type               | Description                                                                  | Default                                                                                                              |
|--------------------------|--------------------|------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| labelTextStyle           | TextStyle          | Customize the style of the attributes' titles at the top                     | `const TextStyle(fontWeight: FontWeight.w600, color: Colors.black)`                                                  |
| primaryBgColor           | Color              | Background color of the top and bottom rows                                  | `const Color(0xFFFFFFFF)`                                                                                            |
| secondaryBgColor         | Color              | Background color of the grid area                                            | `const Color(0xFFF1F1F1)`                                                                                            |
| selectedTileDecoration   | Decoration         | Box decoration style of a selected tile in a grid                            | `BoxDecoration(borderRadius: BorderRadius.circular(12.0), border: Border.all(color: Color(0xFF00FF00), width: 3.0))` |
| unselectedTileDecoration | Decoration?        | Box decoration style of an unselected tile in a grid                         | `BoxDecoration()`                                                                                                    |
| iconColor                | Color              | Color of the save button                                                     | `const Color(0xFF9C9C9C)`                                                                                            |
| selectedIconColor        | Color              | Color of a selected icon in the bottom row                                   | `const Color(0xFF424242)`                                                                                            |
| unselectedIconColor      | Color              | Color of an unselected icon in the bottom row                                | `const Color(0x80424242)`                                                                                            |
| boxDecoration            | Decoration         | Box decoration style of the AvatarMakerCustomizer                            | `BoxDecoration(borderRadius: BorderRadius.circular(18))`                                                             |
| scrollPhysics            | ScrollPhysics      | Define the scroll behaviour of all scrollable elements inside the customizer | `const ClampingScrollPhysics()`                                                                                      |
| tilePadding              | EdgeInsetsGeometry | Padding inside each tile in the grids                                        | `const EdgeInsets.all(2.0)`                                                                                          |
| tileMargin               | EdgeInsetsGeometry | Margin outside each tile in the grids                                        | `const EdgeInsets.all(2.0)`                                                                                          |
| gridCrossAxisCount       | int                | Number of items per row                                                      | `6`                                                                                                                  |
| heightFactor             | double             | Height factor of the screen to apply to the customizer container.            | `0.4`                                                                                                                |
| widthFactor              | double             | Width factor of the screen to apply to the customizer container.             | `0.95`                                                                                                               |