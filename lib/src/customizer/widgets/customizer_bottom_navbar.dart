import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";

class CustomizerBottomNavbar extends StatelessWidget {
  final List<Widget> navbarWidgets;
  final AvatarMakerThemeData theme;
  final TabController tabController;

  const CustomizerBottomNavbar({
    required this.navbarWidgets,
    required this.theme,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.primaryBgColor,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        indicatorColor: theme.selectedIconColor,
        tabs: navbarWidgets,
        tabAlignment: TabAlignment.center,
      ),
    );
  }
}
