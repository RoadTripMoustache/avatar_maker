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
  A callback triggered when the user taps a locked item—perfect for showing upgrade prompts, unlock conditions, or paywalls.

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
* Tapping a locked item opens a dialog explaining the lock and simulating an "Unlock" action.


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