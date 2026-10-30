import io, os, re, html

SRC = r'C:\Projeler\avatar_maker\assets\icons'
OUT = r'C:\Projeler\avatar_maker\assets\icons\preview_50.html'

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

CATS = [
    ('hair_50.svg', 'HairStyles/', 'Hair', '#2C1B18'),
    ('facial_hair_50.svg', 'FacialHair/', 'Facial hair', '#252E32'),
    ('eyebrows_50.svg', 'Eyebrows/', 'Eyebrows', None),
    ('eyes_50.svg', 'Eyes/', 'Eyes', None),
    ('nose_50.svg', 'Nose/', 'Nose', None),
    ('mouth_50.svg', 'Mouth/', 'Mouth', None),
    ('outfit_50.svg', 'OutfitTypes/', 'Outfit', '#5BC0DE'),
    ('accessories_50.svg', 'Accessories/', 'Accessories', None),
    ('skin_50.svg', 'SkinColor/', 'Skin', None),
    ('background_50.svg', 'Background/', 'Background', None),
]

HAIR_C = ['#2C1B18', '#724133', '#B58143', '#C93305', '#4A312C', '#8E24AA']
FH_C = ['#252E32', '#331B0C', '#4A312C', '#212529', '#5C3A21', '#1D1E2C']
OUT_C = ['#65C9FF', '#7ED6A5', '#F6C667', '#E88C8C', '#B39DDB', '#2A6F97', '#E76F51', '#45B7D1']
SKIN_C = ['#FD9841', '#FFDBB4', '#EDB98A', '#D08B5B', '#AE5D29', '#614335']


def load(fn, prefix):
    s = io.open(os.path.join(SRC, fn), encoding='utf-8').read()
    out = []
    i = 0
    pat = re.compile(r'<g id="' + re.escape(prefix) + r'([^"]+)"')
    tag = re.compile(r'<g\b[^>]*>|</g>')
    while True:
        m = pat.search(s, i)
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
        i = end
    return out


def avatar(hair, fh, brows, eyes, nose, mouth, outfit, acc, skin):
    return ('<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" '
            'viewBox="0 0 264 280" width="264" height="280">'
            '<defs>'
            '<circle id="path-1" cx="120" cy="120" r="120"></circle>'
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
    data = {fn: load(fn, p) for fn, p, _, _ in CATS}

    # Defaults for the layers that are not the subject of the current category.
    def pick(cat_fn, idx=0):
        return data[cat_fn][idx % len(data[cat_fn])][1]

    def hair_svg(i):
        return pick('hair_50.svg', i).replace('#2C1B18', HAIR_C[i % len(HAIR_C)])

    def fh_svg(i):
        return pick('facial_hair_50.svg', i).replace('#252E32', FH_C[i % len(FH_C)])

    def out_svg(i):
        return pick('outfit_50.svg', i).replace('#5BC0DE', OUT_C[i % len(OUT_C)])

    sections = []
    for fn, prefix, label, colour in CATS:
        items = data[fn]
        cards = []
        for i, (name, body) in enumerate(items):
            b = body
            h, f, o = hair_svg(i), fh_svg(i), out_svg(i)
            br, ey, no, mo = (pick('eyebrows_50.svg', i), pick('eyes_50.svg', i),
                              pick('nose_50.svg', i), pick('mouth_50.svg', i))
            ac = pick('accessories_50.svg', i)
            sk = SKIN_C[i % len(SKIN_C)]

            if fn == 'hair_50.svg':
                b = body.replace('#2C1B18', HAIR_C[i % len(HAIR_C)])
            elif fn == 'facial_hair_50.svg':
                b = body.replace('#252E32', FH_C[i % len(FH_C)])
            elif fn == 'outfit_50.svg':
                b = body.replace('#5BC0DE', OUT_C[i % len(OUT_C)])
            elif fn == 'eyebrows_50.svg':
                br = b
            elif fn == 'eyes_50.svg':
                ey = b
            elif fn == 'nose_50.svg':
                no = b
            elif fn == 'mouth_50.svg':
                mo = b
            elif fn == 'accessories_50.svg':
                ac = b
            elif fn == 'skin_50.svg':
                sk = re.search(r'fill="(#[0-9A-Fa-f]{6})"', b).group(1)

            if fn == 'background_50.svg':
                mini = f'<svg viewBox="0 0 264 280" class="mini">{b}</svg>'
            else:
                mini = (f'<svg viewBox="0 0 264 280" class="mini">'
                        f'{avatar(h, f, br, ey, no, mo, o, ac, sk)}</svg>')
            cards.append(
                f'<figure class="card">{mini}'
                f'<figcaption>{html.escape(name)}</figcaption></figure>')

        sections.append(
            f'<section><h2>{html.escape(label)} '
            f'<span class="count">{len(items)} items</span></h2>'
            f'<div class="grid">{"".join(cards)}</div></section>')

    doc = f'''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>avatar_maker - style packs</title>
<style>
  :root {{ color-scheme: light; }}
  * {{ box-sizing: border-box; }}
  body {{ margin:0; padding:24px; background:#f4f5f7; font:14px/1.5 system-ui,-apple-system,"Segoe UI",Roboto,sans-serif; color:#2b2d42; }}
  header {{ max-width:1280px; margin:0 auto 24px; }}
  h1 {{ margin:0 0 6px; font-size:22px; letter-spacing:-0.01em; }}
  header p {{ margin:0 0 4px; color:#6b7280; }}
  header .hint {{ color:#9aa3af; font-size:13px; }}
  section {{ max-width:1280px; margin:0 auto 24px; background:#fff; border-radius:14px; padding:18px 20px 22px; box-shadow:0 1px 3px rgba(16,24,40,.06),0 8px 24px rgba(16,24,40,.04); }}
  h2 {{ margin:0 0 14px; font-size:15px; font-weight:650; border-bottom:1px solid #eef0f3; padding-bottom:10px; }}
  .count {{ color:#9aa3af; font-weight:400; font-size:13px; margin-left:8px; }}
  .grid {{ display:grid; grid-template-columns:repeat(auto-fill,minmax(120px,1fr)); gap:10px; }}
  .card {{ margin:0; background:#F3F1EE; border-radius:10px; padding:5px; text-align:center; }}
  svg.mini {{ display:block; width:100%; height:auto; }}
  figcaption {{ font-size:10.5px; color:#6b7280; margin-top:4px; overflow-wrap:anywhere; }}
</style>
</head>
<body>
<header>
  <h1>avatar_maker &mdash; style packs</h1>
  <p>Every item is a different shape, not a colour variation. Hair, facial hair and outfits keep the
     package colour placeholders, so the existing colour pickers still apply.</p>
  <p class="hint">Each card renders the item on a full avatar, using the package's own
     <code>AvatarService.drawSVG</code> composition.</p>
</header>
{"".join(sections)}
</body>
</html>
'''

    io.open(OUT, 'w', encoding='utf-8').write(doc)
    print('written', OUT, os.path.getsize(OUT))


if __name__ == '__main__':
    main()
