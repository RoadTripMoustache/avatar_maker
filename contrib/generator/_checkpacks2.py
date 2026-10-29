import re, io
for cat in ['mouth', 'eyebrows']:
    s = io.open(f'C:/Projeler/avatar_maker/assets/icons/{cat}_50.svg', encoding='utf-8').read()
    # find first item's full g
    m = re.search(r'<g id="[^"]*">(.*?)</g>', s)
    body = m.group(1) if m else ''
    print(f'{cat}: first item body = {body[:200]}')
    print()