import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";

class CustomizerArrowButton extends StatelessWidget {
  final int nbrTabs;
  final int tabIndex;
  final bool isLeft;
  final AvatarMakerThemeData theme;
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
          isLeft
              ? Icons.arrow_back_ios_new_rounded
              : Icons.arrow_forward_ios_rounded,
          color: theme.iconColor,
        ),
        onPressed: () => onArrowTap(isLeft),
      ),
    );
  }
}
