import io, re
p = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items\eyes.dart'
s = io.open(p, encoding='utf-8').read()
# find all distinct transforms
transforms = set(re.findall(r'transform="([^"]*)"', s))
print('transforms:', transforms)
# count items
print('total items:', len(re.findall(r'(\w+)\(\"\"\"', s)))