import io, re
BASE = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items'
s = io.open(BASE + r'\noses.dart', encoding='utf-8').read()
items = re.findall(r'(\w+)\(\"\"\"', s)
print('total nose items:', len(items))
# check transforms
transforms = set()
for m in re.finditer(r'(\w+)\(\"\"\"(.*?)\"\"\"\)', s, re.S):
    name, body = m.group(1), m.group(2)
    tm = re.search(r'transform="([^"]*)"', body)
    if tm:
        transforms.add(tm.group(1))
print('transforms:', transforms)