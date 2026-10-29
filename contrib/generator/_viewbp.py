import io
s = io.open(r'C:\Projeler\avatar_maker\contrib\generator\build_packs.py', encoding='utf-8').read()
lines = s.splitlines()
for i in range(290, 310):
    print(f'{i+1}: {lines[i]}')