import io, re
BASE = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items'
s = io.open(BASE + r'\noses.dart', encoding='utf-8').read()
# find generated items (transform="translate(28,40)" without decimals)
for m in re.finditer(r'(\w+)\(\"\"\"(.*?)\"\"\"\)', s, re.S):
    name, body = m.group(1), m.group(2)
    if 'translate(28,40)' in body or 'translate(28.0' in body:
        print(f'  {name}: {body[:150]}')
        break