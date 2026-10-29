import io, re
BASE = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items'
# noses
s = io.open(BASE + r'\noses.dart', encoding='utf-8').read()
count = 0
for m in re.finditer(r'(\w+)\(\"\"\"(.*?)\"\"\"\)', s, re.S):
    name, body = m.group(1), m.group(2)
    # find any y or cy
    ys = re.findall(r'[yc]="([\d.]+)"', body)
    if ys:
        print(f'  {name}: ys={ys[:5]}')
    count += 1
    if count >= 5:
        break