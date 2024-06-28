class EyebrowService {

  static String drawSVG({
    required String eyebrow,
  }) {
    return """
      <svg width="20px" height="20px" viewBox="-3 -50 120 120">
        ${eyebrow}
      </svg>
    """;
  }
}
