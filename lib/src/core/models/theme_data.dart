import "package:flutter/material.dart";

/// Defines the configuration of the overall visual [theme] for a [AvatarMakerCustomizer]
/// and the widgets within it.
///
/// The [AvatarMakerCustomizer]'s `theme` property can be used to configure the appearance
/// of the entire widget.
///
/// You can set the attributes of this class to make the customizer look more in
/// line with your app's own theme and style.
///
/// See more:
/// * [AvatarMakerThemeData.defaultTheme] which is applied by default to the widgets.
class AvatarMakerThemeData {
  /// Customize the style of the attributes' titles at the top
  /// of the [AvatarMakerCustomizer]
  final TextStyle labelTextStyle;

  /// Background color of the top and bottom rows of the [AvatarMakerCustomizer]
  final Color primaryBgColor;

  /// Background color of the grid area of the [AvatarMakerCustomizer]
  final Color secondaryBgColor;

  /// Box decoration style of a selected tile in a grid of [AvatarMakerCustomizer]
  ///
  /// Defaults to a box with green borders.
  final Decoration selectedTileDecoration;

  /// Box decoration style of an unselected tile in a grid of
  /// [AvatarMakerCustomizer]
  ///
  /// Defaults to [null].
  final Decoration? unselectedTileDecoration;

  /// Customize the color of the default
  /// save button in [AvatarMakerSaveButton]
  final Color iconColor;

  /// Color of a selected icon in the bottom row of [AvatarMakerCustomizer]
  final Color selectedIconColor;

  /// Color of an unselected icon in the bottom row of [AvatarMakerCustomizer]
  final Color unselectedIconColor;

  /// Box decoration style of the [AvatarMakerCustomizer]
  final Decoration boxDecoration;

  /// Define the scroll behaviour of all scrollable elements inside
  /// the [AvatarMakerCustomizer]
  final ScrollPhysics scrollPhysics;

  /// Padding inside each tile in the grids of the [AvatarMakerCustomizer]
  final EdgeInsetsGeometry tilePadding;

  /// Margin outside each tile in the grids of the [AvatarMakerCustomizer]
  final EdgeInsetsGeometry tileMargin;

  /// Number of items per row in the customizer.
  final int gridCrossAxisCount;

  /// Height factor of the screen to apply to the customizer container.
  final double heightFactor;

  /// Width factor of the screen to apply to the customizer container.
  final double widthFactor;

  /// Creates a visual [theme] for the [AvatarMakerCustomizer]
  /// and the widgets within it.
  ///
  /// You can set the attributes of this class to make the customizer look more in
  /// line with your app's own theme and style.
  ///
  /// See more:
  /// * [AvatarMakerThemeData.defaultTheme] which is applied by default to the widgets.
  AvatarMakerThemeData({
    TextStyle? labelTextStyle,
    Color? primaryBgColor,
    Color? secondaryBgColor,
    Decoration? selectedTileDecoration,
    Decoration? unselectedTileDecoration,
    Color? iconColor,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    Decoration? boxDecoration,
    ScrollPhysics? scrollPhysics,
    EdgeInsetsGeometry? tilePadding,
    EdgeInsetsGeometry? tileMargin,
    int? nbrTilesRow,
    double? heightFactor,
    double? widthFactor,
  })  : this.primaryBgColor = primaryBgColor ?? defaultTheme.primaryBgColor,
        this.secondaryBgColor = secondaryBgColor ?? defaultTheme.secondaryBgColor,
        this.iconColor = iconColor ?? defaultTheme.iconColor,
        this.selectedIconColor =
            selectedIconColor ?? defaultTheme.selectedIconColor,
        this.unselectedIconColor =
            unselectedIconColor ?? defaultTheme.unselectedIconColor,
        this.selectedTileDecoration =
            selectedTileDecoration ?? defaultTheme.selectedTileDecoration,
        this.unselectedTileDecoration =
            unselectedTileDecoration ?? defaultTheme.unselectedTileDecoration,
        this.boxDecoration = boxDecoration ?? defaultTheme.boxDecoration,
        this.labelTextStyle = labelTextStyle ?? defaultTheme.labelTextStyle,
        this.scrollPhysics = scrollPhysics ?? defaultTheme.scrollPhysics,
        this.tileMargin = tileMargin ?? defaultTheme.tileMargin,
        this.tilePadding = tilePadding ?? defaultTheme.tilePadding,
        this.gridCrossAxisCount = nbrTilesRow ?? defaultTheme.gridCrossAxisCount,
        this.heightFactor = heightFactor ?? defaultTheme.heightFactor,
        this.widthFactor = widthFactor ?? defaultTheme.widthFactor;

  AvatarMakerThemeData copyWith({
    TextStyle? labelTextStyle,
    Color? primaryBgColor,
    Color? secondaryBgColor,
    Decoration? selectedTileDecoration,
    Decoration? unselectedTileDecoration,
    Color? iconColor,
    Color? selectedIconColor,
    Decoration? boxDecoration,
    ScrollPhysics? scrollPhysics,
    EdgeInsetsGeometry? tilePadding,
    EdgeInsetsGeometry? tileMargin,
    int? nbrTilesRow,
    double? heightFactor,
    double? widthFactor,
  }) {
    return AvatarMakerThemeData(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      primaryBgColor: primaryBgColor ?? this.primaryBgColor,
      secondaryBgColor: secondaryBgColor ?? this.secondaryBgColor,
      selectedTileDecoration:
          selectedTileDecoration ?? this.selectedTileDecoration,
      unselectedTileDecoration:
          unselectedTileDecoration ?? this.unselectedTileDecoration,
      iconColor: iconColor ?? this.iconColor,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      boxDecoration: boxDecoration ?? this.boxDecoration,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      tilePadding: tilePadding ?? this.tilePadding,
      tileMargin: tileMargin ?? this.tileMargin,
      nbrTilesRow: nbrTilesRow ?? this.gridCrossAxisCount,
      heightFactor: heightFactor ?? this.heightFactor,
      widthFactor: widthFactor ?? this.widthFactor,
    );
  }

  /// Default theme of Avatar Maker components.
  static AvatarMakerThemeData defaultTheme = AvatarMakerThemeData(
    primaryBgColor: const Color(0xFFFFFFFF),
    secondaryBgColor: const Color(0xFFF1F1F1),
    iconColor: const Color(0xFF9C9C9C),
    selectedIconColor: const Color(0xFF424242),
    unselectedIconColor: const Color(0x80424242),
    selectedTileDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: Color(0xFF00FF00),
        width: 3.0,
      ),
    ),
    unselectedTileDecoration: BoxDecoration(),
    boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
    labelTextStyle:
        const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
    scrollPhysics: const ClampingScrollPhysics(),
    tileMargin: const EdgeInsets.all(2.0),
    tilePadding: const EdgeInsets.all(2.0),
    nbrTilesRow: 6,
    heightFactor: 0.4,
    widthFactor: 0.95,
  );
}
