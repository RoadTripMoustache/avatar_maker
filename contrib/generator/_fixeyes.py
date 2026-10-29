import io, re
p = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items\eyes.dart'
s = io.open(p, encoding='utf-8').read()
# Replace generated transform (no decimals) only
old = 'transform="translate(0,8)"'
new = 'transform="translate(0,0)"'
count = s.count(old)
s = s.replace(old, new)
io.open(p, 'w', encoding='utf-8').write(s)
print(f'replaced {count} in eyes.dart')