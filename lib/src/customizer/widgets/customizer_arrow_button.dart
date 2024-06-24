import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";

class CustomizerArrowButton extends StatelessWidget {
  final AvatarMakerController avatarMakerController;
  final TabController tabController;
  final bool isLeft;
  final AvatarMakerThemeData theme;
  final void Function(bool isLeft) onArrowTap;

  const CustomizerArrowButton({
    required this.avatarMakerController,
    required this.tabController,
    required this.isLeft,
    required this.theme,
    required this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLeft
          ? tabController.index > 0
          : tabController.index <
              avatarMakerController.displayedPropertyCategories.length - 1,
      child: IconButton(
        // splashRadius: 20,
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
