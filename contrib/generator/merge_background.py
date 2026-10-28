import io, os, re

PROP = r'C:\Projeler\avatar_maker\lib\src\core\enums\property_items'
Q3 = chr(34) * 3

path = os.path.join(PROP, 'background_style.dart')
src = io.open(path, encoding='utf-8', newline='').read()

gen = io.open(os.path.join(PROP, 'generated', 'background_50.dart'),
              encoding='utf-8', newline='').read()

m = re.search(r'enum\s+BackgroundStylesExtra\b', gen)
ENTRY = re.compile(r'^  ([A-Za-z_][A-Za-z0-9_]*)\(', re.M)

entries = []
i = m.end()
while True:
    mm = ENTRY.search(gen, i)
    if not mm:
        break
    bs = gen.find(Q3, mm.end())
    if bs == -1:
        break
    be = gen.find(Q3, bs + 3)
    if be == -1:
        break
    k = gen.find('),', be)
    if k == -1:
        break
    entries.append((mm.group(1), gen[bs + 3:be]))
    i = k + 2

existing = set(re.findall(r'^  ([A-Za-z_][A-Za-z0-9_]*)\(', src, re.M))
new_entries = [(n, b) for n, b in entries if n not in existing]

# The built-in enum ends its last value with `""");`. The new values are
# inserted before that terminator, and the terminator keeps the semicolon.
anchor = src.index('  final String svg;')
head = src[:anchor]

# Strip the trailing `""");` of the previous last value and turn it into `"""),`.
close = head.rstrip()
assert close.endswith('""");'), repr(close[-12:])
head = close[:-len('""");')].rstrip() + '"""),'

block = ''.join(f'  {n}({Q3}{b}{Q3}),\n' for n, b in new_entries)
merged = head + '\n' + block + ';\n' + src[anchor:]

io.open(path, 'w', encoding='utf-8', newline='').write(merged)
print(f'background: +{len(new_entries)} entries')
