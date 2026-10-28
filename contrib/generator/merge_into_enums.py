"""
Merges the generated style packs into the package's built-in enums, so the new
items show up in the real customizer (HairStyles.values, Eyes.values, ...).

The generated files use the same id scheme ("HairStyles/Name", ...), so the
merged entries are indistinguishable from the built-in ones.

Every enum entry is a Name(...), pair where the body is a triple-quoted string;
the SVG bodies never contain that sequence, so the entries can be parsed
reliably.
"""

import io, os, re

PROP = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items'
GEN = os.path.join(PROP, 'generated')

# generated file -> (target enum file, target enum name, generated enum name)
MAP = {
    'hair_50.dart': ('hair_styles.dart', 'HairStyles', 'HairStylesExtra'),
    'facial_hair_50.dart': ('facial_hair_types.dart', 'FacialHairTypes', 'FacialHairTypesExtra'),
    'eyebrows_50.dart': ('eyebrows.dart', 'Eyebrows', 'EyebrowsExtra'),
    'eyes_50.dart': ('eyes.dart', 'Eyes', 'EyesExtra'),
    'nose_50.dart': ('noses.dart', 'Noses', 'NosesExtra'),
    'mouth_50.dart': ('mouths.dart', 'Mouths', 'MouthsExtra'),
    'outfit_50.dart': ('outfit_types.dart', 'OutfitTypes', 'OutfitTypesExtra'),
    'accessories_50.dart': ('accessories.dart', 'Accessories', 'AccessoriesExtra'),
    'skin_50.dart': ('skin_colors.dart', 'SkinColors', 'SkinColorsExtra'),
    'background_50.dart': ('background_style.dart', 'BackgroundStyles', 'BackgroundStylesExtra'),
}

ENTRY_RE = re.compile(r'^([ \t]*)([A-Za-z_][A-Za-z0-9_]*)\(', re.M)
Q3 = chr(34) * 3


def parse_entries(text, enum_name):
    """Returns [(name, body, start, end)] for the entries of an enum.

    `start` / `end` are the offsets of the whole entry (including the trailing
    comma), so an entry can be removed or inserted verbatim.
    """
    m = re.search(r'enum\s+' + enum_name + r'\b', text)
    if not m:
        return []
    out = []
    i = m.end()
    while True:
        mm = ENTRY_RE.search(text, i)
        if not mm:
            break
        body_start = text.find(Q3, mm.end())
        if body_start == -1:
            # A plain (non triple-quoted) body, e.g. Transparent("").
            k = text.find('),', mm.end())
            if k == -1:
                break
            out.append((mm.group(2), text[mm.end():k], mm.start(), k + 2))
            i = k + 2
            continue
        body_end = text.find(Q3, body_start + 3)
        if body_end == -1:
            break
        # The entry ends at the '),' that closes the constructor call.
        k = text.find('),', body_end)
        if k == -1:
            break
        out.append((mm.group(2),
                    text[body_start + 3:body_end],
                    mm.start(),
                    k + 2))
        i = k + 2
    return out


def main():
    for gen_file, (target_file, enum_name, gen_enum_name) in MAP.items():
        gen_path = os.path.join(GEN, gen_file)
        target_path = os.path.join(PROP, target_file)
        if not os.path.exists(gen_path):
            print(f'  skip {gen_file}: not generated')
            continue

        gen_src = io.open(gen_path, encoding='utf-8', newline='').read()
        gen_entries = parse_entries(gen_src, gen_enum_name)
        if not gen_entries:
            print(f'  skip {gen_file}: no entries found')
            continue

        tgt_src = io.open(target_path, encoding='utf-8', newline='').read()
        tgt_entries = parse_entries(tgt_src, enum_name)
        if not tgt_entries:
            print(f'  skip {target_file}: enum {enum_name} not found')
            continue

        # The built-in entries use multi-line strings, so the entry names are
        # collected from the raw text instead of from the parsed entries.
        existing = set(re.findall(r'^[ \t]{2}([A-Za-z_][A-Za-z0-9_]*)\(', tgt_src, re.M))
        new_entries = [(n, b) for n, b, _, _ in gen_entries if n not in existing]
        skipped = [n for n, _, _, _ in gen_entries if n in existing]

        if not new_entries:
            print(f'  {enum_name}: all {len(gen_entries)} already present')
            continue

        # Insert right after the last existing entry.
        insert_at = tgt_entries[-1][3]
        block = ''.join(f'  {n}({Q3}{b}{Q3}),\n' for n, b in new_entries)
        merged = tgt_src[:insert_at] + '\n' + block + tgt_src[insert_at:]
        io.open(target_path, 'w', encoding='utf-8', newline='').write(merged)

        print(f'  {enum_name}: +{len(new_entries)} entries '
              f'({len(skipped)} skipped as duplicates, {len(existing)} existing)')


if __name__ == '__main__':
    main()
