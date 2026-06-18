import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:avatar_maker/avatar_maker.dart";
import "cosmetic_data.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avatar Maker Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MyHomePage(title: 'Avatar Maker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final AvatarMakerController _avatarMakerController;

  @override
  void initState() {
    super.initState();
    _avatarMakerController = NonPersistentAvatarMakerController(
      customizedPropertyCategories: _buildCosmeticCategories(),
      locale: WidgetsBinding.instance.platformDispatcher.locale,
    );
  }

  List<CustomizedPropertyCategory> _buildCosmeticCategories() {
    return [
      CustomizedPropertyCategory(
        id: PropertyCategoryIds.AvatarBackground,
        iconFile: "assets/icons/background.svg",
        toDisplay: true,
        properties: [
          NoBackgroundItem(),
          ...buildAllBackgrounds(),
        ],
      ),
      CustomizedPropertyCategory(
        id: PropertyCategoryIds.AvatarEffect,
        iconFile: "assets/icons/effects.svg",
        toDisplay: true,
        properties: [
          NoEffectItem(),
          ...buildAllEffects(),
        ],
      ),
      CustomizedPropertyCategory(
        id: PropertyCategoryIds.AvatarEffectColor,
        iconFile: "assets/icons/effect_color.svg",
        toDisplay: true,
        properties: [
          NoEffectColorItem(),
          ...buildAllEffectColors(),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Use your Avatar Maker anywhere\nwith the below widget",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          AvatarMakerAvatar(
            backgroundColor: Colors.grey[200],
            radius: 100,
            controller: _avatarMakerController,
            usePreview: false,
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "and create your own page to customize them using our widgets",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50),
          Row(
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 3,
                child: Container(
                  height: 35,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text("Customize"),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewPage(
                                  controller: _avatarMakerController,
                                ))),
                  ),
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}

class NewPage extends StatefulWidget {
  final AvatarMakerController controller;

  const NewPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  double _userLevel = 0;

  bool _isCosmeticLocked(PropertyCategoryIds category, String itemId) {
    final requiredLevel = _requiredLevelForCosmetic(category, itemId);
    return _userLevel < requiredLevel;
  }

  int _requiredLevelForCosmetic(PropertyCategoryIds category, String itemId) {
    final cosmeticId = _cosmeticIdFromItemId(itemId);
    final item = _findCosmeticItem(category, cosmeticId);
    if (item == null) {
      return 0;
    }
    if (item.tier == "basic") {
      return 0;
    }
    if (item.tier == "illustrated") {
      return 3;
    }
    return item.cost >= 700 ? 8 : 6;
  }

  String _cosmeticIdFromItemId(String itemId) {
    final parts = itemId.split('/');
    return parts.isEmpty ? itemId : parts.last;
  }

  CosmeticPropertyItem? _findCosmeticItem(
    PropertyCategoryIds category,
    String cosmeticId,
  ) {
    switch (category) {
      case PropertyCategoryIds.AvatarBackground:
        return [
          NoBackgroundItem(),
          ...buildAllBackgrounds(),
        ].firstWhere(
          (item) => item.cosmeticId == cosmeticId,
          orElse: () => NoBackgroundItem(),
        );
      case PropertyCategoryIds.AvatarEffect:
        return [
          NoEffectItem(),
          ...buildAllEffects(),
        ].firstWhere(
          (item) => item.cosmeticId == cosmeticId,
          orElse: () => NoEffectItem(),
        );
      case PropertyCategoryIds.AvatarEffectColor:
        return [
          NoEffectColorItem(),
          ...buildAllEffectColors(),
        ].firstWhere(
          (item) => item.cosmeticId == cosmeticId,
          orElse: () => NoEffectColorItem(),
        );
      default:
        return null;
    }
  }

  PropertyItem? _findLockedItem(
    PropertyCategoryIds category,
    String itemId,
  ) {
    final cosmetic = _findCosmeticItem(category, _cosmeticIdFromItemId(itemId));
    if (cosmetic != null) {
      return cosmetic;
    }

    final propertyCategory = widget.controller.propertyCategories
        .firstWhere((item) => item.id == category);
    return propertyCategory.properties!.firstWhere(
      (item) => item.id == itemId,
      orElse: () => propertyCategory.defaultValue!,
    );
  }

  Widget _lockedItemPreview(
    BuildContext context,
    PropertyCategoryIds category,
    PropertyItem item,
  ) {
    if (item is CosmeticPropertyItem) {
      return SizedBox(
        height: 96,
        child: item.buildThumbnail(context, 96),
      );
    }

    final propertyCategory = widget.controller.propertyCategories
        .firstWhere((item) => item.id == category);
    final index = propertyCategory.properties!.indexWhere(
      (candidate) => candidate.id == item.id,
    );
    if (index < 0) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 96,
      child: SvgPicture.string(
        widget.controller.getComponentSVG(category, index),
        height: 96,
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.clearPreview();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar preview with live cosmetics
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: AvatarMakerAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[200],
                  controller: widget.controller,
                ),
              ),
              // Level Slider
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "User Level: ${_userLevel.toInt()}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Reach Level 3+ to unlock illustrated cosmetics."),
                    Slider(
                      value: _userLevel,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      label: _userLevel.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _userLevel = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: min(600, _width * 0.85),
                child: Row(
                  children: [
                    Text(
                      "Customize:",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spacer(),
                    AvatarMakerSaveWidget(controller: widget.controller),
                    AvatarMakerRandomWidget(controller: widget.controller),
                    AvatarMakerResetWidget(controller: widget.controller),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: AvatarMakerCustomizer(
                  scaffoldWidth: min(600, _width * 0.85),
                  autosave: false,
                  controller: widget.controller,
                  theme: AvatarMakerThemeData(
                      boxDecoration: BoxDecoration(boxShadow: [BoxShadow()])),
                  isItemLocked: (category, item) {
                    if (category == PropertyCategoryIds.Accessory &&
                        item.contains("Glasses")) {
                      return _userLevel < 5;
                    }
                    return _isCosmeticLocked(category, item);
                  },
                  lockWidget: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  onTapLockedItem: (category, item) {
                    final requiredLevel =
                        _requiredLevelForCosmetic(category, item);
                    final lockedItem = _findLockedItem(category, item);
                    if (lockedItem == null) {
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Cosmetic Locked"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .unlock_cosmetic_level(requiredLevel),
                            ),
                            const SizedBox(height: 16),
                            _lockedItemPreview(context, category, lockedItem),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              widget.controller.clearPreview();
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.controller.previewOption(
                                lockedItem,
                                category,
                              );
                              Navigator.pop(context);
                            },
                            child: Text("Preview"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
