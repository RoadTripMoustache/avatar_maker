import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";

/// Bottom nav bar of the customizer. Used to display all the category available
/// as tabs.
class CustomizerBottomNavbar extends StatelessWidget {
  /// Tabs to display
  final List<Widget> navbarWidgets;

  /// Theme to apply
  final AvatarMakerThemeData theme;

  /// Tab controller to manage the movement between tabs.
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
