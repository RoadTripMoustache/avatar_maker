import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_arrow_button.dart";
import "package:flutter/material.dart";

class CustomizerAppbar extends StatelessWidget implements PreferredSizeWidget {
  final AvatarMakerController avatarMakerController;
  final TabController tabController;
  final AvatarMakerThemeData theme;
  final void Function(bool isLeft) onArrowTap;

  const CustomizerAppbar({
    required this.avatarMakerController,
    required this.tabController,
    required this.theme,
    required this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: theme.primaryBgColor,
      automaticallyImplyLeading: false,
      title: Text(
        avatarMakerController
            .displayedPropertyCategories[tabController.index].name!,
        style: theme.labelTextStyle,
        textAlign: TextAlign.center,
      ),
      leading: CustomizerArrowButton(
        avatarMakerController: avatarMakerController,
        tabController: tabController,
        theme: theme,
        isLeft: true,
        onArrowTap: onArrowTap,
      ),
      actions: [
        CustomizerArrowButton(
          avatarMakerController: avatarMakerController,
          tabController: tabController,
          theme: theme,
          isLeft: false,
          onArrowTap: onArrowTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
