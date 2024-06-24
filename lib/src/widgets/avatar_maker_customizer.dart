import "package:avatar_maker/src/controllers/avatar_maker_controller.dart";
import "package:avatar_maker/src/enums/property_category_ids.dart";
import "package:avatar_maker/src/models/customized_property_category.dart";
import "package:avatar_maker/src/models/property_item.dart";
import "package:avatar_maker/src/models/theme_data.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";

/// This widget provides the user with a UI for customizing their Avatar_Maker
///
///*****
///Note: \
/// It is advised that a [AvatarMakerCircleAvatar] also be present in the same page.
/// to show the user a preview of the changes being made.
class AvatarMakerCustomizer extends StatefulWidget {
  final double? scaffoldHeight;
  final double? scaffoldWidth;

  /// Configuration for the overall visual theme for this widget
  /// and the components within it.
  final AvatarMakerThemeData theme;

  final List<CustomizedPropertyCategory>? customizedPropertyCategories;

  /// Will save the selection automatically everytime the user selects
  /// something when set to `true` .
  ///
  /// If set to `false` you may want to implement a [AvatarMakerSaveWidget]
  /// in your app to let users save their selection manually.
  final bool autosave;

  /// Creates a widget UI to customize the AvatarMaker
  ///
  /// You may provide a [AvatarMakerThemeData] instance to adjust the appearance of this
  /// widget to your app's theme.
  ///
  /// Accepts optional [scaffoldHeight] and [scaffoldWidth] attributes
  /// to override the default layout.
  ///
  ///*****
  ///Note: \
  /// It is advised that a [AvatarMakerCircleAvatar] also be present in the same page.
  /// to show the user a preview of the changes being made.
  AvatarMakerCustomizer({
    Key? key,
    this.scaffoldHeight,
    this.scaffoldWidth,
    AvatarMakerThemeData? theme,
    this.customizedPropertyCategories,
    this.autosave = false,
  })  : this.theme = theme ?? AvatarMakerThemeData.standard,
        super(key: key);

  @override
  _AvatarMakerCustomizerState createState() => _AvatarMakerCustomizerState();
}

class _AvatarMakerCustomizerState extends State<AvatarMakerCustomizer>
    with SingleTickerProviderStateMixin {
  late AvatarMakerController avatarmakerController;
  late int categoriesTabsLength;
  late TabController tabController;
  var heightFactor = 0.4, widthFactor = 0.95;

  @override
  void initState() {
    super.initState();

    Get.put(AvatarMakerController(widget.customizedPropertyCategories));
    final _controller = Get.find<AvatarMakerController>();
    categoriesTabsLength = _controller.displayedPropertyCategories.length;

    setState(() {
      avatarmakerController = _controller;
      tabController = TabController(
        length: categoriesTabsLength,
        vsync: this,
      );
    });

    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // This ensures that unsaved edits are reverted
    avatarmakerController.restoreState();
    super.dispose();
  }

  void onTapOption(
      PropertyItem newSelectedItem, PropertyCategoryIds categoryId) {
    if (avatarmakerController.selectedOptions[categoryId] != newSelectedItem) {
      setState(() {
        avatarmakerController.selectedOptions[categoryId] = newSelectedItem;
      });
      avatarmakerController.updatePreview();
      if (widget.autosave) {
        avatarmakerController.setAvatarMaker();
      }
    }
  }

  void onArrowTap(bool isLeft) {
    int _currentIndex = tabController.index;
    if (isLeft)
      tabController
          .animateTo(_currentIndex > 0 ? _currentIndex - 1 : _currentIndex);
    else
      tabController.animateTo(_currentIndex < categoriesTabsLength - 1
          ? _currentIndex + 1
          : _currentIndex);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: widget.scaffoldHeight ?? (size.height * heightFactor),
      width: widget.scaffoldWidth ?? size.width,
      child: body(),
    );
  }

  Container bottomNavBar(List<Widget> navbarWidgets) {
    return Container(
      color: widget.theme.primaryBgColor,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        indicatorColor: widget.theme.selectedIconColor,
        tabs: navbarWidgets,
        tabAlignment: TabAlignment.center,
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: widget.theme.primaryBgColor,
      automaticallyImplyLeading: false,
      title: Text(
        avatarmakerController
            .displayedPropertyCategories[tabController.index].name!,
        style: widget.theme.labelTextStyle,
        textAlign: TextAlign.center,
      ),
      leading: arrowButton(true),
      actions: [
        arrowButton(false),
      ],
    );
  }

  Widget arrowButton(bool isLeft) {
    return Visibility(
      visible: isLeft
          ? tabController.index > 0
          : tabController.index < categoriesTabsLength - 1,
      child: IconButton(
        // splashRadius: 20,
        icon: Icon(
          isLeft
              ? Icons.arrow_back_ios_new_rounded
              : Icons.arrow_forward_ios_rounded,
          color: widget.theme.iconColor,
        ),
        onPressed: () => onArrowTap(isLeft),
      ),
    );
  }

  /// Widget that renders an expanded layout for customization
  /// Accepts a [cardTitle] and a [attributes].
  ///
  /// [attribute] is an object with the fields attributeName and attributeKey
  // TODO : Sortir les sous-composants dans des fichiers dédiés.
  Widget body() {
    var size = MediaQuery.of(context).size;

    var attributeGrids = <Widget>[];
    var navbarWidgets = <Widget>[];

    for (final (categoryIndex, propertyCategory)
        in avatarmakerController.displayedPropertyCategories.indexed) {
      if (propertyCategory.toDisplay) {
        /// Number of options available for said [attribute]
        /// Eg: "Hairstyle" attribute has 38 options
        var attributeListLength = propertyCategory.properties!.length;

        PropertyItem selectedItem =
            avatarmakerController.selectedOptions[propertyCategory.id]!;

        /// Build the main Tile Grid with all the options from the attribute
        var _tileGrid = GridView.builder(
          physics: widget.theme.scrollPhysics,
          itemCount: attributeListLength,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.theme.gridCrossAxisCount,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () => onTapOption(
                propertyCategory.properties![index], propertyCategory.id),
            child: Container(
              decoration:
                  index == propertyCategory.properties!.indexOf(selectedItem)
                      ? widget.theme.selectedTileDecoration
                      : widget.theme.unselectedTileDecoration,
              margin: widget.theme.tileMargin,
              padding: widget.theme.tilePadding,
              child: SvgPicture.string(
                avatarmakerController.getComponentSVG(
                    propertyCategory.id, index),
                height: 20,
                semanticsLabel: 'Your AvatarMaker',
                placeholderBuilder: (context) => Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
        );

        /// Builds the icon for the attribute to be placed in the bottom row
        var bottomNavWidget = SvgPicture.asset(
          propertyCategory.iconFile!,
          package: 'avatar_maker',
          height: (widget.scaffoldHeight != null
              ? widget.scaffoldHeight! / heightFactor * 0.04
              : size.height * 0.04),
          colorFilter: ColorFilter.mode(
              categoryIndex == tabController.index
                  ? widget.theme.selectedIconColor
                  : widget.theme.unselectedIconColor,
              BlendMode.srcIn),
          semanticsLabel: propertyCategory.name,
        );

        /// Add all the initialized widgets to the state
        attributeGrids.add(_tileGrid);
        navbarWidgets.add(bottomNavWidget);
      }
    }

    return Container(
      decoration: widget.theme.boxDecoration,
      clipBehavior: Clip.hardEdge,
      child: DefaultTabController(
        length: attributeGrids.length,
        child: Scaffold(
          key: const ValueKey('AvatarMakerCustomizer'),
          backgroundColor: widget.theme.secondaryBgColor,
          appBar: appbar(),
          body: TabBarView(
            physics: widget.theme.scrollPhysics,
            controller: tabController,
            children: attributeGrids,
          ),
          bottomNavigationBar: bottomNavBar(navbarWidgets),
        ),
      ),
    );
  }
}
