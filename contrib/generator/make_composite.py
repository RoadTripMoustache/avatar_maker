"""
Builds a composite preview that mirrors AvatarService.drawSVG exactly, so the
assets can be checked against the real head silhouette without a device.

Usage: python make_composite.py  ->  C:\\Projeler\\composite.html
"""

import re, os, io, html

OUT = r'C:\Projeler\composite.html'

BODY_PATH = ("M12,160 C12,226.27417 65.72583,280 132,280 C198.27417,280 252,226.27417 252,160 "
             "L264,160 L264,-1.42108547e-14 L-3.19744231e-14,-1.42108547e-14 L-3.19744231e-14,160 L12,160 Z")
HEAD_PATH = ("M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 "
             "L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 "
             "L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 "
             "C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 "
             "L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 "
             "C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 "
             "C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 "
             "155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z")

ICONS = r'C:\Projeler\avatar_maker\assets\icons'

HAIR_C = ['#2C1B18', '#724133', '#B58143', '#C93305', '#4A312C', '#8E24AA']
FH_C = ['#252E32', '#331B0C', '#4A312C', '#212529', '#5C3A21', '#1D1E2C']
OUT_C = ['#65C9FF', '#7ED6A5', '#F6C667', '#E88C8C', '#B39DDB', '#2A6F97', '#E76F51', '#45B7D1']
SKIN_C = ['#FD9841', '#FFDBB4', '#EDB98A', '#D08B5B', '#AE5D29', '#614335']


def load(fn, prefix):
    """Returns [(name, body)] for the items of a category SVG file."""
    path = os.path.join(ICONS, fn)
    s = io.open(path, encoding='utf-8').read()
    out = []
    i = 0
    pat = re.compile(r'<g id="' + re.escape(prefix) + r'([^"]+)"')
    tag = re.compile(r'<g\b[^>]*>|</g>')
    while True:
        m = pat.search(s, i)
        if not m:
            break
        name = m.group(1)
        start = m.start()
        # Depth-aware scan for the matching </g>.
        depth = 0
        pos = m.start()
        end = None
        for t in tag.finditer(s, m.start()):
            if t.group(0) == '</g>':
                depth -= 1
                if depth == 0:
                    end = t.end()
                    break
            else:
                depth += 1
        if end is None:
            end = len(s)
        out.append((name, s[start:end]))
        i = end
    return out


def avatar(hair, fh, brows, eyes, nose, mouth, outfit, acc, skin):
    return ('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" '
            'viewBox="0 0 264 280" width="264" height="280">'
            '<defs>'
            f'<circle id="path-1" cx="120" cy="120" r="120"></circle>'
            f'<path d="{BODY_PATH}" id="path-3"></path>'
            f'<path d="{HEAD_PATH}" id="path-5"></path>'
            '</defs>'
            '<g id="AvatarMaker" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">'
            '<g id="Body" transform="translate(32,36)">'
            '<mask id="mask-6" fill="white"><use xlink:href="#path-5"></use></mask>'
            '<use fill="#D0C6AC" xlink:href="#path-5"></use>'
            f'<g id="SkinColor/X" mask="url(#mask-6)" fill="{skin}">'
            '<rect x="0" y="0" width="264" height="280"></rect></g>'
            '</g>'
            f'{outfit}'
            '<g id="Face" transform="translate(76,82)" fill="#000000">'
            f'{mouth}{fh}{nose}{eyes}{brows}{acc}'
            '</g>'
            f'{hair}'
            '</g></svg>')


def main():
    hair = load('hair_50.svg', 'HairStyles/')
    fh = load('facial_hair_50.svg', 'FacialHair/')
    brows = load('eyebrows_50.svg', 'Eyebrows/')
    eyes = load('eyes_50.svg', 'Eyes/')
    nose = load('nose_50.svg', 'Nose/')
    mouth = load('mouth_50.svg', 'Mouth/')
    outfit = load('outfit_50.svg', 'OutfitTypes/')
    acc = load('accessories_50.svg', 'Accessories/')

    print({k: len(v) for k, v in
           [('hair', hair), ('fh', fh), ('brows', brows), ('eyes', eyes),
            ('nose', nose), ('mouth', mouth), ('outfit', outfit), ('acc', acc)]})

    cards = []
    for i in range(60):
        h = hair[i % len(hair)]
        f = fh[(i * 7) % len(fh)]
        b = brows[(i * 5) % len(brows)]
        e = eyes[(i * 11) % len(eyes)]
        n = nose[(i * 13) % len(nose)]
        m = mouth[(i * 17) % len(mouth)]
        o = outfit[(i * 19) % len(outfit)]
        a = acc[(i * 23) % len(acc)]

        hair_svg = h[1].replace('#2C1B18', HAIR_C[i % len(HAIR_C)])
        fh_svg = f[1].replace('#252E32', FH_C[i % len(FH_C)])
        out_svg = o[1].replace('#5BC0DE', OUT_C[i % len(OUT_C)])

        cards.append(
            f'<figure>{avatar(hair_svg, fh_svg, b[1], e[1], n[1], m[1], out_svg, a[1], SKIN_C[i % len(SKIN_C)])}'
            f'<figcaption>{html.escape(h[0])}</figcaption></figure>')

    doc = f'''<!DOCTYPE html><html><head><meta charset="utf-8"><style>
body{{font-family:system-ui;background:#eee;padding:12px;margin:0}}
.grid{{display:grid;grid-template-columns:repeat(auto-fill,minmax(130px,1fr));gap:8px}}
figure{{margin:0;background:#F3F1EE;border-radius:8px;padding:4px;text-align:center}}
svg{{width:100%;height:auto;display:block}}
figcaption{{font-size:9px;color:#666;margin-top:2px;overflow-wrap:anywhere}}
</style></head><body><div class="grid">{"".join(cards)}</div></body></html>'''

    io.open(OUT, 'w', encoding='utf-8').write(doc)
    print('written', OUT, len(doc))


if __name__ == '__main__':
    main()
