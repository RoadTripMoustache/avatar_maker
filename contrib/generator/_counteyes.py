import io, re
p = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items\eyes.dart'
s = io.open(p, encoding='utf-8').read()
items = re.findall(r'(\w+)\(\"\"\"', s)
print('total eye items:', len(items))
print(items)