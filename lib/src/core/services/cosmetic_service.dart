import "package:flutter/material.dart";

/// Service class for cosmetic item rendering utilities.
class CosmeticService {
  /// Build a locked overlay widget for a cosmetic item.
  static Widget buildLockedOverlay({
    required double size,
    Color overlayColor = const Color(0x4D000000),
    double borderRadius = 10,
    double iconSize = 24,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: overlayColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Icon(
          Icons.lock,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }

  /// Build a price tag widget for a cosmetic item.
  static Widget buildPriceTag(
    int cost, {
    Color backgroundColor = const Color(0x80000000),
    Color textColor = Colors.white,
    double fontSize = 10,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$cost",
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Get the tier label for display.
  static String getTierLabel(String tier) {
    switch (tier) {
      case "basic":
        return "Basic";
      case "illustrated":
        return "Illustrated";
      case "premium":
        return "Premium";
      default:
        return tier;
    }
  }

  /// Get the tier color for display.
  static Color getTierColor(String tier) {
    switch (tier) {
      case "basic":
        return Colors.grey;
      case "illustrated":
        return Colors.blue;
      case "premium":
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
}
