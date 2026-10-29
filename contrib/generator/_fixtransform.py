import io
p = r'C:\Projeler\avatar_maker\contrib\generator\build_packs.py'
s = io.open(p, encoding='utf-8').read()
old = "transform='translate(0,8)'"
new = "transform='translate(0,0)'"
assert old in s
s = s.replace(old, new)
io.open(p, 'w', encoding='utf-8').write(s)
print('done')