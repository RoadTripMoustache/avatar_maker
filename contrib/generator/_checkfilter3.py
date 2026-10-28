import io, re, glob, os

BASE = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items'
for f in glob.glob(os.path.join(BASE, '*.dart')):
    s = io.open(f, encoding='utf-8').read()
    if '<filter' in s or '<style' in s:
        print('FOUND in:', os.path.basename(f))
print('done')
