import io, re
# Remove ShavedHead entry from hair_styles.dart
p = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items\hair_styles.dart'
s = io.open(p, encoding='utf-8').read()
# find ShavedHead entry
m = re.search(r'ShavedHead\(\"\"\".*?\"\"\"\),?\n', s, re.S)
if m:
    s = s.replace(m.group(0), '')
    io.open(p, 'w', encoding='utf-8').write(s)
    print('removed ShavedHead')
else:
    print('ShavedHead not found')