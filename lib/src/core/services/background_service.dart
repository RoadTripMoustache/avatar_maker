/// Contains all the methods related to backgrounds.
class BackgroundService {
  /// Draw the SVG of a background given in parameter.
  static String drawSVG({
    required String background,
  }) {
    return """
      <svg width="264px" height="280px" viewBox="0 0 264 280" version="1.1"
          xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
          <defs>
              <circle id="path-1" cx="120" cy="120" r="120"></circle>
              <path
                  d="M12,160 C12,226.27417 65.72583,280 132,280 C198.27417,280 252,226.27417 252,160 L264,160 L264,-1.42108547e-14 L-3.19744231e-14,-1.42108547e-14 L-3.19744231e-14,160 L12,160 Z"
                  id="path-3"></path>
          </defs>
          <g id="AvatarMaker" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
              <g transform="translate(-825.000000, -1100.000000)" id="avatar_maker/Circle">
                  <g transform="translate(825.000000, 1100.000000)">${background}
                      <g id="Mask"></g>
                      <g id="AvatarMaker" stroke-width="1" fill-rule="evenodd"></g>
                  </g>
              </g>
          </g>
      </svg>
    """;
  }
}
