"""Audit sheet v2 -- renders EVERY generated item exactly the way
AvatarService.drawSVG does, using the item's own wrapper group from the merged
enum. Reference frames are taken from the built-in assets, not guessed.

Usage:
    python audit2.py                 -> every category
    python audit2.py hair eyes mouth -> only these
Output:
    C:\\Projeler\\audit2_<cat>.html
"""

import io, os, re, sys, html

PROP = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items'
OUTDIR = r'C:\Projeler'

HEAD_PATH = ("M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 "
             "L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 "
             "L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 "
             "C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 "
             "L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 "
             "C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 "
             "C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 "
             "155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z")

# category -> enum file, item id prefix
CATS = {
    'hair':    ('hair_styles.dart', 'HairStyles/'),
    'facial':  ('facial_hair_types.dart', 'FacialHair/'),
    'eyebrows': ('eyebrows.dart', 'Eyebrows/'),
    'eyes':    ('eyes.dart', 'Eyes/'),
    'nose':    ('noses.dart', 'Nose/'),
    'mouth':   ('mouths.dart', 'Mouth/'),
    'outfit':  ('outfit_types.dart', 'OutfitTypes/'),
    'access':  ('accessories.dart', 'Accessories/'),
    'skin':    ('skin_colors.dart', 'SkinColor/'),
}

IT = re.compile(r'^  ([A-Za-z_][A-Za-z0-9_]*)\(\s*(?:"""(.*?)"""|"([^"]*)")', re.S | re.M)

# placeholder tokens -> a concrete preview value (only for the audit sheet)
PREVIEW = {
    '$TO_REPLACE_WITH_HAIRS_COLOR_NAME': 'HairColor/X',
    '$TO_REPLACE_WITH_FACIAL_HAIRS_COLOR_NAME': 'FacialHairColor/X',
    '$TO_REPLACE_WITH_OUTFIT_COLOR_NAME': 'OutfitColor/X',
    '$TO_REPLACE_WITH_HAIRS_COLOR': '#6B4A32',
    '$TO_REPLACE_WITH_FACIAL_HAIRS_COLOR': '#3A2A20',
    '$TO_REPLACE_WITH_OUTFIT_COLOR': '#5B9BD5',
    '$TO_REPLACE_WITH_SKIN_COLOR_NAME': 'SkinColor/X',
    '$TO_REPLACE_WITH_SKIN_COLOR': '#EDB98A',
}


def load(fn):
    p = os.path.join(PROP, fn)
    s = io.open(p, encoding='utf-8', newline='').read()
    out = []
    for m in IT.finditer(s):
        name = m.group(1)
        body = m.group(2) if m.group(2) is not None else (m.group(3) or '')
        out.append((name, body))
    return out


def preview(body):
    for k, v in PREVIEW.items():
        body = body.replace(k, v)
    return body


def head_group():
    return ('<defs>'
            f'<path d="{HEAD_PATH}" id="path-5"></path>'
            '<circle id="path-1" cx="120" cy="120" r="120"></circle>'
            '</defs>'
            '<g id="Body" transform="translate(32,36)">'
            '<mask id="mask-6" fill="white"><use xlink:href="#path-5"></use></mask>'
            '<use fill="#D0C6AC" xlink:href="#path-5"></use>'
            '<g id="skin" mask="url(#mask-6)" fill="#EDB98A"><rect x="0" y="0" width="264" height="280"></rect></g>'
            '</g>')


def hair_default():
    return ('<g id="HairStyles/X" transform="translate(-1,0)">'
            '<path d="M61,44 C58,88 90,36 132,36 C174,36 206,88 203,44 '
            'C202,120 203,110 199,90 C160,86 104,86 65,90 C61,110 62,120 61,44 Z" '
            'fill="#6B4A32" /></g>')


def face_default():
    return ('<g id="Face" transform="translate(76,82)" fill="#000000">'
            '<g id="Eyes/X"><circle cx="30" cy="30" r="6"/><circle cx="82" cy="30" r="6"/></g>'
            '</g>')


def svg_for(cat, body):
    b = preview(body)
    o = ('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" '
         'viewBox="0 0 264 280" width="264" height="280">')
    if cat == 'skin':
        o += head_group().replace(
            '<g id="skin" mask="url(#mask-6)" fill="#EDB98A"><rect x="0" y="0" width="264" height="280"></rect></g>',
            b)
        return o + '</svg>'
    if cat == 'hair':
        o += head_group() + face_default() + b
    elif cat == 'outfit':
        o += head_group() + b + face_default()
    else:
        # facial, eyebrows, eyes, nose, mouth, access -> inside Face group
        o += head_group() + hair_default() + face_default().replace('</g>', '') + b + '</g>'
    return o + '</svg>'


def main():
    want = sys.argv[1:] or list(CATS)
    for cat in want:
        if cat not in CATS:
            print('unknown', cat)
            continue
        fn, pref = CATS[cat]
        items = load(fn)
        cards = []
        for i, (name, body) in enumerate(items):
            cards.append(
                '<figure>'
                f'<div class="cp">{svg_for(cat, body)}</div>'
                f'<figcaption><b>{html.escape(name)}</b><br>{i+1}/{len(items)}</figcaption>'
                '</figure>')
        doc = f'''<!DOCTYPE html><html><head><meta charset="utf-8"><title>{cat}</title><style>
body{{font-family:system-ui;background:#17171b;color:#eee;padding:14px;margin:0}}
h1{{font-size:16px}}
.grid{{display:grid;grid-template-columns:repeat(auto-fill,minmax(158px,1fr));gap:10px}}
figure{{margin:0;background:#242429;border-radius:10px;padding:6px;text-align:center}}
svg{{width:100%;height:auto;background:#f7f5f2;border-radius:8px}}
figcaption{{font-size:10px;color:#aab;margin-top:4px;overflow-wrap:anywhere}}
</style></head><body><h1>{cat} &mdash; {len(items)} items</h1>
<div class="grid">{"".join(cards)}</div></body></html>'''
        out = os.path.join(OUTDIR, f'audit2_{cat}.html')
        io.open(out, 'w', encoding='utf-8').write(doc)
        print(f'{cat:<9} {len(items):>4} -> {out}')


if __name__ == '__main__':
    main()
