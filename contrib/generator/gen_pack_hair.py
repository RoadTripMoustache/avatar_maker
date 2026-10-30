"""
HAIR - 50+ distinct style variants in the avatar frame (264x280).

Frame landmarks (derived from avatar_service.dart + the built-in hair assets):
    head centre x = 132, skull top y = 36, ear line y = 124, chin y = 199,
    forehead/hairline y ~ 88..96.

Every hair shape is built from a CRESCENT (outer skull contour + inner
hairline) plus optional extra volumes. No two items are recolours of one
another: the silhouette, the hairline, the fringe and the extras all differ.
"""

import math


def f(v):
    s = f"{v:.1f}"
    return s[:-2] if s.endswith('.0') else s


def lerp(a, b, t):
    return a + (b - a) * t


def hair_items():
    out = []

    def add(name, body):
        out.append((name, body))

    CX = 132.0     # head centre x
    L = 64.0       # head left x
    R = 200.0      # head right x

    def crescent(top=36.0, hairline=92.0, side=126.0, left=L, right=R, cx=CX,
                 bulge=0.0, peak=None, peak_y=None):
        """A hair cap.

        top       y of the crown
        hairline  y of the hairline across the forehead
        side      y where the hair mass ends at the temples
        bulge     extra volume outwards
        peak      x of a parting point / widow's peak on the hairline
        """
        lx = left - bulge
        rx = right + bulge
        tl = left + 10 + bulge
        tr = right - 10 - bulge
        pk = cx if peak is None else peak
        py = hairline if peak_y is None else peak_y
        return (f'M{f(lx)},{f(side)} '
                f'C{f(lx-3)},{f(top+44)} {f(cx-42)},{f(top)} {f(cx)},{f(top)} '
                f'C{f(cx+42)},{f(top)} {f(rx+3)},{f(top+44)} {f(rx)},{f(side)} '
                f'C{f(rx-1)},{f(side-16)} {f(tr+6)},{f(side-6)} {f(tr)},{f(side-10)} '
                f'C{f(tr-16)},{f(hairline+2)} {f(pk+20)},{f(py)} {f(pk)},{f(py)} '
                f'C{f(pk-20)},{f(py)} {f(tl+16)},{f(hairline+2)} {f(tl)},{f(side-10)} '
                f'C{f(tl-6)},{f(side-6)} {f(lx+1)},{f(side-16)} {f(lx)},{f(side)} Z')

    def lock(x, y0, y1, w=12.0, bulge=5.0):
        """A lock of hair hanging beside the face, rooted at (x, y0)."""
        return (f'M{f(x-w)},{f(y0-6)} '
                f'C{f(x-w-bulge)},{f(y0+(y1-y0)*0.35)} {f(x-w+bulge)},{f(y0+(y1-y0)*0.7)} {f(x-w+3)},{f(y1)} '
                f'C{f(x-w+11)},{f(y1+6)} {f(x+w-9)},{f(y1+6)} {f(x+w-5)},{f(y1-6)} '
                f'C{f(x+w+1)},{f(y0+(y1-y0)*0.65)} {f(x+w+bulge)},{f(y0+(y1-y0)*0.3)} {f(x+w)},{f(y0-6)} Z')

    def fringe(drop=100.0, half=52.0, curve=26.0):
        """A fringe across the forehead."""
        return (f'M{f(CX-half)},{f(82)} '
                f'C{f(CX-half+14)},{f(drop-10)} {f(CX+half-14)},{f(drop-10)} {f(CX+half)},{f(82)} '
                f'C{f(CX+half-30)},{f(drop-curve)} {f(CX-half+30)},{f(drop-curve)} {f(CX-half)},{f(82)} Z')

    def spikes(count=7, height=34.0, base=84.0, width=16.0, spread=104.0):
        d = []
        step = spread / max(1, count - 1)
        for i in range(count):
            x = CX - spread / 2 + i * step
            h = base - height * (0.55 + 0.45 * ((i * 7) % 5) / 4.0)
            d.append(f'L{f(x-width*0.55)},{f(base-8)} L{f(x)},{f(h)} L{f(x+width*0.55)},{f(base-6)}')
        return ' '.join(d)

    def round_mass(x, y, r, squash=1.0):
        return (f'M{f(x-r)},{f(y)} '
                f'C{f(x-r)},{f(y-r*squash)} {f(x-r*0.6)},{f(y-r*squash)} {f(x)},{f(y-r*squash)} '
                f'C{f(x+r*0.6)},{f(y-r*squash)} {f(x+r)},{f(y-r*squash)} {f(x+r)},{f(y)} '
                f'C{f(x+r)},{f(y+r*squash)} {f(x+r*0.6)},{f(y+r*squash)} {f(x)},{f(y+r*squash)} '
                f'C{f(x-r*0.6)},{f(y+r*squash)} {f(x-r)},{f(y+r*squash)} {f(x-r)},{f(y)} Z')

    # =====================================================================
    #  1..10  short crops
    # =====================================================================
    add('CrewCut', f'<path d="{crescent(top=44, hairline=94, side=120)}" />')
    add('BuzzFade', f'<path d="{crescent(top=52, hairline=98, side=114)}" />'
                    f'<path d="M70,110 C74,132 96,142 132,144 C168,142 190,132 194,110 '
                    f'C186,126 162,134 132,134 C102,134 78,126 70,110 Z" '
                    f'fill="#000000" fill-opacity="0.2" />')
    add('Undercut', f'<path d="{crescent(top=40, hairline=90, side=116)}" />')
    add('SideSwept', f'<path d="{crescent(top=34, hairline=90, side=118, peak=148)}" />'
                     f'<path d="{fringe(drop=98, half=50, curve=24)}" fill="#000000" fill-opacity="0.14" />')
    add('TexturedCrop', f'<path d="{crescent(top=40, hairline=96, side=118)}" />'
                        f'<path d="M80,88 l11,-9 l-5,17 Z M106,82 l12,-8 l-6,16 Z '
                        f'M134,78 l13,-4 l-8,15 Z M162,82 l11,3 l-9,12 Z M184,90 l9,6 l-10,8 Z" '
                        f'fill="#000000" fill-opacity="0.18" />')
    add('SidePart', f'<path d="{crescent(top=36, hairline=92, side=118, peak=150)}" />')
    add('CurtainBangs', f'<path d="{crescent(top=38, hairline=100, side=118)}" />'
                        f'<path d="{fringe(drop=118, half=56, curve=30)}" fill="#000000" fill-opacity="0.16" />')
    add('MessyFringe', f'<path d="{crescent(top=38, hairline=96, side=118)}" />'
                       f'<path d="M84,86 l15,-9 l-6,19 Z M110,78 l14,-8 l-6,18 Z '
                       f'M138,74 l13,-5 l-8,16 Z M166,80 l11,2 l-8,14 Z M186,88 l9,6 l-10,9 Z" '
                       f'fill="#000000" fill-opacity="0.18" />')
    add('WaveBob', f'<path d="{crescent(top=36, hairline=94, side=124)}" />'
                   f'<path d="{lock(76, 118, 172, 11, 7)}" />'
                   f'<path d="{lock(188, 118, 172, 11, 7)}" />')
    add('SlickBack', f'<path d="{crescent(top=34, hairline=88, side=118)}" />'
                     f'<path d="M80,72 C104,48 160,48 184,72 C160,84 104,84 80,72 Z" '
                     f'fill="#000000" fill-opacity="0.14" />')

    # =====================================================================
    #  11..20  medium and long
    # =====================================================================
    add('MediumBob', f'<path d="{crescent(top=36, hairline=96, side=126)}" />'
                     f'<path d="{lock(76, 120, 166, 11, 6)}" />'
                     f'<path d="{lock(188, 120, 166, 11, 6)}" />')
    add('LongStraight', f'<path d="{crescent(top=34, hairline=94, side=124)}" />'
                        f'<path d="{lock(76, 118, 222, 12, 5)}" />'
                        f'<path d="{lock(188, 118, 222, 12, 5)}" />')
    add('LongStraight2', f'<path d="{crescent(top=32, hairline=92, side=126)}" />'
                         f'<path d="{lock(75, 120, 236, 13, 5)}" />'
                         f'<path d="{lock(189, 120, 236, 13, 5)}" />')
    add('LongStraight3', f'<path d="{crescent(top=30, hairline=90, side=128)}" />'
                         f'<path d="{lock(74, 122, 250, 14, 4)}" />'
                         f'<path d="{lock(190, 122, 250, 14, 4)}" />')
    add('LongStraight4', f'<path d="{crescent(top=28, hairline=88, side=130)}" />'
                         f'<path d="{lock(73, 124, 264, 15, 4)}" />'
                         f'<path d="{lock(191, 124, 264, 15, 4)}" />')
    add('LongWavy', f'<path d="{crescent(top=34, hairline=94, side=124)}" />'
                     f'<path d="M74,114 C66,146 82,170 72,198 C64,222 80,232 76,252 '
                     f'C96,238 88,208 96,184 C102,158 86,136 88,114 Z" />'
                     f'<path d="M190,114 C198,146 182,170 192,198 C200,222 184,232 188,252 '
                     f'C168,238 176,208 168,184 C162,158 178,136 176,114 Z" />')
    add('LongWavy2', f'<path d="{crescent(top=32, hairline=92, side=126)}" />'
                      f'<path d="M73,116 C63,152 81,180 69,210 C59,236 78,248 72,270 '
                      f'C96,254 86,222 94,196 C102,168 86,142 89,116 Z" />'
                      f'<path d="M191,116 C201,152 183,180 195,210 C205,236 186,248 192,270 '
                      f'C168,254 178,222 170,196 C162,168 178,142 175,116 Z" />')
    add('LongCurly', f'<path d="{crescent(top=32, hairline=92, side=124)}" />'
                      f'<path d="M72,114 C60,138 84,156 68,180 C56,200 82,216 66,240 '
                      f'C56,256 78,262 74,276 C96,262 88,240 98,218 C108,194 86,178 92,154 '
                      f'C96,136 84,124 86,114 Z" />'
                      f'<path d="M192,114 C204,138 180,156 196,180 C208,200 182,216 198,240 '
                      f'C208,256 186,262 190,276 C168,262 176,240 166,218 C156,194 178,178 172,154 '
                      f'C168,136 180,124 178,114 Z" />')
    add('ShoulderLength', f'<path d="{crescent(top=34, hairline=94, side=124)}" />'
                           f'<path d="{lock(76, 118, 194, 12, 6)}" />'
                           f'<path d="{lock(188, 118, 194, 12, 6)}" />')
    add('Layered', f'<path d="{crescent(top=34, hairline=96, side=126)}" />'
                   f'<path d="{lock(76, 120, 184, 12, 8)}" />'
                   f'<path d="{lock(188, 120, 184, 12, 8)}" />'
                   f'<path d="M82,148 C88,176 82,198 90,218 C98,194 94,174 98,154 Z" '
                   f'fill="#000000" fill-opacity="0.14" />')

    # =====================================================================
    #  21..30  updos
    # =====================================================================
    add('HighPonytail', f'<path d="{crescent(top=36, hairline=92, side=118)}" />'
                        f'<path d="M190,100 C216,94 230,126 222,164 C214,198 192,212 182,192 '
                        f'C174,174 186,144 180,118 Z" />')
    add('LowPonytail', f'<path d="{crescent(top=36, hairline=92, side=118)}" />'
                       f'<path d="M188,108 C216,120 224,164 212,200 C200,234 176,240 168,218 '
                       f'C162,200 178,160 174,128 Z" />')
    add('TopBun', f'<path d="{crescent(top=36, hairline=90, side=116)}" />'
                  f'<path d="{round_mass(CX, 18, 21)}" />')
    add('MessyBun', f'<path d="{crescent(top=36, hairline=90, side=116)}" />'
                    f'<path d="M106,16 C114,-8 150,-10 162,10 C170,26 146,32 132,22 '
                    f'C144,26 158,18 150,6 C138,-8 114,0 106,16 Z" />')
    add('HalfUp', f'<path d="{crescent(top=36, hairline=92, side=118)}" />'
                  f'<path d="M94,68 C102,34 162,34 170,68 C144,50 120,50 94,68 Z" />')
    add('DoubleBun', f'<path d="{crescent(top=38, hairline=92, side=116)}" />'
                     f'<path d="{round_mass(94, 34, 16)}" />'
                     f'<path d="{round_mass(170, 34, 16)}" />')
    add('BunWithFringe', f'<path d="{crescent(top=38, hairline=98, side=118)}" />'
                         f'<path d="{round_mass(CX, 18, 19)}" />'
                         f'<path d="{fringe(drop=106, half=54, curve=24)}" fill="#000000" fill-opacity="0.16" />')
    add('FrenchBun', f'<path d="{crescent(top=34, hairline=88, side=118)}" />'
                     f'<ellipse cx="{CX}" cy="22" rx="26" ry="15" />')
    add('PonytailLoops', f'<path d="{crescent(top=36, hairline=92, side=118)}" />'
                         f'<path d="M192,104 C216,102 226,134 216,164 C208,188 192,196 186,180 '
                         f'C182,164 192,140 186,120 Z" />')
    add('TightBun', f'<path d="{crescent(top=36, hairline=88, side=116)}" />'
                    f'<path d="{round_mass(CX, 20, 17)}" />')

    # =====================================================================
    #  31..40  braids, texture, volume
    # =====================================================================
    add('Braids', f'<path d="{crescent(top=38, hairline=94, side=118)}" />' +
                   ''.join(f'<path d="M{f(88+k*20)},58 C{f(82+k*20)},80 {f(96+k*20)},94 '
                           f'{f(88+k*20)},106 C{f(84+k*20)},114 {f(92+k*20)},118 {f(88+k*20)},122 '
                           f'C{f(82+k*20)},118 {f(80+k*20)},110 {f(82+k*20)},104 '
                           f'C{f(88+k*20)},90 {f(80+k*20)},76 {f(88+k*20)},58 Z" />'
                           for k in range(4)))
    add('TightBraids', f'<path d="{crescent(top=38, hairline=96, side=118)}" />' +
                       ''.join(f'<path d="M{f(92+k*14)},56 C{f(87+k*14)},74 {f(99+k*14)},84 '
                               f'{f(92+k*14)},94 C{f(89+k*14)},100 {f(96+k*14)},104 {f(92+k*14)},108 '
                               f'C{f(86+k*14)},104 {f(85+k*14)},98 {f(87+k*14)},92 '
                               f'C{f(92+k*14)},80 {f(86+k*14)},70 {f(92+k*14)},56 Z" />'
                               for k in range(6)))
    add('Afro', f'<path d="M40,120 C40,38 84,4 132,4 C180,4 224,38 224,120 '
                 f'C214,142 196,150 182,132 C168,104 148,94 132,94 '
                 f'C116,94 96,104 82,132 C68,150 50,142 40,120 Z" />')
    add('BigAfro', f'<path d="M30,122 C30,28 80,-8 132,-8 C184,-8 234,28 234,122 '
                   f'C222,150 200,160 182,138 C166,106 148,96 132,96 '
                   f'C116,96 98,106 82,138 C64,160 42,150 30,122 Z" />')
    add('CoilyCrown', f'<path d="{crescent(top=40, hairline=92, side=116)}" />'
                      f'<circle cx="102" cy="50" r="14"/><circle cx="162" cy="50" r="14"/>'
                      f'<circle cx="132" cy="32" r="16"/><circle cx="80" cy="74" r="11"/>'
                      f'<circle cx="184" cy="74" r="11"/>')
    add('Locs', f'<path d="{crescent(top=38, hairline=94, side=118)}" />' +
                ''.join(f'<rect x="{f(66+k*10)}" y="106" width="8" height="88" rx="4" />'
                        for k in range(3)) +
                ''.join(f'<rect x="{f(188+k*10)}" y="106" width="8" height="88" rx="4" />'
                        for k in range(3)))
    add('DreadlockTop', f'<path d="{crescent(top=38, hairline=94, side=116)}" />' +
                        ''.join(f'<path d="M{f(90+k*14)},74 C{f(80+k*14)},44 {f(102+k*14)},34 '
                                f'{f(98+k*14)},8 C{f(110+k*14)},32 {f(94+k*14)},46 {f(96+k*14)},74 Z" />'
                                for k in range(4)))
    add('VolumeCurls', f'<path d="{crescent(top=32, hairline=88, side=118, bulge=5)}" />'
                       f'<circle cx="94" cy="44" r="15"/><circle cx="170" cy="44" r="15"/>'
                       f'<circle cx="132" cy="26" r="17"/>')
    add('Shaggy', f'<path d="{crescent(top=34, hairline=104, side=124)}" />'
                  f'<path d="M82,94 C74,130 86,162 74,192 C84,164 82,132 92,102 Z" '
                  f'fill="#000000" fill-opacity="0.15" />'
                  f'<path d="M182,94 C190,130 178,162 190,192 C180,164 182,132 172,102 Z" '
                  f'fill="#000000" fill-opacity="0.15" />')
    add('WolfCut', f'<path d="{crescent(top=34, hairline=98, side=124)}" />'
                   f'<path d="M76,114 C66,144 74,170 66,190 C78,170 76,144 86,118 Z" />'
                   f'<path d="M188,114 C198,144 190,170 198,190 C186,170 188,144 178,118 Z" />')

    # =====================================================================
    #  41..50  short, shaved, headwear
    # =====================================================================
    add('Spiky', f'<path d="{crescent(top=52, hairline=96, side=116)}" />'
                 f'<path d="{spikes(count=7, height=38, base=88)}" />')
    add('SpikyLong', f'<path d="{crescent(top=54, hairline=98, side=116)}" />'
                     f'<path d="{spikes(count=5, height=48, base=92, width=20, spread=96)}" />')
    add('Mohawk', f'<path d="{crescent(top=54, hairline=94, side=114)}" />'
                  f'<path d="M118,86 C114,44 122,14 132,2 C142,14 150,44 146,86 '
                  f'C142,96 122,96 118,86 Z" />')
    add('FauxHawk', f'<path d="{crescent(top=52, hairline=92, side=114)}" />'
                    f'<path d="M116,88 C112,54 120,30 132,20 C144,30 152,54 148,88 '
                    f'C144,96 120,96 116,88 Z" />')
    add('SpikeFringe', f'<path d="{crescent(top=44, hairline=100, side=118)}" />'
                       f'<path d="M76,102 L88,64 L98,96 L110,58 L120,92 L132,54 L142,90 '
                       f'L154,60 L164,94 L176,68 L186,100 C186,124 160,138 132,140 '
                       f'C104,138 78,124 76,102 Z" />')
    add('BuzzCut', f'<path d="{crescent(top=54, hairline=100, side=112)}" />')
    add('ShavedHead', '')
    add('Fade', f'<path d="{crescent(top=44, hairline=98, side=118)}" />'
                f'<path d="M68,104 C72,140 98,156 132,158 C166,156 192,140 196,104 '
                f'C188,130 162,146 132,146 C102,146 76,130 68,104 Z" '
                f'fill="#000000" fill-opacity="0.16" />')
    add('SideFade', f'<path d="{crescent(top=42, hairline=96, side=116)}" />'
                    f'<path d="M66,102 C70,142 98,160 132,162 C166,160 194,142 198,102 '
                    f'C190,130 162,148 132,148 C102,148 74,130 66,102 Z" '
                    f'fill="#000000" fill-opacity="0.2" />')
    add('Pompadour', f'<path d="{crescent(top=40, hairline=90, side=116)}" />'
                     f'<path d="M92,72 C90,32 122,16 150,26 C168,32 176,48 170,64 '
                     f'C152,44 114,48 92,72 Z" />')

    # =====================================================================
    #  51..62  headwear + extra silhouettes
    # =====================================================================
    add('Cap', f'<path d="{crescent(top=46, hairline=92, side=114)}" />'
               f'<path d="M84,60 C84,22 106,2 132,2 C158,2 180,22 180,60 Z" />'
               f'<path d="M68,58 L196,58 L204,76 L60,76 Z" />')
    add('Beanie', f'<path d="{crescent(top=46, hairline=92, side=114)}" />'
                  f'<path d="M78,62 C78,24 102,4 132,4 C162,4 186,24 186,62 Z" />'
                  f'<rect x="72" y="56" width="120" height="18" rx="9" />'
                  f'<circle cx="132" cy="-4" r="13" />')
    add('BucketHat', f'<path d="{crescent(top=46, hairline=92, side=114)}" />'
                     f'<path d="M80,60 C80,26 104,6 132,6 C160,6 184,26 184,60 Z" />'
                     f'<path d="M54,58 C54,48 210,48 210,58 C210,72 54,72 54,58 Z" />')
    add('Headwrap', f'<path d="{crescent(top=46, hairline=92, side=114)}" />'
                    f'<path d="M74,64 C74,26 102,6 132,6 C162,6 190,26 190,64 '
                    f'C166,78 98,78 74,64 Z" />'
                    f'<path d="M172,24 C200,30 206,52 188,64 C180,46 176,32 172,24 Z" />')
    add('Bandana', f'<path d="{crescent(top=46, hairline=92, side=114)}" />'
                   f'<path d="M76,62 C76,28 100,10 132,10 C164,10 188,28 188,62 '
                   f'C158,74 106,74 76,62 Z" />'
                   f'<path d="M180,26 L212,18 L204,46 L186,40 Z" />')
    add('EmoFringe', f'<path d="{crescent(top=36, hairline=104, side=118)}" />'
                     f'<path d="M78,80 L88,126 L98,78 L110,120 L120,74 L132,116 '
                     f'L144,74 L156,114 L168,80 L180,110 L186,86 '
                     f'C184,120 160,138 132,140 C104,138 80,120 78,80 Z" />')
    add('MiddlePart', f'<path d="{crescent(top=34, hairline=90, side=118)}" />'
                      f'<path d="M132,38 C118,58 108,86 106,110 C118,94 128,62 132,38 Z" '
                      f'fill="#000000" fill-opacity="0.15" />'
                      f'<path d="M132,38 C146,58 156,86 158,110 C146,94 136,62 132,38 Z" '
                      f'fill="#000000" fill-opacity="0.15" />')
    add('SlickedPomp', f'<path d="{crescent(top=32, hairline=86, side=116)}" />'
                        f'<path d="M86,64 C96,26 168,26 180,62 C156,48 108,48 86,64 Z" />')
    add('LongSideSwept', f'<path d="{crescent(top=32, hairline=92, side=120, peak=152)}" />'
                          f'<path d="{lock(188, 116, 232, 12, 5)}" />'
                          f'<path d="{fringe(drop=102, half=54, curve=26)}" fill="#000000" fill-opacity="0.15" />')
    add('Cornrows', f'<path d="{crescent(top=40, hairline=96, side=116)}" />' +
                    ''.join(f'<path d="M{f(88+k*15)},72 C{f(84+k*15)},54 {f(94+k*15)},42 {f(90+k*15)},26 '
                            f'C{f(100+k*15)},44 {f(92+k*15)},58 {f(96+k*15)},72 Z" '
                            f'fill="#000000" fill-opacity="0.16" />' for k in range(6)))
    add('SpaceBuns', f'<path d="{crescent(top=40, hairline=94, side=116)}" />'
                     f'<path d="{round_mass(84, 28, 18)}" />'
                     f'<path d="{round_mass(180, 28, 18)}" />')
    add('CurtainTop', f'<path d="{crescent(top=36, hairline=98, side=118)}" />'
                      f'<path d="{fringe(drop=122, half=58, curve=32)}" fill="#000000" fill-opacity="0.16" />'
                      f'<path d="{lock(74, 116, 174, 11, 6)}" />'
                      f'<path d="{lock(190, 116, 174, 11, 6)}" />')
    add('TopLoops', f'<path d="{crescent(top=40, hairline=92, side=116)}" />'
                    f'<path d="M108,54 C100,20 118,2 132,18 C146,2 164,20 156,54 '
                    f'C148,40 138,28 132,34 C126,28 116,40 108,54 Z" />')
    add('ShoulderWave', f'<path d="{crescent(top=34, hairline=94, side=122)}" />'
                         f'<path d="M74,112 C66,142 84,164 74,188 C66,208 82,218 78,234 '
                         f'C98,222 88,200 96,180 C102,160 86,136 88,112 Z" />'
                         f'<path d="M190,112 C198,142 180,164 190,188 C198,208 182,218 186,234 '
                         f'C166,222 176,200 168,180 C162,160 178,136 176,112 Z" />')
    add('TwoTails', f'<path d="{crescent(top=38, hairline=92, side=116)}" />'
                    f'<path d="M72,108 C54,124 48,162 58,194 C66,218 82,218 82,200 '
                    f'C82,184 72,158 76,128 Z" />'
                    f'<path d="M192,108 C210,124 216,162 206,194 C198,218 182,218 182,200 '
                    f'C182,184 192,158 188,128 Z" />')
    add('TightSlick', f'<path d="{crescent(top=44, hairline=90, side=114)}" />')
    add('SlickBackLong', f'<path d="{crescent(top=32, hairline=88, side=120)}" />'
                         f'<path d="{lock(190, 114, 206, 11, 4)}" />')

    return out
