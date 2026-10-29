import io, re
s = io.open(r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items\mouths.dart', encoding='utf-8').read()
m = re.search(r'Concerned\(\"\"\"(.*?)\"\"\"\)', s, re.S)
if m:
    body = m.group(1)
    pms = re.findall(r'd="([^"]*)"', body)
    for p in pms[:3]:
        print('path d:', p[:120])