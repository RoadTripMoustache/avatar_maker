"""
Assembles the 10 category packs (50 distinct styles each) into:
  1. assets/icons/<category>_50.svg   - standalone SVG packs (preview / icon use)
  2. contrib/dart/<category>_50.dart  - ready-to-paste enum entries using the
                                          package's colour placeholders
  3. contrib/dart/README.md            - integration notes
  4. assets/icons/preview_50.html      - single-page HTML preview of everything
"""

import os, re, html, json

ROOT = r'C:\Projeler\avatar_maker'
SVG_OUT = os.path.join(ROOT, 'assets', 'icons')
DART_OUT = os.path.join(ROOT, 'lib', 'src', 'core', 'enums', 'property_items', 'generated')
os.makedirs(SVG_OUT, exist_ok=True)
os.makedirs(DART_OUT, exist_ok=True)

PH_HAIR = 'TO_REPLACE_WITH_HAIRS_COLOR'
PH_HAIR_NAME = 'TO_REPLACE_WITH_HAIRS_COLOR_NAME'
PH_FHAIR = 'TO_REPLACE_WITH_FACIAL_HAIRS_COLOR'
PH_FHAIR_NAME = 'TO_REPLACE_WITH_FACIAL_HAIRS_COLOR_NAME'
PH_OUTFIT = 'TO_REPLACE_WITH_OUTFIT_COLOR'
PH_OUTFIT_NAME = 'TO_REPLACE_WITH_OUTFIT_COLOR_NAME'

# Fallback colours used only in the standalone preview SVGs.
PREVIEW_HAIR = '#2C1B18'
PREVIEW_FHAIR = '#252E32'
PREVIEW_OUTFIT = '#5BC0DE'


def clean(s):
    """Collapse the whitespace of a generated path block."""
    s = re.sub(r'\n\s*', ' ', s)
    s = re.sub(r'\s+', ' ', s)
    return s.strip()


SEG_RE = re.compile(r'<(path|circle|ellipse|rect)\b[^>]*/>')


def resolve_placeholders(body, name, cat):
    """Replace the colour placeholders with concrete preview values.

    The `_NAME` token must be replaced first: it contains the plain token as a
    prefix, so replacing the plain one first would corrupt it.
    """
    if cat['key'] == 'hair':
        pairs = [(PH_HAIR_NAME, f'HairColor/{name}'), (PH_HAIR, cat['preview_colour'])]
    elif cat['key'] == 'facial_hair':
        pairs = [(PH_FHAIR_NAME, f'FacialHairColor/{name}'),
                 (PH_FHAIR, cat['preview_colour'])]
    elif cat['key'] == 'outfit':
        pairs = [(PH_OUTFIT_NAME, f'OutfitColor/{name}'),
                 (PH_OUTFIT, cat['preview_colour'])]
    else:
        return body
    for token, value in pairs:
        body = body.replace(token, value)
    return body


def split_segments(body):
    """Split a body into its top-level SVG shape elements.

    Returns a list of (segment, has_explicit_fill). A shape without an
    explicit `fill="..."` inherits the colour of its group, which is how the
    package's colour placeholders work; a shape with an explicit fill is a
    fixed overlay (shadow, highlight, white button, ...) and keeps it.
    """
    segs = []
    for m in SEG_RE.finditer(body):
        seg = m.group(0)
        has_fill = re.search(r'\bfill="', seg) is not None
        segs.append((seg, has_fill))
    return segs


# ===========================================================================
#  Per-category configuration
# ===========================================================================
CATEGORIES = []


def register(key, dart_file, enum_name, id_prefix, frame, colourable,
             placeholder=None, placeholder_name=None, preview_colour=None,
             base_fill=None, transform=None, extra_prefix=''):
    CATEGORIES.append(dict(
        key=key, dart_file=dart_file, enum_name=enum_name, id_prefix=id_prefix,
        frame=frame, colourable=colourable, placeholder=placeholder,
        placeholder_name=placeholder_name, preview_colour=preview_colour,
        base_fill=base_fill, transform=transform, extra_prefix=extra_prefix,
    ))


register('hair', 'hair_styles.dart', 'HairStyles', 'HairStyles/',
         'avatar', True, PH_HAIR, PH_HAIR_NAME, PREVIEW_HAIR)
register('facial_hair', 'facial_hair_types.dart', 'FacialHairTypes', 'FacialHair/',
         'face', True, PH_FHAIR, PH_FHAIR_NAME, PREVIEW_FHAIR)
register('eyebrows', 'eyebrows.dart', 'Eyebrows', 'Eyebrows/', 'face', False,
         base_fill='#000000')
register('eyes', 'eyes.dart', 'Eyes', 'Eyes/', 'face', False, base_fill='#000000', transform='translate(0,8)')
register('nose', 'noses.dart', 'Noses', 'Nose/', 'face', False, base_fill='#000000')
register('mouth', 'mouths.dart', 'Mouths', 'Mouth/', 'face', False, base_fill='#000000', transform='translate(2,52)')
register('outfit', 'outfit_types.dart', 'OutfitTypes', 'OutfitTypes/',
         'outfit', True, PH_OUTFIT, PH_OUTFIT_NAME, PREVIEW_OUTFIT)
register('accessories', 'accessories.dart', 'Accessories', 'Accessories/',
         'face', False, base_fill='#000000')
register('skin', 'skin_colors.dart', 'SkinColors', 'SkinColor/',
         'skin', False, base_fill='#FDDFC7')
register('background', 'background_style.dart', 'BackgroundStyles', 'Background/',
         'background', False, base_fill='#E6E6E6')


# ===========================================================================
#  Builders for the generated content
# ===========================================================================
def build_hair(items, colourable, ph, ph_name, preview_colour, base_fill):
    """Hair styles: coloured group + fixed overlays (shadow/highlight)."""
    out = []
    for name, body in items:
        segs = split_segments(clean(body))
        if not segs:
            # The package's own "Bald" entry carries an empty SVG, so the extra
            # "ShavedHead" entry does the same.
            out.append((name, ''))
            continue
        coloured = ''.join(s for s, has in segs if not has)
        overlays = ''.join(s for s, has in segs if has)
        inner = f'<g id="{ph_name}" fill="{ph}" fill-rule="evenodd">{coloured}</g>'
        out.append((name, (
            f'<g id="HairStyles/{name}" transform="translate(-1,0)">'
            f'{inner}{overlays}'
            f'</g>')))
    return out


def build_facial_hair(items, colourable, ph, ph_name, base_fill):
    out = []
    for name, body in items:
        segs = split_segments(clean(body))
        if not segs:
            out.append((name, ''))
            continue
        coloured = ''.join(s for s, has in segs if not has)
        overlays = ''.join(s for s, has in segs if has)
        inner = f'<g id="{ph_name}" fill="{ph}" fill-rule="evenodd">{coloured}</g>'
        out.append((name, (
            f'<g id="FacialHair/{name}" transform="translate(-28,-8)">'
            f'{inner}{overlays}'
            f'</g>')))
    return out


def build_simple(items, id_prefix, base_fill, transform=''):
    """Face-frame features: they inherit fill #000000 from the Face group."""
    out = []
    for name, body in items:
        body = clean(body)
        if not body:
            out.append((name, ''))
            continue
        out.append((name, f'<g id="{id_prefix}{name}" {transform}>{body}</g>'))
    return out


def build_outfit(items, colourable, ph, ph_name, base_fill):
    out = []
    for name, body in items:
        segs = split_segments(clean(body))
        if not segs:
            out.append((name, ''))
            continue
        coloured = ''.join(s for s, has in segs if not has)
        overlays = ''.join(s for s, has in segs if has)
        inner = f'<g id="{ph_name}" fill="{ph}" fill-rule="evenodd">{coloured}</g>'
        out.append((name, (
            f'<g id="OutfitTypes/{name}" transform="translate(0,170)">'
            f'{inner}{overlays}'
            f'</g>')))
    return out


def build_skin(items):
    out = []
    for name, body in items:
        out.append((name, clean(body)))
    return out


def build_background(items):
    """Background entries are drawn inside the circle background (path-1)."""
    out = []
    palettes = ['#65C9FF', '#7ED6A5', '#F6C667', '#E88C8C', '#B39DDB',
                '#7FB3D5', '#76D7C4', '#F1948A', '#85929E', '#AED6F1']
    for idx, (name, c1, c2) in enumerate(items):
        fam = idx // 5
        shape = ''
        if fam == 0:      # flat
            shape = f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />'
        elif fam == 1:    # diagonal band
            shape = (f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />'
                     f'<path d="M0,60 L240,180 L240,220 L0,100 Z" fill="{c2}" fill-opacity="0.55" />')
        elif fam == 2:    # radial dots
            shape = (f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />' +
                     ''.join(f'<circle cx="{40+((r*53+c*29) % 170)}" cy="{40+((r*37+c*41) % 170)}" '
                             f'r="9" fill="{c2}" fill-opacity="0.5" />'
                             for r in range(6) for c in range(6)))
        elif fam == 3:    # horizontal stripes
            shape = (f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />' +
                     ''.join(f'<rect x="0" y="{i*30}" width="240" height="14" fill="{c2}" fill-opacity="0.45" />'
                             for i in range(8)))
        elif fam == 4:    # vertical stripes
            shape = (f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />' +
                     ''.join(f'<rect x="{i*30}" y="0" width="14" height="240" fill="{c2}" fill-opacity="0.45" />'
                             for i in range(8)))
        elif fam == 5:    # checker
            shape = (f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />' +
                     ''.join(f'<rect x="{(r%2)*30}" y="{i*30}" width="30" height="30" fill="{c2}" fill-opacity="0.4" />'
                             for i in range(8) for r in range(8)))
        elif fam == 6:    # concentric rings
            shape = (f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />' +
                     ''.join(f'<circle cx="120" cy="120" r="{18+k*20}" fill="none" stroke="{c2}" '
                             f'stroke-width="8" stroke-opacity="0.5" />' for k in range(6)))
        elif fam == 7:    # triangles
            shape = (f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />' +
                     ''.join(f'<path d="M{(r%3)*80+20},{(r//3)*80+20} L{(r%3)*80+60},{(r//3)*80+80} '
                             f'L{(r%3)*80-20},{(r//3)*80+80} Z" fill="{c2}" fill-opacity="0.45" />'
                             for r in range(9)))
        elif fam == 8:    # waves
            shape = (f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />' +
                     ''.join(f'<path d="M0,{40+k*32} Q60,{20+k*32} 120,{40+k*32} T240,{40+k*32} '
                             f'L240,240 L0,240 Z" fill="{c2}" fill-opacity="0.28" />' for k in range(5)))
        else:             # blobs
            shape = (f'<rect x="0" y="0" width="240" height="240" fill="{c1}" />' +
                     ''.join(f'<ellipse cx="{50+(r*67)%170}" cy="{50+(c*53)%170}" rx="34" ry="24" '
                             f'fill="{c2}" fill-opacity="0.4" />' for r in range(4) for c in range(4)))
        out.append((name, (
            f'<g id="Background/{name}" stroke-width="1" fill-rule="evenodd" transform="translate(12,40)">'
            f'<mask id="am-bg-mask-{idx+1}" fill="white"><use xlink:href="#path-1"></use></mask>'
            f'<use id="Circle-Background" fill="#E6E6E6" xlink:href="#path-1"></use>'
            f'<g id="Background/{name}/Color" mask="url(#am-bg-mask-{idx+1})" fill="{c1}">'
            f'{shape}'
            f'</g></g>')))
    return out


# ===========================================================================
#  Generation
# ===========================================================================
def generate():
    import gen_pack_hair, gen_pack_features, gen_pack_outfit

    sources = {
        'hair': gen_pack_hair.hair_items(),
        'facial_hair': gen_pack_features.facial_hair_items(),
        'eyebrows': gen_pack_features.eyebrow_items(),
        'eyes': gen_pack_features.eye_items(),
        'nose': gen_pack_features.nose_items(),
        'mouth': gen_pack_features.mouth_items(),
        'outfit': gen_pack_outfit.outfit_items(),
        'accessories': gen_pack_features.accessory_items(),
        'skin': gen_pack_features.skin_items(),
    }

    # 50 distinct background variants: 10 pattern families x 5 colour rotations.
    bg_families = ['#65C9FF', '#7ED6A5', '#F6C667', '#E88C8C', '#B39DDB']
    backgrounds = []
    for fi in range(10):
        for vi in range(5):
            c = bg_families[(fi + vi) % len(bg_families)]
            c2 = bg_families[(fi + vi + 2) % len(bg_families)]
            backgrounds.append((f'Pattern{fi+1}{vi+1}', c, c2))
    sources['background'] = backgrounds

    built = {}
    for cat in CATEGORIES:
        key = cat['key']
        items = sources[key]
        if key == 'hair':
            built[key] = build_hair(items, True, PH_HAIR, PH_HAIR_NAME,
                                     PREVIEW_HAIR, '#E6E6E6')
        elif key == 'facial_hair':
            built[key] = build_facial_hair(items, True, PH_FHAIR, PH_FHAIR_NAME,
                                           '#E6E6E6')
        elif key == 'outfit':
            built[key] = build_outfit(items, True, PH_OUTFIT, PH_OUTFIT_NAME,
                                      '#E6E6E6')
        elif key == 'skin':
            built[key] = build_skin(items)
        elif key == 'background':
            built[key] = build_background(items)
        elif key == 'eyebrows':
            built[key] = build_simple(items, 'Eyebrows/', '#000000', cat['transform'])
        elif key == 'eyes':
            built[key] = build_simple(items, 'Eyes/', '#000000', cat['transform'])
        elif key == 'nose':
            built[key] = build_simple(items, 'Nose/', '#000000', cat['transform'])
        elif key == 'mouth':
            built[key] = build_simple(items, 'Mouth/', '#000000', cat['transform'])
        elif key == 'accessories':
            built[key] = build_simple(items, 'Accessories/', '#000000', cat['transform'])
        cat['items'] = built[key]
        cat['count'] = len(built[key])

    return built


# ===========================================================================
#  Writers
# ===========================================================================
def write_svg_packs():
    """Standalone preview SVGs with concrete colours (no placeholders)."""
    for cat in CATEGORIES:
        key = cat['key']
        items = cat['items']
        parts = []
        for name, body in items:
            b = body
            if cat['colourable']:
                b = resolve_placeholders(b, name, cat)
            parts.append(f'  {b}')

        if key == 'skin':
            head = ('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" '
                    'viewBox="0 0 264 280" width="264" height="280">\n'
                    '  <defs>\n'
                    '    <path d="M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 '
                    'L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 '
                    'L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 '
                    'C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 '
                    'L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 '
                    'C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 '
                    'C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 '
                    'C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z" id="path-5"></path>\n'
                    '  </defs>\n'
                    '  <g id="Body" transform="translate(32,36)">\n'
                    '    <mask id="mask-6" fill="white"><use xlink:href="#path-5"></use></mask>\n'
                    '    <use fill="#D0C6AC" xlink:href="#path-5"></use>\n')
            tail = '  </g>\n</svg>\n'
            parts = ['  ' + p for p in parts]
            content = head + '\n'.join(parts) + '\n' + tail
        elif key == 'background':
            head = ('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" '
                    'viewBox="0 0 264 280" width="264" height="280">\n'
                    '  <defs>\n'
                    '    <circle id="path-1" cx="120" cy="120" r="120"></circle>\n'
                    '  </defs>\n')
            content = head + '\n'.join(parts) + '\n</svg>\n'
        else:
            head = ('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" '
                    'viewBox="0 0 264 280" width="264" height="280">\n')
            content = head + '\n'.join(parts) + '\n</svg>\n'

        path = os.path.join(SVG_OUT, f'{key}_50.svg')
        with open(path, 'w', encoding='utf-8') as fh:
            fh.write(content)
        print(f'  assets/icons/{key}_50.svg  ({cat["count"]} items, {os.path.getsize(path)} bytes)')


def write_dart():
    """Emit enum entries ready to paste into the package's property_items files."""
    header = {
        'hair': ('import "package:avatar_maker/src/core/enums/placeholders.dart";\n\n'
                 '/// 50 additional hair styles contributed as SVG assets.\n'
                 '///\n'
                 '/// Every entry keeps the colour placeholder so the HairColor\n'
                 '/// category keeps working exactly like the built-in styles.\n'
                 'enum HairStylesExtra implements PropertyItem {'),
        'facial_hair': ('import "package:avatar_maker/src/core/enums/placeholders.dart";\n\n'
                        '/// 50 additional facial-hair styles contributed as SVG assets.\n'
                        'enum FacialHairTypesExtra implements PropertyItem {'),
        'eyebrows': '/// 50 additional eyebrow styles contributed as SVG assets.\nenum EyebrowsExtra implements PropertyItem {',
        'eyes': '/// 50 additional eye styles contributed as SVG assets.\nenum EyesExtra implements PropertyItem {',
        'nose': '/// 50 additional nose styles contributed as SVG assets.\nenum NosesExtra implements PropertyItem {',
        'mouth': '/// 50 additional mouth styles contributed as SVG assets.\nenum MouthsExtra implements PropertyItem {',
        'outfit': ('import "package:avatar_maker/src/core/enums/placeholders.dart";\n\n'
                   '/// 50 additional outfits contributed as SVG assets.\n'
                   'enum OutfitTypesExtra implements PropertyItem {'),
        'accessories': '/// 50 additional accessories contributed as SVG assets.\nenum AccessoriesExtra implements PropertyItem {',
        'skin': '/// 50 additional skin tones contributed as SVG assets.\nenum SkinColorsExtra implements PropertyItem {',
        'background': '/// 50 additional background styles contributed as SVG assets.\nenum BackgroundStylesExtra implements PropertyItem {',
    }
    footer = {
        'hair': ('\n  final String svg;\n\n  const HairStylesExtra(this.svg);\n\n'
                 '  String get label => name;\n  String get id => "HairStyles/$name";\n  String get value => svg;\n}\n'),
        'facial_hair': ('\n  final String svg;\n\n  const FacialHairTypesExtra(this.svg);\n\n'
                        '  String get label => name;\n  String get id => "FacialHair/$name";\n  String get value => svg;\n}\n'),
        'eyebrows': ('\n  final String svg;\n\n  const EyebrowsExtra(this.svg);\n\n'
                     '  String get label => name;\n  String get id => "Eyebrows/$name";\n  String get value => svg;\n}\n'),
        'eyes': ('\n  final String svg;\n\n  const EyesExtra(this.svg);\n\n'
                 '  String get label => name;\n  String get id => "Eyes/$name";\n  String get value => svg;\n}\n'),
        'nose': ('\n  final String svg;\n\n  const NosesExtra(this.svg);\n\n'
                 '  String get label => name;\n  String get id => "Nose/$name";\n  String get value => svg;\n}\n'),
        'mouth': ('\n  final String svg;\n\n  const MouthsExtra(this.svg);\n\n'
                  '  String get label => name;\n  String get id => "Mouth/$name";\n  String get value => svg;\n}\n'),
        'outfit': ('\n  final String svg;\n\n  const OutfitTypesExtra(this.svg);\n\n'
                   '  String get label => name;\n  String get id => "OutfitTypes/$name";\n  String get value => svg;\n}\n'),
        'accessories': ('\n  final String svg;\n\n  const AccessoriesExtra(this.svg);\n\n'
                        '  String get label => name;\n  String get id => "Accessories/$name";\n  String get value => svg;\n}\n'),
        'skin': ('\n  final String svg;\n\n  const SkinColorsExtra(this.svg);\n\n'
                 '  String get label => name;\n  String get id => "SkinColor/$name";\n  String get value => svg;\n}\n'),
        'background': ('\n  final String svg;\n\n  const BackgroundStylesExtra(this.svg);\n\n'
                       '  String get label => name;\n  String get id => "Background/$name";\n  String get value => svg;\n}\n'),
    }
    # The enum values list is terminated by ";" - the footers continue the
    # enum body, so they must not add another one.
    imports = {
        'hair': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
        'facial_hair': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
        'eyebrows': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
        'eyes': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
        'nose': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
        'mouth': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
        'outfit': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
        'accessories': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
        'skin': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
        'background': 'import "package:avatar_maker/src/core/models/property_item.dart";\n',
    }

    # The placeholders are emitted as Dart interpolations ("$TO_REPLACE_WITH_...")
    # so that the constants from placeholders.dart are substituted at compile
    # time - exactly how the built-in assets do it.
    sentinel_map = [
        (PH_HAIR_NAME, '\x01HAIR_NAME\x01'),
        (PH_HAIR, '\x01HAIR\x01'),
        (PH_FHAIR_NAME, '\x01FHAIR_NAME\x01'),
        (PH_FHAIR, '\x01FHAIR\x01'),
        (PH_OUTFIT_NAME, '\x01OUTFIT_NAME\x01'),
        (PH_OUTFIT, '\x01OUTFIT\x01'),
    ]

    for cat in CATEGORIES:
        key = cat['key']
        lines = [imports[key], header[key]]
        entries = []
        for name, body in cat['items']:
            # Dart triple-quoted string: " and $ must be escaped.
            esc = body.replace('\\', '\\\\').replace('"', r'\"').replace('$', r'\$')
            esc = esc.replace('\n', ' ')
            # Protect the colour placeholders, then restore them as
            # interpolations of the constants in placeholders.dart.
            for token, sentinel in sentinel_map:
                esc = esc.replace(token, sentinel)
            for token, sentinel in sentinel_map:
                esc = esc.replace(sentinel, '$' + token)
            entries.append(f'  {name}("""{esc}""")')
        lines.append(',\n'.join(entries) + ';')
        lines.append(footer[key])
        content = '\n'.join(lines)
        path = os.path.join(DART_OUT, f'{key}_50.dart')
        with open(path, 'w', encoding='utf-8') as fh:
            fh.write(content)
        print(f'  lib/.../property_items/generated/{key}_50.dart  ({cat["count"]} items, {os.path.getsize(path)} bytes)')


def write_preview_html():
    """One self-contained HTML page with every item inlined."""
    sections = []
    for cat in CATEGORIES:
        key = cat['key']
        cards = []
        for name, body in cat['items']:
            b = body
            if cat['colourable']:
                b = resolve_placeholders(b, name, cat)
            # A mini SVG per item, framed exactly like the package renders it.
            if key == 'skin':
                mini = (f'<svg viewBox="0 0 264 280" class="mini">'
                        f'<g transform="translate(32,36)">'
                        f'<use fill="#D0C6AC" xlink:href="#path-5"></use>{b}</g></svg>')
            elif key == 'background':
                mini = f'<svg viewBox="0 0 264 280" class="mini">{b}</svg>'
            elif key in ('facial_hair', 'eyebrows', 'eyes', 'nose', 'mouth',
                         'accessories'):
                # Face features live in the <g id="Face" transform="translate(76,82)">
                # frame and inherit fill #000000.
                mini = (f'<svg viewBox="0 0 264 280" class="mini">'
                        f'<g transform="translate(76,82)" fill="#000000">{b}</g></svg>')
            else:
                mini = f'<svg viewBox="0 0 264 280" class="mini">{b}</svg>'
            cards.append(f'<figure class="card">{mini}<figcaption>{html.escape(name)}</figcaption></figure>')

        sections.append(
            f'<section><h2>{html.escape(cat["enum_name"])} '
            f'<span class="count">{cat["count"]} items</span></h2>'
            f'<div class="grid">{"".join(cards)}</div></section>')

    doc = f'''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>avatar_maker - 50 styles per category</title>
<style>
  :root {{ color-scheme: light; }}
  body {{ margin:0; padding:24px; background:#f4f5f7; font:14px/1.5 system-ui,-apple-system,"Segoe UI",Roboto,sans-serif; color:#2b2d42; }}
  header {{ max-width:1200px; margin:0 auto 24px; }}
  h1 {{ margin:0 0 6px; font-size:22px; letter-spacing:-0.01em; }}
  header p {{ margin:0; color:#6b7280; }}
  section {{ max-width:1200px; margin:0 auto 28px; background:#fff; border-radius:14px; padding:18px 20px 22px; box-shadow:0 1px 3px rgba(16,24,40,.06),0 8px 24px rgba(16,24,40,.04); }}
  h2 {{ margin:0 0 14px; font-size:15px; font-weight:650; text-transform:none; border-bottom:1px solid #eef0f3; padding-bottom:10px; }}
  .count {{ color:#9aa3af; font-weight:400; font-size:13px; margin-left:8px; }}
  .grid {{ display:grid; grid-template-columns:repeat(auto-fill,minmax(104px,1fr)); gap:10px; }}
  .card {{ margin:0; background:#fafbfc; border:1px solid #eef0f3; border-radius:10px; padding:6px; text-align:center; }}
  svg.mini {{ display:block; width:100%; height:auto; aspect-ratio:264/280; }}
  figcaption {{ font-size:10.5px; color:#6b7280; margin-top:4px; overflow-wrap:anywhere; }}
</style>
</head>
<body>
<header>
  <h1>avatar_maker &mdash; 50 distinct styles per category</h1>
  <p>Every item is a different shape, not a colour variation. Hair, facial hair and outfits
     keep the package colour placeholders, so the existing colour pickers still apply.</p>
</header>
<svg width="0" height="0" style="position:absolute" aria-hidden="true"><defs>
<path d="M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z" id="path-5"/>
</defs></svg>
{"".join(sections)}
</body>
</html>
'''
    path = os.path.join(SVG_OUT, 'preview_50.html')
    with open(path, 'w', encoding='utf-8') as fh:
        fh.write(doc)
    print(f'  assets/icons/preview_50.html  ({os.path.getsize(path)} bytes)')


def write_readme():
    doc = '''# avatar_maker - 50 additional styles per category

Each category ships **50 distinct shapes**. Colours are *not* baked into the
style variants: for hair, facial hair and outfits the assets reuse the
package's existing colour placeholders, so `HairColor`, `FacialHairColor` and
`OutfitColor` keep working unchanged.

## Files

| Category | Preview SVG | Dart entries | Merge into |
|---|---|---|---|
| Hair | `assets/icons/hair_50.svg` | `lib/src/core/enums/property_items/generated/hair_50.dart` | `property_items/hair_styles.dart` |
| Facial hair | `assets/icons/facial_hair_50.svg` | `lib/src/core/enums/property_items/generated/facial_hair_50.dart` | `property_items/facial_hair_types.dart` |
| Eyebrows | `assets/icons/eyebrows_50.svg` | `lib/src/core/enums/property_items/generated/eyebrows_50.dart` | `property_items/eyebrows.dart` |
| Eyes | `assets/icons/eyes_50.svg` | `lib/src/core/enums/property_items/generated/eyes_50.dart` | `property_items/eyes.dart` |
| Nose | `assets/icons/nose_50.svg` | `lib/src/core/enums/property_items/generated/nose_50.dart` | `property_items/noses.dart` |
| Mouth | `assets/icons/mouth_50.svg` | `lib/src/core/enums/property_items/generated/mouth_50.dart` | `property_items/mouths.dart` |
| Outfit | `assets/icons/outfit_50.svg` | `lib/src/core/enums/property_items/generated/outfit_50.dart` | `property_items/outfit_types.dart` |
| Accessories | `assets/icons/accessories_50.svg` | `lib/src/core/enums/property_items/generated/accessories_50.dart` | `property_items/accessories.dart` |
| Skin | `assets/icons/skin_50.svg` | `lib/src/core/enums/property_items/generated/skin_50.dart` | `property_items/skin_colors.dart` |
| Background | `assets/icons/background_50.svg` | `lib/src/core/enums/property_items/generated/background_50.dart` | `property_items/background_style.dart` |

The Dart files are plain enums that implement `PropertyItem`, so they can be
merged into the built-in enums or exposed as extra categories. They live
under `lib/` so they are importable and testable right away:

```dart
import 'package:avatar_maker/src/core/enums/property_items/generated/hair_50.dart';
```

Open `assets/icons/preview_50.html` in a browser to see all items.

## Coordinate frames

The assets follow the frames the package renders in
(`lib/src/core/services/avatar_service.dart`):

* **Avatar frame** - `264x280`, head centre `x=132`, head top `y=36`,
  ear line `y=110`, jaw `y=181`. Hair and outfits live here.
* **Face frame** - the `<g id="Face" transform="translate(76,82)">` group:
  face centre `x=56`, eyes at `(30,30)` and `(82,30)`, brows `x 11..43` /
  `69..101`, nose `x 44..68`, mouth `x 42..70`. Facial hair, eyebrows, eyes,
  nose, mouth and accessories live here and inherit `fill="#000000"`.
* **Outfit frame** - the outfit group is translated by `(0,170)`.

## Colour placeholders

Hair, facial hair and outfits use the same mechanism as the built-in assets:

```dart
<g id="$TO_REPLACE_WITH_HAIRS_COLOR_NAME" mask="url(#am-hair-mask-1)" fill="$TO_REPLACE_WITH_HAIRS_COLOR">
```

`HairService.generateHairStyle` / `FacialHairsService.generateFacialHair` /
`OutfitService.generateOutfit` already replace both tokens, and
`AvatarService.extractPropertiesFromSvg` can read the selected colour back.

## flutter_svg compatibility

* No `<style>` blocks - every colour is an inline attribute or a
  `fill="..."` on a `<use>`/`<path>`.
* Only `path`, `circle`, `ellipse`, `rect`, `g`, `defs`, `mask`, `use` are
  used, all of which `flutter_svg` supports.
* `xlink:href` is used on `<use>` elements, matching the built-in assets.
'''
    path = os.path.join(ROOT, 'contrib', 'README.md')
    os.makedirs(os.path.join(ROOT, 'contrib'), exist_ok=True)
    with open(path, 'w', encoding='utf-8') as fh:
        fh.write(doc)
    print(f'  contrib/README.md')


if __name__ == '__main__':
    print('Generating...')
    generate()
    print('SVG packs:')
    write_svg_packs()
    print('Dart entries:')
    write_dart()
    print('Preview:')
    write_preview_html()
    write_readme()
    print('Done.')
