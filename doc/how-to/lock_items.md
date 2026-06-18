# How to lock items ?

## Overview

This update adds a flexible system for locking avatar customization items based on any conditions you define (e.g., user level, premium status, achievements). The locking logic is fully externalized so you can control it without modifying the core package.

## How it works

### `AvatarMakerCustomizer` Enhancements

File: `lib/src/customizer/avatar_maker_customizer.dart`

A new optional callback lets you decide whether any item should be locked:

```dart
bool Function(PropertyCategoryIds categoryId, String itemId)? isItemLocked;
```

**How it works:**

* The function is called for each customization item.
* Return `true` → item is locked
* Return `false` → item is unlocked

**Additional parameters:**

* **`lockWidget`**:
  A customizable widget displayed over locked items.
  When not provided, a default semi-transparent overlay with a lock icon is used.
* **`onTapLockedItem`**:
  A callback triggered when the user taps a locked item—perfect for showing upgrade prompts, unlock conditions, paywalls, or temporary previews.

### Temporary previews for locked items

Locked items can be previewed without saving them. The recommended flow is:

1. Tap a locked item.
2. Open an unlock/preview dialog.
3. Apply the item with `controller.previewOption(item, category)` or `controller.previewCosmetic(cosmeticItem)`.
4. Close the dialog so the user can see the avatar.
5. Clear the preview with `controller.clearPreview()` when the user cancels, selects another item, or leaves the customizer screen.

Temporary previews are rendered by `AvatarMakerAvatar`, but they are not written to `selectedOptions`, JSON exports, or persistent storage.

### Key Points:
- The `isItemLocked` callback receives two parameters:
    - `category`: The `PropertyCategoryIds` enum value (e.g., `Accessory`, `Hair`, `Clothes`)
    - `item`: The item identifier string (e.g., "Glasses", "Hat")
- Return `true` to lock the item, `false` to unlock it
- You can implement any business logic: level checks, premium status, achievements, etc.
- The UI will automatically display locked items with appropriate visual indicators

---

## Example

File: `example/lib/main.dart`

The example now demonstrates how to use the locking system dynamically:

* A **User Level slider** was added.
* Items in the **Accessory** category containing “Glasses” become locked when the user level is **below 5**.
* At level **5 or higher**, these items automatically unlock.

**Custom lock behavior:**

* A red lock overlay is supplied through `lockWidget`.
* Tapping a locked item opens a dialog explaining the lock, showing a small item preview, and offering `Cancel` or `Preview`.
* `Preview` applies the item temporarily with `controller.previewOption(...)` and closes the dialog so the avatar can be seen.
* `Cancel` clears any temporary preview.


```dart
class _MyPageState extends State<MyPage> {
  double _userLevel = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // User Level Slider
          Text("User Level: ${_userLevel.toInt()}"),
          Text("Reach Level 5 to unlock Glasses!"),
          Slider(
            value: _userLevel,
            min: 0,
            max: 10,
            divisions: 10,
            onChanged: (double value) {
              setState(() {
                _userLevel = value;
              });
            },
          ),
          
          // Avatar Customizer with Lock Logic
          AvatarMakerCustomizer(
            controller: myController,
            isItemLocked: (category, item) {
              // Lock glasses if user level is below 5
              if (category == PropertyCategoryIds.Accessory && 
                  item.contains("Glasses")) {
                return _userLevel < 5;
              }
              // All other items are unlocked
              return false;
            },
          ),
        ],
      ),
    );
  }
}
```

### Previewing locked items safely

Use `previewOption` for regular items and `previewCosmetic` for cosmetic items:

```dart
onTapLockedItem: (category, itemId) {
  final item = findLockedItem(category, itemId);
  if (item == null) return;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Locked"),
      content: Text("Reach level 5 to unlock this item."),
      actions: [
        TextButton(
          onPressed: () {
            controller.clearPreview();
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            controller.previewOption(item, category);
            Navigator.pop(context);
          },
          child: const Text("Preview"),
        ),
      ],
    ),
  );
}
```

`AvatarMakerSaveWidget` is disabled while a temporary preview is active, and `saveAvatarSVG()` clears previews before persisting.