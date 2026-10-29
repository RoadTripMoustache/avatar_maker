import io, re, glob, os
BASE = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items'
total = 0
for f in sorted(glob.glob(os.path.join(BASE, '*.dart'))):
    s = io.open(f, encoding='utf-8').read()
    items = re.findall(r'(\w+)\(\"\"\"', s)
    print(f'{os.path.basename(f)}: {len(items)}')
    total += len(items)
print(f'TOTAL: {total}')