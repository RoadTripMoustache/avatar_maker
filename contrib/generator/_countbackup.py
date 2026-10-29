import io, re
for path in [r'C:\Projeler\avatar_maker\contrib\backup\eyes.dart', r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items\eyes.dart']:
    s = io.open(path, encoding='utf-8').read()
    items = re.findall(r'(\w+)\(\"\"\"', s)
    print(f'{path}: {len(items)} items')