import io, re
s = io.open(r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items\mouths.dart', encoding='utf-8').read()
m = re.search(r'Concerned\(\"\"\"(.*?)\"\"\"\)', s, re.S)
if m:
    body = m.group(1)
    pm = re.search(r'd="([^"]*)"', body)
    print('path d:', pm.group(1)[:120] if pm else 'none')