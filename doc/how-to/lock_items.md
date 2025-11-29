# How to lock items ?

**Summary:**
This commit introduces the ability to lock avatar customization items based on specific conditions (e.g., user level, premium membership, etc.).

**Changes Made:**

1.  **`AvatarMakerCustomizer` Update (`lib/src/customizer/avatar_maker_customizer.dart`):**
    *   A new optional parameter named `isItemLocked` was added to the `AvatarMakerCustomizer` widget.
    *   **Signature:** `bool Function(PropertyCategoryIds categoryId, String itemId)? isItemLocked`
    *   **Functionality:** This callback function is invoked for each customization item. If it returns `true`, the item is considered locked; if `false`, it is unlocked.
    *   This parameter is passed down to the `CustomizerBody` widget to handle locked items in the UI.

2.  **Example Application (`example/lib/main.dart`):**
    *   A "User Level" slider was added to the example application.
    *   The `AvatarMakerCustomizer` usage was updated to demonstrate the `isItemLocked` logic:
        *   If the category is `Accessory` and the item name contains "Glasses":
        *   If the user level is less than 5, these items are marked as **locked** (`true`).
        *   If the level is 5 or higher, the items become **unlocked** (`false`).

This structure allows for a dynamic locking mechanism to be established via an externally provided function, without embedding specific business logic into the core package.

---

## Usage Example

Here's how to implement the `isItemLocked` feature in your application:

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

### Key Points:
- The `isItemLocked` callback receives two parameters:
    - `category`: The `PropertyCategoryIds` enum value (e.g., `Accessory`, `Hair`, `Clothes`)
    - `item`: The item identifier string (e.g., "Glasses", "Hat")
- Return `true` to lock the item, `false` to unlock it
- You can implement any business logic: level checks, premium status, achievements, etc.
- The UI will automatically display locked items with appropriate visual indicators