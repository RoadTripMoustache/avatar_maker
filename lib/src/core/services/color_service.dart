class ColorService {

  static String drawSVG({
    required String hexColorCode,
  }) {
    return """
      <svg width="120px" height="120px" > 
        <circle cx="60" cy="60" r="35" stroke="black" stroke-width="1" fill="${hexColorCode}"/>
      </svg>
    """;
  }
}
