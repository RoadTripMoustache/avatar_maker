import io, os, re

PROP = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items'
Q3 = chr(34) * 3

FILES = [
    ('hair_styles.dart', 'HairStyles'),
    ('facial_hair_types.dart', 'FacialHairTypes'),
    ('eyebrows.dart', 'Eyebrows'),
    ('eyes.dart', 'Eyes'),
    ('noses.dart', 'Noses'),
    ('mouths.dart', 'Mouths'),
    ('outfit_types.dart', 'OutfitTypes'),
    ('accessories.dart', 'Accessories'),
    ('skin_colors.dart', 'SkinColors'),
    ('background_style.dart', 'BackgroundStyles'),
]

total = 0
rows = []
for fn, enum in FILES:
    src = io.open(os.path.join(PROP, fn), encoding='utf-8', newline='').read()
    m = re.search(r'enum\s+' + enum + r'\b', src)
    if not m:
        continue
    names = re.findall(r'^  ([A-Za-z_][A-Za-z0-9_]*)\(', src[m.end():], re.M)
    total += len(names)
    rows.append((enum, len(names)))

print(f'{"Category":<22} {"Items":>6}')
print('-' * 30)
for enum, n in rows:
    ok = 'OK' if n >= 50 else 'LOW'
    print(f'{enum:<22} {n:>6}  {ok}')
print('-' * 30)
print(f'{"TOTAL":<22} {total:>6}')
