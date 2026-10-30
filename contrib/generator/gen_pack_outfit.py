"""
OUTFIT - 50+ distinct garments.

Frame: the outfit group is translated by (0,170) in the avatar frame, so the
content lives in the same band the built-in outfits use:
    * neck opening  x 104..160 at y 29 (the neck of path-5)
    * shoulder curve runs from the neck out to x 32 / x 232 at y 101
    * the torso is clipped at y 110
Colours are NOT baked in: the package exposes an outfit colour picker, so
every garment emits the TO_REPLACE_WITH_OUTFIT_COLOR placeholder instead.
"""

import os


def f(v):
    s = f"{v:.1f}"
    return s[:-2] if s.endswith('.0') else s


NECK_L, NECK_R = 104.0, 160.0
SHOULDER_L, SHOULDER_R = 32.0, 232.0
NECK_Y = 29.0
HEM = 110.0


def torso(neck='crew', hem=HEM, shoulder_y=101.0):
    """The base torso, following the package's own shoulder curve.

    The path starts at the left neck edge, runs down the left shoulder, across
    the hem, up the right shoulder and then scoops back under the chin. The
    neckline variants change that scoop.
    """
    # Left neck edge -> left shoulder -> hem.
    d = (f'M{NECK_L},{NECK_Y} '
         f'C64,29 {SHOULDER_L},61 {SHOULDER_L},{shoulder_y} '
         f'L{SHOULDER_L},{hem} L{SHOULDER_R},{hem} '
         f'L{SHOULDER_R},{shoulder_y} '
         f'C{SHOULDER_R},61 200,29 {NECK_R},{NECK_Y} ')

    # The neckline scoop, drawn right to left.
    if neck == 'crew':
        d += (f'L158,29 C158,32 158,45 132,45 C106,45 106,32 106,29 Z')
    elif neck == 'v':
        d += (f'L162,29 L132,58 L102,29 Z')
    elif neck == 'scoop':
        d += (f'L160,29 C160,52 146,60 132,60 C118,60 104,52 104,29 Z')
    elif neck == 'turtle':
        d += (f'L160,29 L160,14 C160,10 104,10 104,29 Z')
    elif neck == 'strap':
        d += (f'L154,29 C154,40 110,40 110,29 Z')
    elif neck == 'boat':
        d += (f'L164,29 C164,44 100,44 100,29 Z')
    elif neck == 'square':
        d += (f'L158,29 L158,44 L106,44 L106,29 Z')
    elif neck == 'high':
        d += (f'L156,29 C156,38 108,38 108,29 Z')
    else:  # 'none' - straight across
        d += f'L104,29 Z'
    return '<path d="' + d + '" />'


def outfit_items():
    out = []

    def add(name, body):
        out.append((name, body))

    L, R = 32.0, 232.0

    def collar(kind):
        if kind == 'point':
            return ('<path d="M100,26 L132,50 L164,26 L170,31 L138,62 L126,62 L94,31 Z" />')
        if kind == 'spread':
            return ('<path d="M96,22 L132,46 L168,22 L176,28 L140,60 L124,60 L88,28 Z" />')
        if kind == 'round':
            return '<path d="M104,26 C104,44 160,44 160,26 L160,40 C160,52 104,52 104,40 Z" />'
        if kind == 'v':
            return '<path d="M104,26 L132,56 L160,26 L166,31 L132,66 L98,31 Z" />'
        if kind == 'mandarin':
            return '<rect x="100" y="16" width="64" height="14" rx="4" />'
        if kind == 'band':
            return '<rect x="100" y="24" width="64" height="10" rx="4" />'
        if kind == 'shawl':
            return ('<path d="M100,26 L132,54 L164,26 L172,32 L136,66 L128,66 L92,32 Z" />')
        return ''

    def placket(buttons=5, w=12, y0=48, step=16, x=132):
        s = (f'<rect x="{f(x-w/2)}" y="{f(y0)}" width="{w}" '
             f'height="{f(step*buttons)}" fill-opacity="0.22" />')
        for k in range(buttons):
            s += f'<circle cx="{f(x)}" cy="{f(y0+7+k*step)}" r="2.6" fill="#FFFFFF" fill-opacity="0.9" />'
        return s

    def zip(y0=44, h=64, x=132):
        return (f'<rect x="{f(x-4)}" y="{f(y0)}" width="8" height="{f(h)}" fill-opacity="0.35" />'
                f'<rect x="{f(x-2)}" y="{f(y0)}" width="2" height="{f(h)}" fill="#FFFFFF" fill-opacity="0.55" />')

    def hood():
        return ('<path d="M98,26 C92,-2 172,-2 166,26 C158,44 106,44 98,26 Z" />')

    def drawstrings():
        return ('<path d="M124,44 L120,78" fill="none" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" />'
                '<path d="M140,44 L144,78" fill="none" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" />'
                '<circle cx="120" cy="80" r="3" fill="#FFFFFF" />'
                '<circle cx="144" cy="80" r="3" fill="#FFFFFF" />')

    def pocket(x, y, w=34, h=26):
        return (f'<path d="M{f(x)},{f(y)} L{f(x+w)},{f(y)} L{f(x+w)},{f(y+h)} '
                f'L{f(x)},{f(y+h)} Z" fill-opacity="0.22" />')

    def lapel():
        return ('<path d="M96,22 L132,54 L102,44 Z" />'
                '<path d="M168,22 L132,54 L162,44 Z" />')

    def stripes(n=7, op=0.16):
        s = ''
        for k in range(n):
            x = L + k * (R - L) / n
            s += f'<rect x="{f(x)}" y="0" width="10" height="{f(HEM)}" fill="#FFFFFF" fill-opacity="{op}" />'
        return s

    def hstripes(n=5, op=0.16):
        s = ''
        for k in range(n):
            y = 48 + k * 15
            s += f'<rect x="{f(L)}" y="{f(y)}" width="{f(R-L)}" height="8" fill="#FFFFFF" fill-opacity="{op}" />'
        return s

    def belt(y=84):
        return f'<rect x="{f(L)}" y="{f(y)}" width="{f(R-L)}" height="10" fill-opacity="0.25" />'

    # ---- 1..10  tops -----------------------------------------------------
    add('CrewNeckTee', torso('crew') + collar('round'))
    add('VNeckTee', torso('v') + collar('v'))
    add('ScoopNeckTee', torso('scoop') + collar('round'))
    add('TurtleNeck', torso('turtle') + collar('band'))
    add('StrapTop', torso('strap') + collar('round'))
    add('BoatNeck', torso('boat') + collar('round'))
    add('LongSleeveShirt', torso('crew') + collar('point') + placket(5))
    add('PoloShirt', torso('v') + collar('point') +
        '<rect x="126" y="52" width="12" height="24" fill-opacity="0.3" />' +
        '<circle cx="132" cy="58" r="2.6" fill="#FFFFFF" fill-opacity="0.9" />')
    add('Henley', torso('crew') + collar('round') +
        '<rect x="122" y="52" width="20" height="22" fill-opacity="0.25" />' +
        '<circle cx="132" cy="59" r="2.4" fill="#FFFFFF" fill-opacity="0.9" />')
    add('ButtonUp', torso('crew') + collar('point') + placket(6))

    # ---- 11..20  shirts / blouses ----------------------------------------
    add('FlannelShirt', torso('crew') + collar('point') + placket(6) + hstripes(4, 0.13))
    add('OxfordShirt', torso('crew') + collar('spread') + placket(6))
    add('DressShirt', torso('crew') + collar('spread') + placket(7) +
        '<path d="M122,44 L142,44 L140,62 L124,62 Z" fill="#FFFFFF" fill-opacity="0.35" />')
    add('MandarinCollar', torso('turtle') + collar('mandarin') + placket(5))
    add('ChiffonBlouse', torso('crew') + collar('round') +
        '<path d="M116,52 C126,74 138,74 148,52" fill="none" stroke="#FFFFFF" '
        'stroke-opacity="0.4" stroke-width="2" />')
    add('WrapBlouse', torso('v') + collar('v') +
        '<path d="M104,44 L160,68" fill="none" stroke="#FFFFFF" stroke-opacity="0.35" stroke-width="3" />')
    add('PuffSleeveBlouse', torso('crew') + collar('round') +
        '<ellipse cx="40" cy="62" rx="18" ry="13" fill-opacity="0.2" />'
        '<ellipse cx="224" cy="62" rx="18" ry="13" fill-opacity="0.2" />')
    add('PeasantBlouse', torso('crew') + collar('round') +
        '<path d="M96,50 C110,60 154,60 168,50" fill="none" stroke="#FFFFFF" '
        'stroke-opacity="0.35" stroke-width="2" />')
    add('TieShirt', torso('crew') + collar('point') + placket(6) +
        '<path d="M126,44 L138,44 L135,56 L140,88 L124,100 L118,88 L123,56 Z" />')
    add('Overshirt', torso('crew') + collar('point') + placket(6) +
        pocket(50, 66) + pocket(180, 66))

    # ---- 21..30  jackets --------------------------------------------------
    add('Blazer', torso('crew') + lapel() + pocket(50, 68, 30, 22))
    add('SuitJacket', torso('crew') + lapel() +
        '<rect x="126" y="52" width="12" height="56" fill-opacity="0.4" />' +
        '<circle cx="132" cy="62" r="2.6" fill="#FFFFFF" fill-opacity="0.9" />' +
        pocket(50, 68, 30, 22))
    add('Waistcoat', torso('crew') + lapel() +
        '<rect x="126" y="52" width="12" height="56" fill-opacity="0.4" />')
    add('TweedJacket', torso('crew') + lapel() + stripes(9, 0.12))
    add('BomberJacket', torso('turtle') + collar('band') + zip(46, 60) +
        '<rect x="32" y="92" width="200" height="10" fill-opacity="0.3" />')
    add('VarsityJacket', torso('turtle') + collar('band') + zip(46, 60) +
        '<path d="M104,40 L124,50 L124,68 L104,58 Z" fill-opacity="0.35" />'
        '<path d="M160,40 L140,50 L140,68 L160,58 Z" fill-opacity="0.35" />')
    add('Windbreaker', torso('turtle') + collar('band') + zip(44, 64) +
        '<rect x="32" y="90" width="200" height="8" fill-opacity="0.3" />')
    add('PufferJacket', torso('turtle') + collar('band') + zip(44, 64) + hstripes(4, 0.18))
    add('Parka', torso('turtle') + hood() + zip(44, 64) +
        pocket(42, 68, 34, 26) + pocket(188, 68, 34, 26))
    add('TrenchCoat', torso('crew') + lapel() +
        '<rect x="32" y="56" width="200" height="8" fill-opacity="0.25" />' +
        '<rect x="126" y="48" width="12" height="60" fill-opacity="0.35" />')

    # ---- 31..40  knitwear / outerwear ------------------------------------
    add('Hoodie', torso('crew') + hood() + drawstrings() +
        pocket(46, 74, 34, 26) + pocket(184, 74, 34, 26))
    add('ZipHoodie', torso('crew') + hood() + zip(48, 60) + drawstrings())
    add('CrewSweatshirt', torso('crew') + collar('band'))
    add('RibbedSweatshirt', torso('crew') + collar('band') + hstripes(8, 0.1))
    add('Cardigan', torso('crew') + collar('point') + zip(46, 62))
    add('CableKnit', torso('crew') + collar('round') +
        ''.join(f'<rect x="{f(38+k*24)}" y="46" width="8" height="64" fill-opacity="0.14" />'
                for k in range(8)))
    add('Poncho', '<path d="M20,110 L20,64 L132,20 L244,64 L244,110 Z" />' +
        '<rect x="106" y="34" width="52" height="8" fill-opacity="0.3" />')
    add('Cape', '<path d="M14,110 L14,60 C14,36 250,36 250,60 L250,110 Z" />')
    add('KnitVest', torso('none') +
        '<path d="M100,30 C104,50 116,60 132,60 C148,60 160,50 164,30 '
        'L164,110 L100,110 Z" />')
    add('CroppedHoodie', torso('crew') + hood() + drawstrings() +
        '<rect x="32" y="86" width="200" height="6" fill-opacity="0.25" />')

    # ---- 41..50  workwear / specials -------------------------------------
    add('ChefCoat', torso('crew') + collar('round') + placket(4, 10, 48, 15) +
        '<rect x="120" y="46" width="24" height="12" fill-opacity="0.3" />')
    add('LabCoat', torso('crew') + collar('spread') +
        '<rect x="118" y="62" width="26" height="28" fill-opacity="0.2" />' +
        '<path d="M125,62 L137,62 L137,90 L125,90 Z" fill-opacity="0.3" />')
    add('Overalls', torso('strap') +
        '<rect x="100" y="34" width="10" height="56" fill-opacity="0.3" />'
        '<rect x="154" y="34" width="10" height="56" fill-opacity="0.3" />' +
        pocket(84, 68, 32, 24))
    add('Apron', torso('crew') +
        '<path d="M60,110 L60,70 L100,54 L164,54 L204,70 L204,110 Z" fill-opacity="0.25" />' +
        '<rect x="104" y="78" width="56" height="26" fill-opacity="0.35" />')
    add('Jumpsuit', torso('crew') + collar('round') + zip(48, 60))
    add('Jersey', torso('crew') + collar('round') + hstripes(6, 0.2))
    add('StripedTee', torso('crew') + collar('round') + stripes(9, 0.16))
    add('GraphicTee', torso('crew') + collar('round') +
        '<path d="M110,62 L132,48 L154,62 L148,90 L132,80 L116,90 Z" fill-opacity="0.3" />')
    add('CropTop', torso('crew') + collar('round') +
        '<rect x="32" y="86" width="200" height="24" fill-opacity="0.3" />')
    add('Uniform', torso('crew') + collar('point') + placket(6) +
        '<rect x="98" y="50" width="12" height="22" fill-opacity="0.35" />'
        '<rect x="154" y="50" width="12" height="22" fill-opacity="0.35" />')

    # ---- 51..60  more silhouettes ----------------------------------------
    add('TurtleneckRibbed', torso('turtle') + collar('band') + hstripes(7, 0.1))
    add('HoodiePocket', torso('crew') + hood() + drawstrings() +
        pocket(96, 76, 72, 26))
    add('BomberRibbed', torso('turtle') + collar('band') + zip(46, 60) +
        hstripes(4, 0.14))
    add('ParkaFur', torso('turtle') + hood() +
        '<ellipse cx="132" cy="12" rx="46" ry="18" fill-opacity="0.3" />' +
        zip(44, 64) + pocket(42, 68, 34, 26) + pocket(188, 68, 34, 26))
    add('DenimJacket', torso('crew') + collar('point') +
        '<path d="M104,28 L128,52 L128,68 L104,44 Z" fill-opacity="0.3" />'
        '<path d="M160,28 L136,52 L136,68 L160,44 Z" fill-opacity="0.3" />' +
        pocket(46, 68, 32, 24) + pocket(186, 68, 32, 24) + zip(52, 56))
    add('LeatherJacket', torso('none') + lapel() + zip(48, 60))
    add('SailorTop', torso('square') +
        '<path d="M98,28 L166,28 L166,52 L98,52 Z" fill-opacity="0.3" />' +
        '<path d="M124,52 L140,52 L140,72 L124,72 Z" fill-opacity="0.3" />')
    add('SweaterVneck', torso('v') + collar('v') + hstripes(5, 0.12))
    add('Bolero', torso('crew') + collar('round') +
        '<rect x="32" y="88" width="200" height="8" fill-opacity="0.3" />')
    add('ApronChef', torso('crew') + collar('round') + placket(4, 10, 48, 15) +
        '<path d="M60,110 L60,72 L100,58 L164,58 L204,72 L204,110 Z" fill-opacity="0.25" />')
    return out
