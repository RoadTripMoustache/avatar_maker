class EyebrowService {
  // TODO : Faire un drawSVG global pour les éléments qui ont juste besoin
  // d'être mis dans une boite pour devenir un item

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
