import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:material_symbols_icons/material_symbols_icons.dart";

/// Arrow button to navigate in the app bar between categories.
class CustomizerArrowButton extends StatelessWidget {
  /// Total of tabs which are displayed
  final int nbrTabs;

  /// Index of the current tab
  final int tabIndex;

  /// Is the arrow must be directed to the left.
  final bool isLeft;

  /// Theme to use for this widget.
  final AvatarMakerThemeData theme;

  /// Action to perform if the arrow is tapped.
  final void Function(bool isLeft) onArrowTap;

  const CustomizerArrowButton({
    required this.nbrTabs,
    required this.tabIndex,
    required this.isLeft,
    required this.theme,
    required this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLeft ? tabIndex > 0 : tabIndex < nbrTabs - 1,
      child: IconButton(
        icon: Icon(
          isLeft ? Symbols.arrow_back_rounded : Symbols.arrow_forward_rounded,
          color: theme.iconColor,
        ),
        onPressed: () => onArrowTap(isLeft),
      ),
    );
  }
}
