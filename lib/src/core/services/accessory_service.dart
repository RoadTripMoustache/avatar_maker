class AccessoryService {
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
