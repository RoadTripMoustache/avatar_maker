import io, re
s = io.open(r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items\mouths.dart', encoding='utf-8').read()
# find first built-in item
m = re.search(r'(\w+)\(\"\"\"(.*?)\"\"\"\)', s, re.S)
if m:
    body = m.group(2)
    # find path with Q
    pm = re.search(r'd="([^"]*)"', body)
    print('first mouth built-in:', m.group(1))
    print('path d:', pm.group(1)[:100] if pm else 'none')