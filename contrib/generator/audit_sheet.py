"""
Renders EVERY generated item on its own, one card per item, grouped by
category, using the exact AvatarService.drawSVG frame. This is the visual
audit sheet used to spot offset / quality problems item by item.

Usage:
    python audit_sheet.py                 -> all categories
    python audit_sheet.py hair outfit     -> only those categories
Output:
    C:\\Projeler\\audit_<category>.html
"""

import io, os, re, sys, html

ICONS = r'C:\Projeler\avatar_maker\assets\icons'
OUTDIR = r'C:\Projeler'

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

# category key -> (file, prefix, mode)
#   mode 'avatar'  : item is drawn alone in its real slot on the avatar
#   mode 'bg'      : item replaces $backgroundStyle
CATS = {
    'hair':     ('hair_50.svg',        'HairStyles/',   'avatar'),
    'facial':   ('facial_hair_50.svg', 'FacialHair/',   'avatar'),
    'eyebrows': ('eyebrows_50.svg',    'Eyebrows/',     'avatar'),
    'eyes':     ('eyes_50.svg',        'Eyes/',         'avatar'),
    'nose':     ('nose_50.svg',        'Nose/',         'avatar'),
    'mouth':    ('mouth_50.svg',       'Mouth/',        'avatar'),
    'outfit':   ('outfit_50.svg',      'OutfitTypes/',  'avatar'),
    'access':   ('accessories_50.svg', 'Accessories/',  'avatar'),
    'skin':     ('skin_50.svg',        'SkinColors/',   'skin'),
    'back':     ('background_50.svg',  'BackgroundStyles/', 'bg'),
}

# colour substitutions so nothing is a flat black blob
HAIR_C = ['#2C1B18', '#724133', '#B58143', '#C93305', '#4A312C', '#8E24AA']
FH_C   = ['#252E32', '#331B0C', '#4A312C', '#212529', '#5C3A21', '#1D1E2C']
OUT_C  = ['#65C9FF', '#7ED6A5', '#F6C667', '#E88C8C', '#B39DDB', '#2A6F97', '#E76F51', '#45B7D1']
SKIN_C = ['#FD9841', '#FFDBB4', '#EDB98A', '#D08B5B', '#AE5D29', '#614335']


def load(fn, prefix):
    """[{name: body}] for every <g id="prefixName"> in the file, depth-aware."""
    s = io.open(os.path.join(ICONS, fn), encoding='utf-8').read()
    out = []
    pat = re.compile(r'<g\b[^>]*\bid="' + re.escape(prefix) + r'([^"]+)"[^>]*>')
    tag = re.compile(r'<g\b[^>]*>|</g>')
    pos = 0
    while True:
        m = pat.search(s, pos)
        if not m:
            break
        depth = 0
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
        out.append((m.group(1), s[m.start():end]))
        pos = end
    return out


def svg_open():
    return ('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" '
            'viewBox="0 0 264 280" width="264" height="280">'
            '<defs>'
            '<circle id="path-1" cx="120" cy="120" r="120"></circle>'
            f'<path d="{BODY_PATH}" id="path-3"></path>'
            f'<path d="{HEAD_PATH}" id="path-5"></path>'
            '</defs>')


DEFAULT_HEAD = (
    '<g id="Body" transform="translate(32,36)">'
    '<mask id="mask-6" fill="white"><use xlink:href="#path-5"></use></mask>'
    '<use fill="#D0C6AC" xlink:href="#path-5"></use>'
    '<g id="SkinColor/X" mask="url(#mask-6)" fill="#EDB98A"><rect x="0" y="0" width="264" height="280"></rect></g>'
    '</g>')


def frame_face(inner):
    """Wraps face-slot content the way AvatarService does."""
    return ('<g id="Body" transform="translate(32,36)">'
            '<mask id="mask-6" fill="white"><use xlink:href="#path-5"></use></mask>'
            '<use fill="#D0C6AC" xlink:href="#path-5"></use>'
            '<g id="SkinColor/X" mask="url(#mask-6)" fill="#EDB98A"><rect x="0" y="0" width="264" height="280"></rect></g>'
            '</g>'
            f'<g id="Face" transform="translate(76,82)" fill="#000000">{inner}</g>')


def card_svg(cat, body, i):
    """One avatar showing exactly one item of `cat`."""
    o = svg_open()
    o += '<g id="AvatarMaker" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">'
    if cat == 'hair':
        o += DEFAULT_HEAD
        o += '<g id="Face" transform="translate(76,82)" fill="#000000">'
        # a neutral face so the hair can be judged against it
        o += ('<g id="Mouth/X"><path d="M63,79 C63,79 66,82 66,82 C66,82 69,79 69,79 C69,79 66,76 66,76 '
              'C66,76 63,79 63,79 Z"></path></g>')
        o += ('<g id="Eyes/X"><circle cx="30" cy="30" r="6"></circle><circle cx="82" cy="30" r="6"></circle></g>')
        o += '</g>'
        o += body.replace('#2C1B18', HAIR_C[i % len(HAIR_C)])
    elif cat == 'facial':
        o += frame_face(body.replace('#252E32', FH_C[i % len(FH_C)]) +
                        '<g id="Mouth/Y"><path d="M63,79 C63,79 66,82 66,82 C66,82 69,79 69,79 C69,79 66,76 66,76 '
                        'C66,76 63,79 63,79 Z"></path></g>')
    elif cat in ('eyes', 'eyebrows', 'nose', 'mouth', 'access'):
        o += frame_face(body)
    elif cat == 'outfit':
        o += DEFAULT_HEAD + body.replace('#5BC0DE', OUT_C[i % len(OUT_C)])
    elif cat == 'skin':
        o += ('<g id="Body" transform="translate(32,36)">'
              '<mask id="mask-6" fill="white"><use xlink:href="#path-5"></use></mask>'
              '<use fill="#D0C6AC" xlink:href="#path-5"></use>' + body + '</g>')
    elif cat == 'back':
        o += body
    o += '</g></svg>'
    return o


def default_bg():
    return '<rect width="264" height="280" fill="#FFFFFF"></rect>'


def main():
    want = sys.argv[1:] or list(CATS)
    for cat in want:
        if cat not in CATS:
            print('unknown category', cat)
            continue
        fn, prefix, mode = CATS[cat]
        items = load(fn, prefix)
        cards = []
        for i, (name, body) in enumerate(items):
            cards.append(
                f'<figure>'
                f'<div class="cp">{card_svg(cat, body, i)}</div>'
                f'<figcaption><b>{html.escape(name)}</b><br>{i + 1}/{len(items)}</figcaption>'
                f'</figure>')
        doc = f'''<!DOCTYPE html><html><head><meta charset="utf-8"><title>{cat} audit</title><style>
body{{font-family:system-ui;background:#1b1b1f;color:#eee;padding:12px;margin:0}}
h1{{font-size:16px;font-weight:600}}
.grid{{display:grid;grid-template-columns:repeat(auto-fill,minmax(150px,1fr));gap:10px}}
figure{{margin:0;background:#2b2b31;border-radius:10px;padding:6px;text-align:center}}
svg{{width:100%;height:auto;display:block;background:#f5f3f1;border-radius:6px}}
.cp{{position:relative}}
figcaption{{font-size:10px;color:#bbb;margin-top:4px;overflow-wrap:anywhere}}
</style></head><body>
<h1>{cat} &mdash; {len(items)} items, one per card</h1>
<div class="grid">{"".join(cards)}</div></body></html>'''
        out = os.path.join(OUTDIR, f'audit_{cat}.html')
        io.open(out, 'w', encoding='utf-8').write(doc)
        print(f'{cat:<9} {len(items):>4} items -> {out}')


if __name__ == '__main__':
    main()
