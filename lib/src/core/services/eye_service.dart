class EyeService {
  static String drawSVG({
    required String eye,
  }) {
    return """
      <svg width="20px" height="20px" viewBox="-3 -30 120 120">
        ${eye}
      </svg>
    """;
  }
}
