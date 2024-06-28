/// Contains all the methods related to noses.
class NoseService {
  /// Draw the SVG of a nose given in parameter.
  static String drawSVG({
    required String nose,
  }) {
    return """
      <svg width="20px" height="20px" viewBox="-3 -30 120 120">
        ${nose}
      </svg>
    """;
  }
}
