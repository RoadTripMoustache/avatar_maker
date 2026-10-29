import re, io
# Check generated pack transforms and a sample item's inner coords
for cat in ['eyes', 'nose', 'mouth', 'eyebrows']:
    s = io.open(f'C:/Projeler/avatar_maker/assets/icons/{cat}_50.svg', encoding='utf-8').read()
    # find first g with transform
    m = re.search(r'<g id="[^"]*" (transform="[^"]*")', s)
    t = m.group(1) if m else 'NO_TRANSFORM'
    print(f'{cat}: first item transform = {t}')
    # find a circle/rect center y
    ys = re.findall(r'cy="([\d.]+)"', s)
    if ys:
        print(f'  cy values (first 5): {ys[:5]}')