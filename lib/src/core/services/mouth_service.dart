class MouthService {

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
