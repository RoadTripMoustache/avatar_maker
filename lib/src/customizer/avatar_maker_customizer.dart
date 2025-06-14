import "package:avatar_maker/src/core/controllers/avatar_maker_controller.dart";
import "package:avatar_maker/src/core/enums/property_category_ids.dart";
import "package:avatar_maker/src/core/models/customized_property_category.dart";
import "package:avatar_maker/src/core/models/property_item.dart";
import "package:avatar_maker/src/core/models/theme_data.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_body.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

/// This widget provides the user with a UI for customizing their Avatar_Maker
///
///*****
///Note: \
/// It is advised that a [AvatarMakerCircleAvatar] also be present in the same
/// page to show the user a preview of the changes being made.
class AvatarMakerCustomizer extends StatefulWidget {
  /// To define the height of the component.
  final double? scaffoldHeight;

  /// To define the width of the component.
  final double? scaffoldWidth;

  /// Configuration for the overall visual theme for this widget
  /// and the components within it.
  final AvatarMakerThemeData theme;

  /// List of all the customized property categories you want to use instead of
  /// the default ones.
  final List<CustomizedPropertyCategory>? customizedPropertyCategories;

  /// Will save the selection automatically everytime the user selects
  /// something when set to `true` .
  ///
  /// If set to `false` you may want to implement a [AvatarMakerSaveWidget]
  /// in your app to let users save their selection manually.
  final bool autosave;

  /// Called every time the user selects a new option and returns the SVG string
  /// of the avatar.
  final Function(String avatarSvg)? onChange;

  /// The [AvatarMakerController] to use for this widget.
  ///
  /// If not provided, a new controller will be created.
  final AvatarMakerController? controller;

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
    this.onChange,
    this.controller,
  })  : this.theme = theme ?? AvatarMakerThemeData.defaultTheme,
        super(key: key);

  @override
  _AvatarMakerCustomizerState createState() => _AvatarMakerCustomizerState();
}

class _AvatarMakerCustomizerState extends State<AvatarMakerCustomizer>
    with SingleTickerProviderStateMixin {
  late AvatarMakerController avatarMakerController;
  bool _controllerCreatedInternally = false;

  /// Number of displayed categories in the customizer widget.
  late int nbrDisplayedCategories;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    // Use the provided controller or create a new one
    if (widget.controller != null) {
      avatarMakerController = widget.controller!;
    } else {
      _controllerCreatedInternally = true;
      avatarMakerController = AvatarMakerController(
          customizedPropertyCategories: widget.customizedPropertyCategories);
    }

    nbrDisplayedCategories = avatarMakerController.displayedPropertyCategories.length;

    tabController = TabController(
      length: nbrDisplayedCategories,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {});
    });

    // Add listener to the controller
    avatarMakerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Remove the listener
    avatarMakerController.removeListener(() {
      setState(() {});
    });

    // This ensures that unsaved edits are reverted
    avatarMakerController.restoreState();

    // Only dispose the controller if we created it
    if (_controllerCreatedInternally) {
      avatarMakerController.dispose();
    }

    super.dispose();
  }

  /// On tap on a option, select the tapped option for the current category
  /// selected.
  void onTapOption(
      PropertyItem newSelectedItem, PropertyCategoryIds categoryId) {
    if (avatarMakerController.selectedOptions[categoryId] != newSelectedItem) {
      setState(() {
        avatarMakerController.selectedOptions[categoryId] = newSelectedItem;
      });
      avatarMakerController.updatePreview();
      if(widget.onChange != null) {
        widget.onChange!(avatarMakerController.drawAvatarSVG());
      }
      if (widget.autosave) {
        avatarMakerController.saveAvatarSVG();
      }
    }
  }

  /// Move to the previous or the next tab, depending the direction of the
  /// array.
  /// isLeft = true - Go to the previous tab
  /// isLeft = false - Go to the next tab
  void onArrowTap(bool isLeft) {
    int _currentIndex = tabController.index;
    if (isLeft)
      tabController
          .animateTo(_currentIndex > 0 ? _currentIndex - 1 : _currentIndex);
    else
      tabController.animateTo(_currentIndex < nbrDisplayedCategories - 1
          ? _currentIndex + 1
          : _currentIndex);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AvatarMakerController>.value(
      value: avatarMakerController,
      child: SizedBox(
        height:
            widget.scaffoldHeight ?? (size.height * widget.theme.heightFactor),
        width: widget.scaffoldWidth ?? size.width,
        child: CustomizerBody(
          avatarMakerController: avatarMakerController,
          tabController: tabController,
          theme: widget.theme,
          scaffoldHeight: widget.scaffoldHeight,
          onTapOption: onTapOption,
          onArrowTap: onArrowTap,
        ),
      ),
    );
  }
}
