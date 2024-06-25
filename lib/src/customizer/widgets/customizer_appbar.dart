import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_arrow_button.dart";
import "package:flutter/material.dart";

class CustomizerAppbar extends StatelessWidget implements PreferredSizeWidget {
  final List<CustomizedPropertyCategory> propertyCategories;
  final int tabIndex;
  final AvatarMakerThemeData theme;
  final void Function(bool isLeft) onArrowTap;

  const CustomizerAppbar({
    required this.propertyCategories,
    required this.tabIndex,
    required this.theme,
    required this.onArrowTap,
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: theme.primaryBgColor,
      automaticallyImplyLeading: false,
      title: Text(
        propertyCategories[tabIndex].name!,
        style: theme.labelTextStyle,
        textAlign: TextAlign.center,
      ),
      leading: CustomizerArrowButton(
        nbrTabs: propertyCategories.length,
        tabIndex: tabIndex,
        theme: theme,
        isLeft: true,
        onArrowTap: onArrowTap,
      ),
      actions: [
        CustomizerArrowButton(
          nbrTabs: propertyCategories.length,
          tabIndex: tabIndex,
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
