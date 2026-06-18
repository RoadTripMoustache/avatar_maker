import "package:avatar_maker/src/core/models/cosmetic_property_item.dart";
import "package:avatar_maker/src/core/services/cosmetic_service.dart";
import "package:flutter/material.dart";

/// A grid widget for displaying and selecting cosmetic items.
///
/// Shows a grid of cosmetic thumbnails with selection indicators,
/// lock overlays, and price tags.
class CosmeticGridWidget extends StatelessWidget {
  /// List of cosmetic items to display.
  final List<CosmeticPropertyItem> items;

  /// Currently selected item (nullable).
  final CosmeticPropertyItem? selectedItem;

  /// Callback when a non-locked item is selected.
  final Function(CosmeticPropertyItem item) onSelect;

  /// Callback when a locked item is tapped.
  final Function(CosmeticPropertyItem item)? onTapLocked;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Spacing between grid items.
  final double spacing;

  /// Size of each thumbnail.
  final double thumbnailSize;

  const CosmeticGridWidget({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onSelect,
    this.onTapLocked,
    this.crossAxisCount = 3,
    this.spacing = 8,
    this.thumbnailSize = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(spacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = item == selectedItem;

        return GestureDetector(
          onTap: item.locked
              ? () => onTapLocked?.call(item)
              : () => onSelect(item),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: isSelected ? 3 : 1,
              ),
            ),
            child: Stack(
              children: [
                // Cosmetic thumbnail
                Center(
                  child: item.buildThumbnail(context, thumbnailSize),
                ),

                // Lock overlay
                if (item.locked)
                  Positioned.fill(
                    child: CosmeticService.buildLockedOverlay(
                      size: thumbnailSize,
                    ),
                  ),

                // Price tag
                if (!item.locked && item.cost > 0)
                  Positioned(
                    bottom: 4,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CosmeticService.buildPriceTag(item.cost),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
