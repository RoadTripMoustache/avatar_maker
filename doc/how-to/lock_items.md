    *   A new optional parameter named `isItemLocked` was added to the `AvatarMakerCustomizer` widget.
    *   **Signature:** `bool Function(PropertyCategoryIds categoryId, String itemId)? isItemLocked`
    *   **Functionality:** This callback function is invoked for each customization item. If it returns `true`, the item is considered locked; if `false`, it is unlocked.
    *   **New Parameters:**
        *   `Widget? lockWidget`: A custom widget to display overlaying the item when it is locked. Defaults to a semi-transparent black overlay with a lock icon.
        *   `Function(PropertyCategoryIds, String)? onTapLockedItem`: A callback triggered when a user taps on a locked item. This is useful for showing "Unlock" dialogs or premium upgrade prompts.

2.  **Example Application (`example/lib/main.dart`):**
    *   A "User Level" slider was added to the example application.
    *   The `AvatarMakerCustomizer` usage was updated to demonstrate the `isItemLocked` logic:
        *   If the category is `Accessory` and the item name contains "Glasses":
        *   If the user level is less than 5, these items are marked as **locked** (`true`).
        *   If the level is 5 or higher, the items become **unlocked** (`false`).
    *   **Custom Lock UI & Interaction:**
        *   A custom red lock overlay is provided via `lockWidget`.
        *   Tapping a locked item shows a dialog explaining why it's locked and offering an "Unlock" action (simulated).

This structure allows for a dynamic locking mechanism to be established via an externally provided function, without embedding specific business logic into the core package.

---

## Usage Example

Here's how to implement the `isItemLocked` feature with custom UI and interaction:

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
            
            // 1. Define Locking Logic
            isItemLocked: (category, item) {
              if (category == PropertyCategoryIds.Accessory && 
                  item.contains("Glasses")) {
                return _userLevel < 5;
              }
              return false;
            },
            
            // 2. (Optional) Custom Lock Overlay
            lockWidget: Container(
              color: Colors.red.withOpacity(0.5),
              child: Icon(Icons.lock, color: Colors.white),
            ),
            
            // 3. (Optional) Handle Taps on Locked Items
            onTapLockedItem: (category, item) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Locked!"),
                  content: Text("You need Level 5 to use this item."),
                  actions: [
                    TextButton(
                      onPressed: () {
                         // Implement unlock logic (e.g., deduct gold)
                         Navigator.pop(context);
                      }, 
                      child: Text("Unlock")
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
```

### Key Points:
- **`isItemLocked`**: Determines if an item is locked.
- **`lockWidget`**: Customizes the visual appearance of locked items.
- **`onTapLockedItem`**: Handles user interaction with locked items (e.g., upsell, requirements).
- You can implement any business logic: level checks, premium status, achievements, in-game currency, etc.