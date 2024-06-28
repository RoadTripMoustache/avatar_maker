/// Contains all the methods related to accessories.
class AccessoryService {
  /// Draw the SVG of an accessory given in parameter.
  static String drawSVG({
    required String accessory,
  }) {
    return """
      <svg width="20px" height="20px" viewBox="-3 -50 120 170" >
        ${accessory}
      </svg>
    """;
  }
}
