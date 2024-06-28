/// Contains all the methods related to mouths.
class MouthService {
  /// Draw the SVG of a mouth given in parameter.
  static String drawSVG({
    required String mouth,
  }) {
    return """
      <svg width="20px" height="20px" viewBox="0 10 120 120">
        ${mouth}
      </svg>
    """;
  }
}
