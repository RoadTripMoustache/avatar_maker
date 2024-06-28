import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_arrow_button.dart";
import "package:flutter/material.dart";

/// Top app bar of the Customizer widget.
///
/// This widget is used to display the title of the current category and
/// navigate through categories using arrows.
class CustomizerAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int nbrCategories;
  final String title;
  final int tabIndex;
  final AvatarMakerThemeData theme;
  final void Function(bool isLeft) onArrowTap;

  const CustomizerAppbar({
    required this.nbrCategories,
    required this.title,
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
        title,
        style: theme.labelTextStyle,
        textAlign: TextAlign.center,
      ),
      leading: CustomizerArrowButton(
        nbrTabs: nbrCategories,
        tabIndex: tabIndex,
        theme: theme,
        isLeft: true,
        onArrowTap: onArrowTap,
      ),
      actions: [
        CustomizerArrowButton(
          nbrTabs: nbrCategories,
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
