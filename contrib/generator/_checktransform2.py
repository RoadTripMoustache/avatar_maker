import io, re
p = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items\eyes.dart'
s = io.open(p, encoding='utf-8').read()
transforms = set(re.findall(r'transform="([^"]*)"', s))
print('eye transforms:', transforms)