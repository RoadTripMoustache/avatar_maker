import io
s = io.open(r'C:\Projeler\avatar_maker\contrib\generator\gen_pack_features.py', encoding='utf-8').read()
lines = s.splitlines()
# print lines 360-440
for i in range(359, 440):
    print(f'{i+1}: {lines[i]}')