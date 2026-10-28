"""
Remaining avatar_maker categories: 50 distinct STYLE variants each.

Coordinate frames (derived from lib/src/core/services/avatar_service.dart):
  AVATAR frame : 264x280. Head centre x=132, head top y=36, ear line y=110,
                 jaw y=181. Hair + Outfit live here.
  FACE frame   : translate(76,82) -> face centre x=56. Eyes (30,30)/(82,30),
                 brows x 11..43 / 69..101 y 6..27, nose x 44..68 y 48..56,
                 mouth x 42..70 y 70..81. Facial hair, eyebrows, eyes, nose,
                 mouth and accessories live here and inherit fill #000000.
"""

import math

def f(v):
    s = f"{v:.1f}"
    return s[:-2] if s.endswith('.0') else s

def lerp(a, b, t):
    return a + (b - a) * t


# ===========================================================================
#  FACIAL HAIR  - face frame, colourable
# ===========================================================================
def facial_hair_items():
    """Facial hair in the face frame (the Face group is translate(76,82)).

    Face-frame landmarks MEASURED from the built-in assets (they are NOT
    guesses any more -- see contrib/generator/_refframe.py which samples the
    real path data of every built-in item):

        built-in FullBeard   x -3 .. 115   y 18 .. 117
        built-in BeardLight  x -1 .. 113   y 18 .. 107
        built-in MoustacheFancy   y 57 .. 72
        built-in MoustacheMagnum  y 54 .. 70
        built-in nose             x 40 .. 72   y 36 .. 60
        built-in mouth            x 42 .. 70   y 70 .. 82

    So: the beard band starts at the ear line (y 18) and the chin reaches
    y 117.  The earlier revision used top=30 / chin=99, which dropped the
    whole family onto the middle of the face -- that was the visible offset.
    """
    out = []

    def add(name, body):
        out.append((name, body))

    # The merge step wraps every facial-hair item in translate(-28,-8)
    # (verified against the built-in items), so the geometry the helper emits
    # must be shifted by (+28, +8):  the built-in FullBeard carries the wrapper
    # translate(-28,-8) and its own content spans y 26..125, which lands on the
    # face as y 18..117.
    OX, OY = 28.0, 8.0

    # ear line (where a beard starts) and the real chin, in the wrapped frame
    EAR = 18 + OY     # 26 -> face 18
    CHIN = 117 + OY   # 125 -> face 117
    CX = 56 + OX      # 84 -> face 56

    def jaw(chin=CHIN, wide=0):
        """The lower jaw contour as a point list (left cheek -> chin -> right)."""
        return [(OX + wide, EAR + 32), (OX + 2 + wide, EAR + 56),
                (OX + 13 + wide, EAR + 72), (OX + 30, chin - 2), (CX, chin),
                (OX + 82, chin - 2), (OX + 99 - wide, EAR + 72),
                (OX + 110 - wide, EAR + 56), (OX + 112 - wide, EAR + 32)]

    def beard(chin=CHIN, top=EAR, cheek=56, mouth_gap=True, spread=1.0):
        """A beard: the jaw band, with the lips cut out.

        `chin`     y of the lowest point (117 for the full beard)
        `top`      y where the sideburn starts (18 == the ear line)
        `cheek`    y of the inner (upper) edge at the cheek
        `spread`   1 = full beard, < 1 = a narrower chinstrap
        """
        outer = [(OX + 0, top), (OX + 1, top + 20), (OX + 2, top + 46),
                 (OX + 13, top + 62), (OX + 30, chin - 2), (CX, chin),
                 (OX + 82, chin - 2), (OX + 99, top + 62), (OX + 110, top + 46),
                 (OX + 111, top + 20), (OX + 112, top)]
        if spread < 1:
            # A chinstrap hugs the jaw much closer.
            outer = [(OX + 0, top), (OX + 1, top + 20), (OX + 4, top + 46),
                     (OX + 18, top + 62), (OX + 34, chin - 2), (CX, chin),
                     (OX + 78, chin - 2), (OX + 94, top + 62),
                     (OX + 108, top + 46), (OX + 111, top + 20), (OX + 112, top)]
        d = [f'M{outer[0][0]},{outer[0][1]}']
        for a, b in zip(outer, outer[1:]):
            d.append(f'C{a[0]},{(a[1]+b[1])/2} {b[0]},{(a[1]+b[1])/2} {b[0]},{b[1]}')
        # Inner edge: back up along the cheek, over the top of the beard.
        if mouth_gap:
            d.append(f'L{OX+74},{OY+76} C{OX+66},{OY+68} {OX+46},{OY+68} {OX+38},{OY+76}')
        else:
            d.append(f'L{OX+74},{OY+cheek} C{OX+64},{OY+cheek-8} {OX+48},{OY+cheek-8} {OX+38},{OY+cheek}')
        d.append(f'C{OX+16},{top+40} {OX+4},{top+26} {OX+0},{top} Z')
        return '<path d="' + ' '.join(d) + '" />'

    def moustache(w=26, top=57, drop=4, thick=9):
        """A moustache sitting between the nose (y 60) and the mouth (y 70)."""
        return (f'<path d="M{CX},{top+thick} '
                f'C{CX-w*0.45},{top+thick-2} {CX-w},{top-2} {CX-w-3},{top+4} '
                f'C{CX-w-5},{top+10} {CX-w+5},{top+11} {CX},{top+8} '
                f'C{CX+w-5},{top+11} {CX+w+5},{top+10} {CX+w+3},{top+4} '
                f'C{CX+w},{top-2} {CX+w*0.45},{top+thick-2} {CX},{top+thick} Z" />')

    def chin_patch(w=13, top=98, bottom=CHIN):
        """A patch of hair under the mouth."""
        return (f'<path d="M{CX-w},{top} C{CX-w},{bottom-8} {CX-w*0.5},{bottom} {CX},{bottom} '
                f'C{CX+w*0.5},{bottom} {CX+w},{bottom-8} {CX+w},{top} '
                f'C{CX+w*0.5},{top+4} {CX-w*0.5},{top+4} {CX-w},{top} Z" />')

    def sideburn(x, top=EAR, bottom=92, w=6):
        return (f'<path d="M{x},{top} C{x-1},{top+20} {x-1},{bottom-16} {x+2},{bottom} '
                f'L{x+w+2},{bottom} C{x+w+1},{bottom-16} {x+w-1},{top+20} {x+w},{top} Z" />')

    def stubble(density=0.16, spread=1.0):
        """Stubble: a field of dots over the jaw."""
        pts = []
        for r in range(13):
            for c in range(17):
                x = 2 + OX + c * 6.6
                y = 44 + OY + r * 5.6
                if ((x - CX) / (CX * spread)) ** 2 + ((y - (OY + 88)) / 30) ** 2 < 1:
                    pts.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="1.5" fill-opacity="{density:.2f}" />')
        return ''.join(pts)

    # --- 1..12  full beards ------------------------------------------------
    add('FullBeard', beard(chin=117, top=EAR, cheek=56))
    add('FullBeardLong', beard(chin=132, top=EAR, cheek=56))
    add('ShortBeard', beard(chin=108, top=EAR + 4, cheek=62))
    add('BoxedBeard', beard(chin=114, top=EAR, cheek=60))
    add('Chinstrap', beard(chin=114, top=EAR + 2, cheek=68, spread=0.55))
    add('HeavyStubbleBeard', beard(chin=108, top=EAR + 6, cheek=64))
    add('Goatee', chin_patch(w=12, top=98, bottom=112) +
        '<path d="M78,70 C76,74 78,79 84,80 C90,79 92,74 90,70 C88,73 80,73 78,70 Z" />')
    add('VanDyke', chin_patch(w=13, top=96, bottom=112) +
        '<path d="M76,65 C74,68 75,71 78,72 C81,73 84,73 84,73 C84,73 87,73 90,72 '
        'C93,71 94,68 92,65 C90,67 78,67 76,65 Z" />')
    add('AnchorBeard', chin_patch(w=11, top=100, bottom=112) +
        '<path d="M72,66 C68,74 70,82 76,86 C80,88 84,88 84,88 C84,88 88,88 92,86 '
        'C98,82 100,74 96,66 C90,72 78,72 72,66 Z" />')
    add('BeardWithMoustache', beard(chin=114, top=EAR, cheek=58) + moustache(w=24, top=57))
    add('NeatBeard', beard(chin=110, top=EAR + 2, cheek=60))
    add('Brave', beard(chin=117, top=EAR, cheek=56))
    add('FullCircleBeard', beard(chin=114, top=EAR, cheek=54) +
        '<path d="M64,104 C64,76 72,62 84,62 C96,62 104,76 104,104 C104,114 96,120 84,120 C72,120 64,114 64,104 Z" fill-opacity="0.55" />')
    add('Beaded', beard(chin=114, top=EAR + 2, cheek=60) +
        ''.join(f'<circle cx="{56+k*5-25}" cy="{113}" r="2.4" />' for k in range(11)))
    add('MuttonCheeksBeard', sideburn(2, EAR, 100, 7) + sideburn(104, EAR, 100, 7) +
        chin_patch(w=16, top=100, bottom=CHIN))
    add('SoulPatchBeard', beard(chin=114, top=EAR + 2, cheek=60) +
        '<path d="M78,72 C76,75 77,79 84,80 C91,79 92,75 90,72 C88,74 80,74 78,72 Z" />')
    add('FrenchBeard', beard(chin=120, top=EAR, cheek=58) +
        '<path d="M80,66 C82,76 82,96 84,112 C86,96 86,76 88,66 C86,70 82,70 80,66 Z" />')
    add('HollywoodBeard', chin_patch(w=14, top=98, bottom=112) + moustache(w=22, top=57))
    add('DucktailBeard', beard(chin=110, top=EAR + 2, cheek=62) +
        '<path d="M78,102 C76,108 78,116 84,120 C90,116 92,108 90,102 C88,106 80,106 78,102 Z" />')
    add('BaldingBeard', beard(chin=110, top=EAR + 8, cheek=64))
    add('LayeredBeard', beard(chin=117, top=EAR, cheek=56) +
        '<path d="M68,106 C72,116 78,122 84,125 C90,122 96,116 100,106 C96,114 90,118 84,118 '
        'C78,118 72,114 68,106 Z" fill="#000000" fill-opacity="0.18" />')

    # --- 13..24  moustaches ------------------------------------------------
    add('Handlebar', moustache(w=26, top=57) +
        '<path d="M58,68 C52,60 40,62 40,70 C40,78 52,79 58,72 C53,71 51,65 58,66 Z" />'
        '<path d="M110,68 C116,60 128,62 128,70 C128,78 116,79 110,72 C115,71 117,65 110,66 Z" />')
    add('Pencil', '<path d="M66,70 C70,67 78,66 83,68 L83,71 C78,69 71,70 66,72 Z" />'
                  '<path d="M102,70 C98,67 90,66 85,68 L85,71 C90,69 97,70 102,72 Z" />')
    add('FuManchu', '<path d="M79,66 C82,63 86,63 89,66 L89,70 C86,68 82,68 79,70 Z" />'
                    '<path d="M80,72 C82,86 82,100 84,118 C86,100 86,86 88,72 C86,76 82,76 80,72 Z" />')
    add('Horseshoe', moustache(w=24, top=57) +
        '<path d="M74,70 C78,78 81,80 84,78 C87,80 90,78 94,70 C92,86 89,106 84,112 C79,106 76,86 74,70 Z" />')
    add('Chevron', '<path d="M68,66 C72,61 78,61 79,66 C80,70 76,73 72,71 C75,68 73,65 69,67 Z" />'
                   '<path d="M100,66 C96,61 90,61 89,66 C88,70 92,73 96,71 C93,68 95,65 99,67 Z" />'
                   '<path d="M80,65 C82,63 86,63 87,66 C88,71 82,74 80,69 Z" />'
                   '<path d="M88,65 C86,63 82,63 81,66 C80,71 86,74 88,69 Z" />')
    add('Walrus', '<path d="M68,66 C72,60 80,60 82,66 C84,73 78,78 72,74 C76,70 73,65 69,67 Z" />'
                  '<path d="M100,66 C96,60 88,60 86,66 C84,73 90,78 96,74 C92,70 95,65 99,67 Z" />')
    add('Toothbrush', '<path d="M79,66 L89,66 L89,82 C89,88 79,88 79,82 Z" />')
    add('Droopy', '<path d="M62,68 C57,62 49,65 50,73 C51,81 59,83 63,77 C57,77 55,69 62,69 Z" />'
                  '<path d="M106,68 C111,62 119,65 118,73 C117,81 109,83 105,77 C111,77 113,69 106,69 Z" />')
    add('Curled', moustache(w=24, top=57, drop=6) +
        '<circle cx="24" cy="57" r="5" /><circle cx="88" cy="57" r="5" />')
    add('ThickMoustache', moustache(w=22, top=57, thick=13))
    add('MoustacheFancy', moustache(w=26, top=57) +
        '<path d="M58,68 C54,74 58,80 64,78 C60,76 59,71 64,70 Z" />'
        '<path d="M110,68 C114,74 110,80 104,78 C108,76 109,71 104,70 Z" />')
    add('SmallMoustache', '<path d="M72,68 C76,65 81,65 84,67 C87,65 92,65 96,68 '
                          'C92,72 87,72 84,70 C81,72 76,72 72,68 Z" />')
    add('UpturnedMoustache', '<path d="M62,70 C56,64 46,66 46,74 C46,80 56,81 62,74 '
                              'C57,73 55,67 62,68 Z" />'
                              '<path d="M106,70 C112,64 122,66 122,74 C122,80 112,81 106,74 '
                              'C111,73 113,67 106,68 Z" />')
    add('MoustacheGoatee', moustache(w=24, top=57) + chin_patch(w=10, top=98, bottom=113))
    add('MoustacheAndChops', moustache(w=26, top=57) +
        sideburn(2, 20, 84, 5) + sideburn(104, 20, 84, 5))
    add('MoustacheOnly', moustache(w=28, top=57, thick=11))
    add('BareMoustache', '<path d="M68,69 C74,66 80,66 84,68 C88,66 94,66 100,69 '
                         'C94,72 88,72 84,70 C80,72 74,72 68,69 Z" />')

    # --- 25..36  chin pieces / side pieces ---------------------------------
    add('GoateeSmall', chin_patch(w=8, top=102, bottom=113))
    add('GoateeLong', chin_patch(w=11, top=96, bottom=115) +
        '<path d="M78,74 C76,78 78,82 84,83 C90,82 92,78 90,74 C88,77 80,77 78,74 Z" />')
    add('ChinPatch', chin_patch(w=9, top=102, bottom=113))
    add('SoulPatch', '<path d="M78,70 C76,73 77,77 84,78 C91,77 92,73 90,70 C88,72 80,72 78,70 Z" />')
    add('MuttonChops', sideburn(2, 18, 100, 8) + sideburn(102, 18, 100, 8))
    add('MuttonChopsLong', sideburn(2, 18, 114, 9) + sideburn(100, 18, 114, 9))
    add('Sideburns', sideburn(2, 18, 88, 6) + sideburn(104, 18, 88, 6))
    add('SideburnsLong', sideburn(2, 18, 100, 7) + sideburn(103, 18, 100, 7))
    add('CheekLines', '<path d="M36,80 C34,94 36,106 42,116 C46,106 42,94 42,80 Z" />'
                      '<path d="M132,80 C134,94 132,106 126,116 C122,106 126,94 126,80 Z" />')
    add('BeardGoateeCombo', beard(chin=108, top=24, cheek=64, spread=0.7) +
        chin_patch(w=10, top=100, bottom=114))
    add('StubbleMask', beard(chin=108, top=24, cheek=66, spread=0.8))
    add('ShadowBeard', stubble(density=0.13))
    add('HeavyStubble', stubble(density=0.22))
    add('FiveOClock', stubble(density=0.18, spread=0.8))
    add('NeckBeard', '<path d="M32,90 C32,112 54,125 84,125 C114,125 136,112 136,90 C132,108 110,120 84,120 C58,120 36,108 32,90 Z" />')
    add('PatchBeard', chin_patch(w=13, top=98, bottom=113))
    add('HandlebarPatch', chin_patch(w=11, top=100, bottom=112) +
        '<path d="M60,68 C55,62 45,64 45,71 C45,78 55,80 60,74 C55,73 53,67 60,68 Z" />'
        '<path d="M108,68 C113,62 123,64 123,71 C123,78 113,80 108,74 C113,73 115,67 108,68 Z" />')
    add('MuttonChopsBeard', sideburn(2, 18, 96, 7) + sideburn(103, 18, 96, 7) +
        chin_patch(w=14, top=100, bottom=114))
    add('FullGoatee', chin_patch(w=14, top=94, bottom=114) +
        '<path d="M70,68 C66,78 68,88 76,94 C80,96 84,96 84,96 C84,96 88,96 92,94 C100,88 102,78 98,68 C90,74 78,74 70,68 Z" />')
    add('DucktailGoatee', chin_patch(w=9, top=102, bottom=115) +
        '<path d="M78,72 C76,76 78,80 84,81 C90,80 92,76 90,72 C88,74 80,74 78,72 Z" />')
    add('ImperialGoatee', '<path d="M80,88 C82,98 82,112 84,120 C86,112 86,98 88,88 C86,92 82,92 80,88 Z" />')
    add('CheekPatches', '<path d="M38,82 C36,96 40,108 48,116 C52,106 46,94 48,82 Z" />'
                         '<path d="M130,82 C132,96 128,108 120,116 C116,106 122,94 120,82 Z" />')
    add('NeckPatch', '<path d="M54,118 C64,124 104,124 114,118 C104,125 64,125 54,118 Z" />')
    add('CornerPatch', chin_patch(w=14, top=98, bottom=112) +
        '<path d="M34,84 C32,96 36,108 44,114 C48,104 42,92 44,84 Z" />'
        '<path d="M134,84 C136,96 132,108 124,114 C120,104 126,92 124,84 Z" />')
    add('WideChops', sideburn(0, 16, 106, 11) + sideburn(101, 16, 106, 11))
    add('ThinChops', sideburn(2, 20, 92, 4) + sideburn(106, 20, 92, 4))
    add('BeardStubbleCombo', beard(chin=110, top=22, cheek=62) + stubble(density=0.09))
    add('PencilBeard', '<path d="M72,68 C76,66 80,66 84,68 C88,66 92,66 96,68 '
                       'C92,71 88,71 84,69 C80,71 76,71 72,68 Z" />' +
        chin_patch(w=8, top=102, bottom=112))
    add('MedievalBeard', chin_patch(w=16, top=92, bottom=117) +
        '<path d="M78,68 C74,82 76,100 84,106 C92,100 94,82 90,68 C86,74 82,74 78,68 Z" />')
    add('SharpChinBeard', chin_patch(w=11, top=100, bottom=115) +
        '<path d="M80,108 C81,116 82,121 84,123 C86,121 87,116 88,108 C86,112 82,112 80,108 Z" />')
    add('MoustacheShadow', '<path d="M66,68 C72,65 80,65 84,67 C88,65 96,65 102,68 '
                           'C96,71 89,71 84,69 C79,71 72,71 66,68 Z" fill-opacity="0.5" />')
    add('FullBeardShadow', beard(chin=114, top=18, cheek=56) + stubble(density=0.08))
    add('ClassicMoustache', moustache(w=27, top=57, drop=5, thick=8))
    add('BigBeard', beard(chin=120, top=16, cheek=54))
    add('TrimmedBeard', beard(chin=110, top=20, cheek=62))
    add('RoundedBeard', chin_patch(w=17, top=96, bottom=114) +
        '<path d="M67,90 C63,100 66,110 76,114 C80,116 84,116 84,116 C84,116 88,116 92,114 C102,110 105,100 101,90 C92,96 76,96 67,90 Z" />')
    return out


# ===========================================================================
#  EYEBROWS  - face frame
# ===========================================================================
def eyebrow_items():
    out = []
    def add(name, body):
        out.append((name, body))

    # Left brow spans x 11..43, right brow 69..101, y roughly 6..27.
    def brow_pair(left_d, right_d, fill="#000000", stroke=None, sw=5):
        if stroke:
            l = f'<path d="{left_d}" fill="none" stroke="{fill}" stroke-width="{sw}" stroke-linecap="round" />'
            r = f'<path d="{right_d}" fill="none" stroke="{fill}" stroke-width="{sw}" stroke-linecap="round" />'
        else:
            l = f'<path d="{left_d}" fill="{fill}" />'
            r = f'<path d="{right_d}" fill="{fill}" />'
        return l + r

    add('Straight', brow_pair('M13,16 L41,16', 'M99,16 L71,16', stroke=True, sw=5))
    add('StraightThin', brow_pair('M13,17 L41,17', 'M99,17 L71,17', stroke=True, sw=3))
    add('StraightBold', brow_pair('M13,16 L41,16', 'M99,16 L71,16', stroke=True, sw=7))
    add('Arched', brow_pair('M12,19 Q26,8 41,15', 'M100,19 Q86,8 71,15', stroke=True, sw=5))
    add('ArchedHigh', brow_pair('M12,20 Q26,5 41,14', 'M100,20 Q86,5 71,14', stroke=True, sw=5))
    add('Slanted', brow_pair('M12,22 L42,11', 'M100,22 L70,11', stroke=True, sw=5))
    add('SlantedUp', brow_pair('M12,24 L42,9', 'M100,24 L70,9', stroke=True, sw=5))
    add('SlantedDown', brow_pair('M12,12 L42,22', 'M100,12 L70,22', stroke=True, sw=5))
    add('Wavy', brow_pair('M12,18 Q19,10 26,16 Q33,22 41,13', 'M100,18 Q93,10 86,16 Q79,22 71,13', stroke=True, sw=5))
    add('Rounded', brow_pair('M14,19 Q27,7 40,19', 'M98,19 Q85,7 72,19', stroke=True, sw=6))
    add('RoundedSoft', brow_pair('M14,20 Q27,9 40,20', 'M98,20 Q85,9 72,20', stroke=True, sw=5))
    add('Bushy', brow_pair('M11,21 Q27,6 43,14 L43,21 Q27,13 15,27 Z', 'M101,21 Q85,6 69,14 L69,21 Q85,13 97,27 Z'))
    add('ThickBlock', brow_pair('M11,17 Q27,7 43,14 L43,21 Q27,15 13,22 Z', 'M101,17 Q85,7 69,14 L69,21 Q85,15 99,22 Z'))
    add('ThinArched', brow_pair('M13,18 Q27,9 41,15', 'M99,18 Q85,9 71,15', stroke=True, sw=3))
    add('ThinFlat', brow_pair('M13,17 L41,17', 'M99,17 L71,17', stroke=True, sw=2.5))
    add('Sharp', brow_pair('M12,23 L28,9 L43,16 L43,21 L28,15 L12,27 Z', 'M100,23 L84,9 L69,16 L69,21 L84,15 L100,27 Z'))
    add('Feathered', brow_pair('M12,20 Q27,8 42,15 L42,19 Q27,13 14,25 Z', 'M100,20 Q85,8 70,15 L70,19 Q85,13 98,25 Z') +
        '<g fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round">'
        '<path d="M18,10 L21,17"/><path d="M27,7 L29,15"/><path d="M37,9 L36,16"/>'
        '<path d="M94,10 L91,17"/><path d="M85,7 L83,15"/><path d="M75,9 L76,16"/></g>')
    add('Notched', brow_pair('M13,18 Q27,9 41,18', 'M99,18 Q92,15 87,13', stroke=True, sw=6) +
        '<path d="M79,13 Q75,13 72,17" fill="none" stroke="#000000" stroke-width="6" stroke-linecap="round"/>')
    add('Angled', brow_pair('M12,20 L20,11 L30,12 L42,19', 'M100,20 L92,11 L82,12 L70,19', stroke=True, sw=5))
    add('AngledThick', brow_pair('M12,21 L20,10 L30,11 L42,20 L42,25 L28,18 L12,26 Z', 'M100,21 L92,10 L82,11 L70,20 L70,25 L84,18 L100,26 Z'))
    add('HalfRound', brow_pair('M13,18 Q27,9 41,18', 'M99,18 Q85,9 71,18', stroke=True, sw=4))
    add('Curved', brow_pair('M12,20 Q26,7 41,16', 'M100,20 Q86,7 71,16', stroke=True, sw=6))
    add('CurvedThin', brow_pair('M13,20 Q26,9 41,16', 'M99,20 Q86,9 71,16', stroke=True, sw=3))
    add('Short', brow_pair('M14,17 L38,17', 'M98,17 L74,17', stroke=True, sw=5))
    add('Long', brow_pair('M9,16 L45,16', 'M103,16 L67,16', stroke=True, sw=5))
    add('HighArch', brow_pair('M12,22 Q26,4 42,14', 'M100,22 Q86,4 70,14', stroke=True, sw=5))
    add('LowArch', brow_pair('M12,16 Q27,12 42,17', 'M100,16 Q85,12 70,17', stroke=True, sw=5))
    add('StraightTapered', brow_pair('M13,16 L41,16 L41,13 L13,13 Z', 'M99,16 L71,16 L71,13 L99,13 Z'))
    add('ArchTapered', brow_pair('M12,20 Q26,7 41,14 L41,19 Q26,12 12,25 Z', 'M100,20 Q86,7 71,14 L71,19 Q86,12 100,25 Z'))
    add('SoftNatural', brow_pair('M13,18 Q27,10 41,16', 'M99,18 Q85,10 71,16', stroke=True, sw=4))
    add('NaturalFlat', brow_pair('M13,17 Q27,15 41,17', 'M99,17 Q85,15 71,17', stroke=True, sw=4))
    add('BoldArch', brow_pair('M12,20 Q26,7 42,15 L42,21 Q26,13 12,26 Z', 'M100,20 Q86,7 70,15 L70,21 Q86,13 100,26 Z'))
    add('ThickStraight', brow_pair('M12,15 L42,15 L42,21 L12,21 Z', 'M100,15 L70,15 L70,21 L100,21 Z'))
    add('ThinSlant', brow_pair('M13,21 L41,12', 'M99,21 L71,12', stroke=True, sw=3))
    add('WavyThick', brow_pair('M12,18 Q19,9 26,15 Q33,21 41,12 L41,19 Q33,27 26,21 Q19,15 12,24 Z', 'M100,18 Q93,9 86,15 Q79,21 71,12 L71,19 Q79,27 86,21 Q93,15 100,24 Z'))
    add('SoftPeak', brow_pair('M13,18 L24,11 L32,16 L41,15', 'M99,18 L88,11 L80,16 L71,15', stroke=True, sw=5))
    add('Hooked', brow_pair('M12,14 L12,22 Q26,10 41,15', 'M100,14 L100,22 Q86,10 71,15', stroke=True, sw=5))
    add('Pointed', brow_pair('M12,20 L26,9 L42,16 L42,21 L26,15 L12,25 Z', 'M100,20 L86,9 L70,16 L70,21 L86,15 L100,25 Z'))
    add('BrowDash', brow_pair('M13,16 L41,16', 'M99,16 L71,16', stroke=True, sw=4) +
        '<g fill="none" stroke="#000000" stroke-width="2" stroke-linecap="round">'
        '<path d="M17,14 L18,18"/><path d="M24,14 L25,18"/><path d="M31,14 L32,18"/><path d="M38,14 L39,18"/>'
        '<path d="M95,14 L94,18"/><path d="M88,14 L87,18"/><path d="M81,14 L80,18"/><path d="M74,14 L73,18"/></g>')
    add('AsymStraight', brow_pair('M13,16 L41,16', 'M99,18 L71,18', stroke=True, sw=5))
    add('AsymArch', brow_pair('M12,19 Q26,8 41,15', 'M100,21 Q86,10 71,17', stroke=True, sw=5))
    add('LowBrows', brow_pair('M13,21 L41,21', 'M99,21 L71,21', stroke=True, sw=5))
    add('HighBrows', brow_pair('M13,11 L41,11', 'M99,11 L71,11', stroke=True, sw=5))
    add('Angular', brow_pair('M12,17 L24,9 L33,13 L42,18', 'M100,17 L88,9 L79,13 L70,18', stroke=True, sw=4))
    add('ThinPointed', brow_pair('M12,20 L27,10 L42,16', 'M100,20 L85,10 L70,16', stroke=True, sw=2.5))
    add('FeatherLight', brow_pair('M13,19 Q27,9 41,16', 'M99,19 Q85,9 71,16', stroke=True, sw=2.5))
    add('ThickWavy', brow_pair('M11,19 Q18,8 26,15 Q33,22 42,13 L42,20 Q33,28 26,21 Q18,14 11,25 Z', 'M101,19 Q94,8 86,15 Q79,22 70,13 L70,20 Q79,28 86,21 Q94,14 101,25 Z'))
    add('HalfMoon', brow_pair('M12,20 Q26,8 41,16', 'M100,20 Q86,8 71,16', stroke=True, sw=7))
    add('TaperedSoft', brow_pair('M13,19 Q27,10 41,16 L41,19 Q27,15 13,22 Z', 'M99,19 Q85,10 71,16 L71,19 Q85,15 99,22 Z'))
    add('BrokenArch', brow_pair('M12,19 Q20,11 27,13 Q34,15 41,16', 'M100,19 Q92,11 85,13 Q78,15 71,16', stroke=True, sw=4))
    add('Peak', brow_pair('M12,19 L24,9 L33,15 L41,16', 'M100,19 L88,9 L79,15 L71,16', stroke=True, sw=5))
    add('Squared', brow_pair('M12,14 L41,12 L41,19 L12,21 Z', 'M100,14 L71,12 L71,19 L100,21 Z'))
    add('FeatherFine', brow_pair('M13,19 Q27,11 41,17', 'M99,19 Q85,11 71,17', stroke=True, sw=2))
    return out


# ===========================================================================
#  EYES  - face frame
# ===========================================================================
def eye_items():
    out = []
    def add(name, body):
        out.append((name, body))

    def pair(body, op=0.6):
        return f'<g fill-opacity="{op}">{body}</g>'

    def circles(lx, rx, cy, r, pr=None, white=False):
        s = ''
        for cx in (lx, rx):
            if white:
                s += f'<circle cx="{cx}" cy="{cy}" r="{f(r*1.9)}" fill="#FFFFFF" />'
            s += f'<circle cx="{cx}" cy="{cy}" r="{f(r)}" />'
            if pr:
                s += f'<circle cx="{cx}" cy="{cy}" r="{f(pr)}" fill="#000000" fill-opacity="0.8" />'
        return s

    add('Default', pair(circles(30, 82, 30, 6)))
    add('Big', pair(circles(30, 82, 30, 8)))
    add('Small', pair(circles(30, 82, 30, 4)))
    add('Wide', pair(circles(28, 84, 30, 6)))
    add('Narrow', pair(circles(30, 82, 30, 6, pr=4) .replace('r="6" fill-opacity="0.8"', 'r="4" fill-opacity="0.8"')))
    add('Round', pair(circles(30, 82, 30, 7)))
    add('Oval', pair(circles(30, 82, 30, 6, pr=3)))
    add('Sleepy', pair(circles(30, 82, 30, 5, pr=3) ))
    add('WideOpen', pair(circles(30, 82, 30, 9)))
    add('NarrowSlit', pair(circles(30, 82, 30, 5, pr=2.5)))
    add('Closed', pair('<path d="M22,30 Q30,24 38,30" fill="none" stroke="#000000" stroke-width="4" stroke-linecap="round" />'
                       '<path d="M74,30 Q82,24 90,30" fill="none" stroke="#000000" stroke-width="4" stroke-linecap="round" />', op=1))
    add('HalfClosed', pair('<path d="M22,30 Q30,26 38,30 L38,30 Q30,33 22,30 Z" />'
                           '<path d="M74,30 Q82,26 90,30 L90,30 Q82,33 74,30 Z" />'))
    add('Happy', pair('<path d="M22,32 Q30,22 38,32 Z" /><path d="M74,32 Q82,22 90,32 Z" />'))
    add('Squint', pair('<path d="M22,30 Q30,24 38,30 Q30,33 22,30 Z" /><path d="M74,30 Q82,24 90,30 Q82,33 74,30 Z" />'))
    add('Side', pair(circles(24, 76, 30, 6)))
    add('SideMore', pair(circles(22, 74, 30, 6)))
    add('Cross', pair(circles(34, 78, 30, 6)))
    add('Up', pair(circles(30, 82, 25, 6)))
    add('Down', pair(circles(30, 82, 34, 6)))
    add('Cry', pair(circles(30, 82, 30, 6) +
                     '<path d="M24,20 C26,26 28,32 26,38" fill="none" stroke="#000000" stroke-width="2" stroke-opacity="0.6"/>'
                     '<path d="M88,20 C86,26 84,32 86,38" fill="none" stroke="#000000" stroke-width="2" stroke-opacity="0.6"/>', op=0.6))
    add('Dizzy', pair(
        '<path d="M29,25.2 L34.5,30.7 C35,31.1 35.7,31.1 36.1,30.7 L37.7,29.1 C38.1,28.6 38.1,27.9 37.7,27.5 L32.2,22 L37.7,16.5 C38.1,16 38.1,15.3 37.7,14.9 L36.1,13.3 C35.6,12.9 34.9,12.9 34.5,13.3 L29,18.8 L23.5,13.3 C23,12.9 22.3,12.9 21.9,13.3 L20.3,14.9 C19.9,15.3 19.9,16 20.3,16.5 L25.8,22 L20.3,27.5 C19.9,28 19.9,28.7 20.3,29.1 L21.9,30.7 C22.4,31.1 23.1,31.1 23.5,30.7 Z" />'
        '<path d="M83,25.2 L88.5,30.7 C89,31.1 89.7,31.1 90.1,30.7 L91.7,29.1 C92.1,28.6 92.1,27.9 91.7,27.5 L86.2,22 L91.7,16.5 C92.1,16 92.1,15.3 91.7,14.9 L90.1,13.3 C89.6,12.9 88.9,12.9 88.5,13.3 L83,18.8 L77.5,13.3 C77,12.9 76.4,12.9 76,13.3 L74.3,14.9 C73.9,15.3 73.9,16 74.3,16.5 L79.8,22 L74.3,27.5 C73.9,28 73.9,28.7 74.3,29.1 L75.9,30.7 C76.4,31.1 77.1,31.1 77.5,30.7 Z" />', op=1))
    add('EyeRoll', pair('<circle cx="30" cy="30" r="13" fill="#FFFFFF" /><circle cx="82" cy="30" r="13" fill="#FFFFFF" />'
                         '<circle cx="30" cy="22" r="6" fill-opacity="0.7" /><circle cx="82" cy="22" r="6" fill-opacity="0.7" />', op=1))
    add('Hearts', pair(
        '<path d="M30,36 C22,30 22,23 26,21 C29,20 31,22 30,25 C29,22 31,20 34,21 C38,23 38,30 30,36 Z" fill="#FFFFFF" />'
        '<path d="M82,36 C74,30 74,23 78,21 C81,20 83,22 82,25 C81,22 83,20 86,21 C90,23 90,30 82,36 Z" fill="#FFFFFF" />', op=1))
    add('Star', pair(
        '<path d="M30,18 L32,26 L40,26 L33,31 L36,39 L30,34 L24,39 L27,31 L20,26 L28,26 Z" fill="#FFFFFF" />'
        '<path d="M82,18 L84,26 L92,26 L85,31 L88,39 L82,34 L76,39 L79,31 L72,26 L80,26 Z" fill="#FFFFFF" />', op=1))
    add('X', pair(
        '<path d="M24,24 L36,36 M36,24 L24,36" stroke="#000000" stroke-width="4" stroke-linecap="round" fill="none" />'
        '<path d="M76,24 L88,36 M88,24 L76,36" stroke="#000000" stroke-width="4" stroke-linecap="round" fill="none" />', op=1))
    add('Blank', pair('<circle cx="30" cy="30" r="8" fill="#FFFFFF" /><circle cx="82" cy="30" r="8" fill="#FFFFFF" />', op=1))
    add('TinyPupil', pair(circles(30, 82, 30, 7, pr=1.5)))
    add('BigPupil', pair(circles(30, 82, 30, 6, pr=5)))
    add('Ring', pair(circles(30, 82, 30, 8, pr=4)))
    add('Droopy', pair('<path d="M22,28 Q30,26 38,28 Q30,36 22,28 Z" /><path d="M74,28 Q82,26 90,28 Q82,36 74,28 Z" />'))
    add('Bags', pair(circles(30, 82, 30, 6) +
                     '<path d="M22,36 Q30,42 38,36" fill="none" stroke="#000000" stroke-width="1.6" stroke-opacity="0.4"/>'
                     '<path d="M74,36 Q82,42 90,36" fill="none" stroke="#000000" stroke-width="1.6" stroke-opacity="0.4"/>', op=0.6))
    add('Lazy', pair(circles(32, 84, 29, 6)))
    add('Wink', pair(circles(30, 82, 30, 6) +
                     '<path d="M74,30 Q82,24 90,30" fill="none" stroke="#000000" stroke-width="4" stroke-linecap="round" />', op=0.6))
    add('Sharp', pair('<path d="M22,26 L38,26 L38,34 L22,34 Z" /><path d="M74,26 L90,26 L90,34 L74,34 Z" />'))
    add('Almond', pair('<path d="M22,30 Q30,22 38,30 Q30,38 22,30 Z" /><path d="M74,30 Q82,22 90,30 Q82,38 74,30 Z" />'))
    add('DeepSet', pair(circles(30, 82, 31, 5) +
                     '<path d="M20,20 Q30,15 40,20" fill="none" stroke="#000000" stroke-width="3" stroke-opacity="0.5"/>'
                     '<path d="M72,20 Q82,15 92,20" fill="none" stroke="#000000" stroke-width="3" stroke-opacity="0.5"/>', op=0.6))
    add('Beady', pair(circles(30, 82, 30, 5, pr=3)))
    add('Innocent', pair(circles(30, 82, 30, 7, pr=4)))
    add('SleepyHalf', pair('<path d="M22,28 Q30,24 38,28 L38,32 Q30,35 22,32 Z" /><path d="M74,28 Q82,24 90,28 L90,32 Q82,35 74,32 Z" />'))
    add('Surprised', pair(circles(30, 82, 28, 9, pr=5)))
    add('Angry', pair('<path d="M22,26 L38,30 L38,36 L22,32 Z" /><path d="M74,30 L90,26 L90,32 L74,36 Z" />'))
    add('Calm', pair('<path d="M22,29 Q30,26 38,29 Q30,36 22,29 Z" /><path d="M74,29 Q82,26 90,29 Q82,36 74,29 Z" />'))
    add('Focused', pair(circles(30, 82, 30, 5, pr=2.5)))
    add('Bright', pair(circles(30, 82, 29, 7, pr=4)))
    add('Sunken', pair(circles(30, 82, 32, 4)))
    add('Sparkle', pair(circles(30, 82, 30, 7) +
                     '<circle cx="27" cy="27" r="2" fill="#FFFFFF" fill-opacity="1"/>'
                     '<circle cx="85" cy="27" r="2" fill="#FFFFFF" fill-opacity="1"/>', op=0.6))
    add('OvalIris', pair('<ellipse cx="30" cy="30" rx="7" ry="8" /><ellipse cx="82" cy="30" rx="7" ry="8" />'))
    add('Lidded', pair('<path d="M22,26 Q30,22 38,26 Q30,34 22,26 Z" />'
                        '<path d="M74,26 Q82,22 90,26 Q82,34 74,26 Z" />'))
    add('DroopyLid', pair('<path d="M22,28 Q30,25 38,29 Q30,36 22,28 Z" />'
                           '<path d="M74,29 Q82,25 90,28 Q82,36 74,29 Z" />'))
    add('HalfLid', pair('<path d="M22,28 Q30,25 38,28 Q30,32 22,28 Z" />'
                         '<path d="M74,28 Q82,25 90,28 Q82,32 74,28 Z" />'))
    add('Hollow', pair('<circle cx="30" cy="30" r="6" fill="none" stroke="#000000" stroke-width="2.4" />'
                        '<circle cx="82" cy="30" r="6" fill="none" stroke="#000000" stroke-width="2.4" />'))
    add('TinyIris', pair(circles(30, 82, 30, 6, pr=1.2)))
    add('WideIris', pair(circles(30, 82, 30, 9, pr=6)))
    add('Slanted', pair('<path d="M22,32 L38,26 L38,32 L22,36 Z" /><path d="M74,26 L90,32 L90,36 L74,32 Z" />'))
    add('Upturned', pair('<path d="M22,28 Q30,24 38,29 Q30,35 22,28 Z" /><path d="M74,29 Q82,24 90,28 Q82,35 74,29 Z" />'))
    add('Downturned', pair('<path d="M22,30 Q30,35 38,29 Q30,27 22,30 Z" /><path d="M74,29 Q82,35 90,30 Q82,27 74,29 Z" />'))
    add('Monolid', pair('<path d="M22,29 Q30,26 38,29 L38,32 Q30,34 22,32 Z" />'
                         '<path d="M74,29 Q82,26 90,29 L90,32 Q82,34 74,32 Z" />'))
    add('Creased', pair(circles(30, 82, 30, 6) +
                        '<path d="M22,25 Q30,21 38,25" fill="none" stroke="#000000" stroke-width="1.8" stroke-opacity="0.5"/>'
                        '<path d="M74,25 Q82,21 90,25" fill="none" stroke="#000000" stroke-width="1.8" stroke-opacity="0.5"/>', op=0.6))
    add('Cheeky', pair(circles(28, 84, 31, 6)))
    return out


# ===========================================================================
#  NOSE  - face frame  (x 44..68, y 48..58)
# ===========================================================================
def nose_items():
    out = []
    def add(name, body):
        out.append((name, body))

    def shape(d, extra=''):
        return f'<path d="{d}" fill="none" stroke="#000000" stroke-opacity="0.16" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round" />{extra}'

    add('Default', shape('M44,48 C44,52 49,56 56,56 C63,56 68,52 68,48'))
    add('Button', shape('M50,50 C50,54 53,56 56,56 C59,56 62,54 62,50'))
    add('Wide', shape('M40,48 C40,53 47,57 56,57 C65,57 72,53 72,48'))
    add('Small', shape('M50,50 C50,53 52,55 56,55 C60,55 62,53 62,50'))
    add('Nostrils', shape('M47,52 C47,55 50,57 56,57 C62,57 65,55 65,52') +
        '<ellipse cx="50" cy="53" rx="3.5" ry="2.5" fill="#000000" fill-opacity="0.16"/>'
        '<ellipse cx="62" cy="53" rx="3.5" ry="2.5" fill="#000000" fill-opacity="0.16"/>')
    add('Hooked', shape('M50,42 C50,52 58,55 63,58 C58,60 52,58 50,55'))
    add('Upturned', shape('M45,52 C49,59 63,59 67,52 C62,55 50,55 45,52'))
    add('Pointed', shape('M56,40 L63,56 L49,56 Z'))
    add('Bulbous', shape('M45,50 C45,56 50,59 56,59 C62,59 67,56 67,50'))
    add('Roman', shape('M53,36 L53,51 C53,56 58,59 63,58 C57,62 50,58 50,51 L50,36 Z'))
    add('Round', shape('M48,50 C48,55 51,57 56,57 C61,57 64,55 64,50'))
    add('Narrow', shape('M54,38 L54,52 C54,55 57,57 60,56 C57,59 51,57 51,52 L51,38 Z'))
    add('Snub', shape('M48,53 C50,58 62,58 64,53 C61,55 51,55 48,53 Z'))
    add('Long', shape('M54,34 L54,54 C54,58 58,60 63,59 C58,62 51,59 51,54 L51,34 Z'))
    add('Flat', shape('M46,52 C50,56 62,56 66,52'))
    add('Straight', shape('M54,38 L52,52 C52,55 56,57 60,56'))
    add('Beak', shape('M56,40 L60,52 L66,56 L52,56 L52,50 Z'))
    add('Soft', shape('M50,46 C50,52 53,55 56,55 C59,55 62,52 62,46'))
    add('Defined', shape('M56,36 L56,52 C56,56 60,57 64,55'))
    add('Tiny', shape('M52,51 C52,54 54,55 56,55 C58,55 60,54 60,51'))
    add('Big', shape('M44,46 C44,53 49,58 56,58 C63,58 68,53 68,46'))
    add('PigNose', shape('M50,50 C50,54 52,56 56,56 C60,56 62,54 62,50') +
        '<ellipse cx="51" cy="53" rx="2" ry="1.6" fill="#000000" fill-opacity="0.2"/>'
        '<ellipse cx="61" cy="53" rx="2" ry="1.6" fill="#000000" fill-opacity="0.2"/>')
    add('Sharp', shape('M56,42 L58,52 L62,56 L50,56 L54,52 Z'))
    add('Cleft', shape('M56,44 L56,52 M52,54 C54,57 58,57 60,54'))
    add('Droopy', shape('M48,48 C48,54 52,57 56,57 C60,57 64,54 64,48'))
    add('UpturnedWide', shape('M42,50 C46,58 66,58 70,50 C64,54 48,54 42,50'))
    add('Downturned', shape('M46,46 C46,52 50,55 56,55 C62,55 66,52 66,46'))
    add('Subtle', shape('M50,50 C50,53 53,55 56,55 C59,55 62,53 62,50', '<path d="M54,42 L54,48" stroke="#000000" stroke-opacity="0.1" stroke-width="2" fill="none" stroke-linecap="round"/>'))
    add('Angular', shape('M56,38 L53,52 L56,56 L59,52 Z'))
    add('Bridge', shape('M54,36 L54,50 C54,54 58,56 62,54'))
    add('WideBridge', shape('M52,36 L50,50 C50,55 62,55 62,50 L60,36'))
    add('Crooked', shape('M54,38 C53,46 51,50 53,54 C55,57 60,56 62,54'))
    add('ButtonSmall', shape('M51,51 C51,54 53,55 56,55 C59,55 61,54 61,51'))
    add('RomanHook', shape('M53,34 L52,48 C52,54 57,58 63,56 C58,61 50,57 50,50 L50,34 Z'))
    add('FlatBridge', shape('M46,50 C50,55 62,55 66,50 C62,53 50,53 46,50'))
    add('Aquiline', shape('M56,36 L51,48 L50,52 C52,55 60,55 62,52 L61,48 L56,36 Z'))
    add('Greek', shape('M56,36 L56,52 C56,56 59,57 62,56'))
    add('Snake', shape('M50,50 C53,53 59,53 62,50 C60,55 52,55 50,50 Z'))
    add('Broad', shape('M46,47 C46,54 50,57 56,57 C62,57 66,54 66,47'))
    add('Fine', shape('M51,49 C51,53 53,55 56,55 C59,55 61,53 61,49'))
    add('NostrilWide', shape('M46,50 C46,54 50,57 56,57 C62,57 66,54 66,50') +
        '<ellipse cx="48" cy="53" rx="4" ry="2.6" fill="#000000" fill-opacity="0.18"/>'
        '<ellipse cx="64" cy="53" rx="4" ry="2.6" fill="#000000" fill-opacity="0.18"/>')
    add('RoundedTip', shape('M51,48 C51,54 54,57 56,57 C58,57 61,54 61,48'))
    add('LongStraight', shape('M54,32 L53,52 C53,56 58,58 62,56'))
    add('Distinct', shape('M56,38 L55,50 C55,54 59,56 63,54'))
    add('SoftBridge', shape('M52,40 C52,48 51,52 54,55 C56,57 60,55 60,51'))
    add('Classic', shape('M50,48 C50,53 52,56 56,56 C60,56 62,53 62,48'))
    add('ButtonNose', shape('M51,50 C51,54 53,56 56,56 C59,56 61,54 61,50'))
    add('WideFlat', shape('M42,50 C42,54 48,57 56,57 C64,57 70,54 70,50'))
    add('ThinNose', shape('M53,40 L52,52 C52,55 56,56 60,55'))
    add('WideNostril', shape('M48,50 C48,55 51,57 56,57 C61,57 64,55 64,50') +
        '<ellipse cx="50" cy="53" rx="3" ry="2" fill="#000000" fill-opacity="0.18"/>'
        '<ellipse cx="62" cy="53" rx="3" ry="2" fill="#000000" fill-opacity="0.18"/>')
    add('SharperHook', shape('M52,38 C51,48 50,52 54,55 C56,56 60,55 62,53'))
    add('SoftButton', shape('M52,50 C52,53 54,55 56,55 C58,55 60,53 60,50'))
    add('StraightBridge2', shape('M56,36 L55,50 C55,54 58,56 61,54'))
    add('BroadTip', shape('M50,47 C50,54 53,57 56,57 C59,57 62,54 62,47'))
    add('NarrowBridge', shape('M55,34 L54,50 C54,54 57,56 60,55'))
    return out


# ===========================================================================
#  MOUTH  - face frame  (x 42..70, y 70..82)
# ===========================================================================
def mouth_items():
    out = []
    def add(name, body):
        out.append((name, body))

    def lips(top, bot, crease=''):
        s = f'<path d="{top}" />'
        if bot:
            s += f'<path d="{bot}" />'
        if crease:
            s += f'<path d="{crease}" fill="none" stroke="#000000" stroke-opacity="0.35" stroke-width="1" stroke-linecap="round" />'
        return s

    add('Default', lips('M42,74 Q56,70 70,74 Q56,78 42,74 Z', 'M45,74 Q56,82 67,74 Z'))
    add('Neutral', lips('M42,76 Q56,74 70,76 Q56,79 42,76 Z', 'M45,76 Q56,81 67,76 Z'))
    add('Smile', lips('M40,72 Q56,68 72,72 Q56,78 40,72 Z', 'M44,72 Q56,84 68,72 Z'))
    add('BigSmile', lips('M38,70 Q56,66 74,70 Q56,78 38,70 Z', 'M42,70 Q56,86 70,70 Z'))
    add('SmallSmile', lips('M46,73 Q56,70 66,73 Q56,77 46,73 Z', 'M48,73 Q56,80 64,73 Z'))
    add('Frown', lips('M42,72 Q56,78 70,72 Q56,75 42,72 Z', 'M45,72 Q56,80 67,72 Z'))
    add('Open', lips('M42,74 Q56,70 70,74 L68,82 Q56,88 44,82 Z',
                      'M45,76 Q56,81 67,76 Q56,85 45,76 Z'))
    add('OpenWide', lips('M40,73 Q56,69 72,73 L69,84 Q56,92 43,84 Z',
                         'M44,75 Q56,82 68,75 Q56,88 44,75 Z'))
    add('OpenSmall', lips('M46,74 Q56,71 66,74 L65,80 Q56,84 47,80 Z',
                          'M48,75 Q56,79 64,75 Q56,82 48,75 Z'))
    add('ToothSmile', lips('M40,72 Q56,68 72,72 Q56,78 40,72 Z',
                           'M42,72 Q56,76 70,72 L69,76 Q56,80 43,76 Z'))
    add('Buck', lips('M40,74 Q56,70 72,74 Q56,78 40,74 Z', 'M46,74 Q56,80 66,74 Z',
                      'M50,74 L62,74 L62,79 L50,79 Z'))
    add('Full', lips('M41,73 Q56,69 71,73 Q56,84 41,73 Z', ''))
    add('Thin', lips('M42,75 Q56,73 70,75 Q56,78 42,75 Z', ''))
    add('Wide', lips('M39,75 Q56,72 73,75 Q56,78 39,75 Z', ''))
    add('Narrow', lips('M46,75 Q56,73 66,75 Q56,78 46,75 Z', ''))
    add('Pout', lips('M43,73 Q56,69 69,73 Q56,84 43,73 Z', ''))
    add('Kiss', lips('M46,73 Q56,70 66,73 Q56,79 46,73 Z', ''))
    add('Grin', lips('M40,72 Q56,68 72,72 Q56,79 40,72 Z', 'M43,72 Q56,82 69,72 Z'))
    add('Sneer', lips('M42,73 Q50,70 56,73 Q62,70 70,73 Q56,78 42,73 Z', 'M46,73 Q56,79 66,73 Z'))
    add('Confused', lips('M44,72 Q52,74 56,73 Q60,72 68,75 Q56,78 44,72 Z', ''))
    add('Surprised', lips('M48,74 C48,68 64,68 64,74 C64,80 48,80 48,74 Z', ''))
    add('O', lips('M49,73 C49,67 63,67 63,73 C63,79 49,79 49,73 Z', ''))
    add('Ooh', lips('M48,73 C48,67 64,67 64,73 C64,81 48,81 48,73 Z', ''))
    add('Tongue', lips('M43,73 Q56,70 69,73 Q56,80 43,73 Z',
                        'M48,74 Q56,86 64,74 Q56,80 48,74 Z'))
    add('Teeth', lips('M42,73 Q56,70 70,73 L69,77 Q56,80 43,77 Z', ''))
    add('LowerLipOut', lips('M43,73 Q56,70 69,73 Q56,77 43,73 Z', 'M45,74 Q56,86 67,74 Z'))
    add('UpperLipOut', lips('M43,74 Q56,68 69,74 Q56,79 43,74 Z', 'M46,74 Q56,81 66,74 Z'))
    add('Heart', lips('M56,84 C46,76 42,71 45,68 C48,65 52,67 56,71 C60,67 64,65 67,68 C70,71 66,76 56,84 Z', ''))
    add('Tiny', lips('M49,75 Q56,73 63,75 Q56,78 49,75 Z', ''))
    add('Big', lips('M38,73 Q56,68 74,73 Q56,85 38,73 Z', ''))
    add('Asym', lips('M42,74 Q56,70 70,75 Q56,79 42,74 Z', 'M45,74 Q56,82 67,75 Z'))
    add('Cleft', lips('M42,74 Q56,70 70,74 Q56,78 42,74 Z', 'M45,74 Q56,82 67,74 Z',
                       'M56,71 L56,74'))
    add('MShape', lips('M44,74 L52,71 L56,73 L60,71 L68,74 Q56,78 44,74 Z', 'M46,74 Q56,81 66,74 Z'))
    add('Flat', lips('M42,75 Q56,73 70,75 Q56,77 42,75 Z', ''))
    add('Smirk', lips('M42,74 Q50,71 58,73 Q64,74 70,72 Q64,78 42,74 Z', ''))
    add('Biting', lips('M44,74 Q56,72 68,74 Q56,76 44,74 Z', ''))
    add('Pursed', lips('M48,74 C48,70 64,70 64,74 C64,79 48,79 48,74 Z', ''))
    add('Whistle', lips('M46,74 Q56,71 66,74 Q56,77 46,74 Z', ''))
    add('Contour', lips('M43,73 Q56,69 69,73 Q56,79 43,73 Z', ''))
    add('WideOpen', lips('M40,72 Q56,67 72,72 L70,86 Q56,94 42,86 Z', ''))
    add('SmileOpen', lips('M41,72 Q56,68 71,72 Q56,80 41,72 Z', 'M44,72 Q56,86 68,72 Z'))
    add('SideSmile', lips('M42,74 Q48,70 56,72 Q64,75 70,73 Q64,79 42,74 Z', ''))
    add('Ducky', lips('M44,74 Q50,71 56,73 Q62,71 68,74 Q56,80 44,74 Z', ''))
    add('Bow', lips('M46,73 Q56,71 66,73 Q56,76 46,73 Z', ''))
    add('FlatGrin', lips('M40,74 Q56,71 72,74 Q56,78 40,74 Z', 'M44,74 Q56,80 68,74 Z'))
    add('OpenGrin', lips('M40,72 Q56,68 72,72 L70,84 Q56,90 42,84 Z', 'M43,73 Q56,78 69,73 Q56,86 43,73 Z'))
    add('PursedRound', lips('M50,73 C50,68 62,68 62,73 C62,79 50,79 50,73 Z', ''))
    add('Subtle', lips('M45,75 Q56,73 67,75 Q56,78 45,75 Z', ''))
    add('BigTeeth', lips('M40,72 Q56,68 72,72 Q56,78 40,72 Z', 'M42,72 Q56,75 70,72 L69,78 Q56,81 43,78 Z'))
    add('Fangs', lips('M42,73 Q56,70 70,73 Q56,79 42,73 Z', 'M45,73 L49,73 L48,80 L45,80 Z M63,73 L67,73 L67,80 L64,80 Z'))
    add('LipsSealed', lips('M43,74 Q56,71 69,74 Q56,77 43,74 Z', ''))
    add('SoftSmile', lips('M43,74 Q56,70 69,74 Q56,79 43,74 Z', 'M46,74 Q56,81 66,74 Z'))
    return out


# ===========================================================================
#  ACCESSORIES  - face frame
# ===========================================================================
def accessory_items():
    out = []
    def add(name, body):
        out.append((name, body))

    def glasses_lenses(shape_l, shape_r, bridge='', frame='#000000', op=1.0, fill='none', sw=3):
        s = f'<g fill="{fill}" stroke="{frame}" stroke-width="{sw}" fill-opacity="{op}">{shape_l}{shape_r}{bridge}</g>'
        return s

    def round(r=17, cx1=28, cx2=84, frame='#000000'):
        return (f'<circle cx="{cx1}" cy="30" r="{r}" fill="none" stroke="{frame}" stroke-width="3" />'
                f'<circle cx="{cx2}" cy="30" r="{r}" fill="none" stroke="{frame}" stroke-width="3" />'
                f'<path d="M{cx1+r},30 L{cx2-r},30" stroke="{frame}" stroke-width="3" />')

    def rect_glasses(w=22, h=16, cx1=28, cx2=84, frame='#000000', rx=3):
        return (f'<rect x="{cx1-w}" y="{30-h}" width="{w*2}" height="{h*2}" rx="{rx}" fill="none" stroke="{frame}" stroke-width="3" />'
                f'<rect x="{cx2-w}" y="{30-h}" width="{w*2}" height="{h*2}" rx="{rx}" fill="none" stroke="{frame}" stroke-width="3" />'
                f'<path d="M{cx1+w},30 L{cx2-w},30" stroke="{frame}" stroke-width="3" />')

    add('RoundGlasses', round())
    add('RoundGlassesThin', round(frame='#000000').replace('stroke-width="3"', 'stroke-width="1.8"'))
    add('RoundGlassesThick', round(frame='#000000').replace('stroke-width="3"', 'stroke-width="5"'))
    add('SquareGlasses', rect_glasses())
    add('SquareGlassesSmall', rect_glasses(w=18, h=13))
    add('SquareGlassesLarge', rect_glasses(w=26, h=19))
    add('RectGlasses', rect_glasses(w=25, h=13, rx=0))
    add('Aviator', '<path d="M12,24 C12,16 44,16 44,24 C44,36 34,44 28,44 C22,44 12,36 12,24 Z" fill="#000000" fill-opacity="0.25" stroke="#000000" stroke-width="2.5" />'
                   '<path d="M68,24 C68,16 100,16 100,24 C100,36 90,44 84,44 C78,44 68,36 68,24 Z" fill="#000000" fill-opacity="0.25" stroke="#000000" stroke-width="2.5" />'
                   '<path d="M44,22 L68,22" stroke="#000000" stroke-width="2.5" />')
    add('Sunglasses', '<path d="M10,22 C10,14 46,14 46,22 L46,32 C46,40 36,44 28,44 C20,44 10,40 10,32 Z" fill="#000000" fill-opacity="0.85" />'
                       '<path d="M66,22 C66,14 102,14 102,22 L102,32 C102,40 92,44 84,44 C76,44 66,40 66,32 Z" fill="#000000" fill-opacity="0.85" />'
                       '<path d="M46,20 L66,20" stroke="#000000" stroke-width="3" />')
    add('Wayfarer', '<path d="M12,20 L44,20 L44,30 C44,38 36,42 28,42 C20,42 12,38 12,30 Z" fill="#000000" fill-opacity="0.85" />'
                    '<path d="M68,20 L100,20 L100,30 C100,38 92,42 84,42 C76,42 68,38 68,30 Z" fill="#000000" fill-opacity="0.85" />'
                    '<path d="M44,18 L68,18" stroke="#000000" stroke-width="4" />')
    add('CatEye', '<path d="M10,26 C10,18 30,14 44,20 L44,32 C30,38 12,34 10,26 Z" fill="none" stroke="#000000" stroke-width="3" />'
                  '<path d="M102,26 C102,18 82,14 68,20 L68,32 C82,38 100,34 102,26 Z" fill="none" stroke="#000000" stroke-width="3" />'
                  '<path d="M44,22 L68,22" stroke="#000000" stroke-width="3" />')
    add('HalfRim', '<path d="M10,30 L46,30" stroke="#000000" stroke-width="4" /><path d="M66,30 L102,30" stroke="#000000" stroke-width="4" />'
                   '<path d="M10,30 C10,20 46,20 46,30" fill="none" stroke="#000000" stroke-width="2" />'
                   '<path d="M66,30 C66,20 102,20 102,30" fill="none" stroke="#000000" stroke-width="2" />')
    add('Prescription', rect_glasses(w=24, h=15, rx=8))
    add('Reading', rect_glasses(w=20, h=14, cx1=26, cx2=86, rx=8))
    add('Monocle', '<circle cx="30" cy="30" r="17" fill="none" stroke="#000000" stroke-width="3" />'
                   '<path d="M43,40 C50,52 58,56 64,62" fill="none" stroke="#000000" stroke-width="1.6" />')
    add('SportShield', '<path d="M8,22 C24,14 88,14 104,22 L100,36 C80,30 32,30 12,36 Z" fill="#000000" fill-opacity="0.8" />')
    add('Goggles', '<circle cx="28" cy="30" r="18" fill="#000000" fill-opacity="0.2" stroke="#000000" stroke-width="3" />'
                   '<circle cx="84" cy="30" r="18" fill="#000000" fill-opacity="0.2" stroke="#000000" stroke-width="3" />'
                   '<path d="M46,24 L66,24" stroke="#000000" stroke-width="4" />')
    add('EyePatch', '<path d="M8,20 C24,16 40,16 48,20 C40,24 24,24 8,20 Z" fill="#000000" />'
                    '<path d="M8,20 L26,20 L26,40 L10,38 Z" fill="#000000" />'
                    '<path d="M48,20 C70,14 100,14 106,20" fill="none" stroke="#000000" stroke-width="3" />')
    add('StudEarrings', '<circle cx="14" cy="52" r="3.5" fill="#000000" /><circle cx="98" cy="52" r="3.5" fill="#000000" />')
    add('HoopEarrings', '<circle cx="14" cy="56" r="7" fill="none" stroke="#000000" stroke-width="2.5" />'
                        '<circle cx="98" cy="56" r="7" fill="none" stroke="#000000" stroke-width="2.5" />')
    add('DropEarrings', '<path d="M14,52 L14,60" stroke="#000000" stroke-width="2" />'
                         '<path d="M14,60 L9,68 L14,76 L19,68 Z" fill="#000000" />'
                         '<path d="M98,52 L98,60" stroke="#000000" stroke-width="2" />'
                         '<path d="M98,60 L93,68 L98,76 L103,68 Z" fill="#000000" />')
    add('NoseRing', '<circle cx="56" cy="58" r="4" fill="none" stroke="#000000" stroke-width="2" />')
    add('LipPiercing', '<circle cx="64" cy="76" r="3" fill="none" stroke="#000000" stroke-width="1.8" />')
    add('BrowPiercing', '<path d="M30,18 L30,10" stroke="#000000" stroke-width="1.6" /><circle cx="30" cy="9" r="2.4" fill="#000000" />')
    add('Mole', '<circle cx="30" cy="52" r="3" fill="#000000" fill-opacity="0.6" />')
    add('BeautyMark', '<circle cx="84" cy="54" r="3" fill="#000000" fill-opacity="0.6" />')
    add('Freckles', ''.join(f'<circle cx="{f(18+k*5)}" cy="{f(46+(k%3)*4)}" r="1.4" fill="#000000" fill-opacity="0.35" />' for k in range(9))
        + ''.join(f'<circle cx="{f(70+k*5)}" cy="{f(46+(k%3)*4)}" r="1.4" fill="#000000" fill-opacity="0.35" />' for k in range(9)))
    add('FacePaint', '<path d="M10,40 C20,34 36,36 42,42 C34,46 20,46 12,44 Z" fill="#000000" fill-opacity="0.5" />'
                     '<path d="M102,40 C92,34 76,36 70,42 C78,46 92,46 100,44 Z" fill="#000000" fill-opacity="0.5" />')
    add('SurgicalMask', '<path d="M14,44 C14,38 98,38 98,44 L98,70 C98,78 14,78 14,70 Z" fill="#000000" fill-opacity="0.35" />'
                        '<path d="M14,50 L98,50 M14,58 L98,58 M14,66 L98,66" stroke="#000000" stroke-opacity="0.3" stroke-width="1.4" />')
    add('Necklace', '<path d="M20,86 C28,96 44,102 56,102 C68,102 84,96 92,86" fill="none" stroke="#000000" stroke-width="2.5" />'
                    '<circle cx="56" cy="106" r="4" fill="#000000" />')
    add('Choker', '<path d="M22,88 C32,94 44,98 56,98 C68,98 80,94 90,88" fill="none" stroke="#000000" stroke-width="5" />')
    add('Scarf', '<path d="M16,84 C26,98 44,104 56,104 C68,104 86,98 96,84 L92,96 C80,106 68,110 56,110 '
                 'C44,110 32,106 20,96 Z" fill="#000000" fill-opacity="0.8" />')
    add('BowTie', '<path d="M38,66 L50,72 L38,79 Z" fill="#000000" /><path d="M74,66 L62,72 L74,79 Z" fill="#000000" />'
                  '<rect x="48" y="68" width="16" height="9" rx="2" fill="#000000" />')
    add('Tie', '<path d="M50,66 L62,66 L58,74 L62,90 L50,98 L40,90 L44,74 Z" fill="#000000" />')
    add('Headband', '<path d="M6,26 C18,12 94,12 106,26" fill="none" stroke="#000000" stroke-width="6" stroke-linecap="round" />')
    add('HairClip', '<path d="M84,10 L100,6 L104,20 L88,24 Z" fill="#000000" />')
    add('Tiara', '<path d="M32,20 L40,4 L48,16 L56,0 L64,16 L72,4 L80,20 Z" fill="#000000" />')
    add('Crown', '<path d="M30,24 L30,10 L42,18 L56,4 L70,18 L82,10 L82,24 Z" fill="#000000" />')
    add('Mask2', '<path d="M12,40 C30,34 82,34 100,40 L100,74 C82,80 30,80 12,74 Z" fill="#000000" fill-opacity="0.8" />')
    add('BeautyMask', '<path d="M22,42 C22,36 90,36 90,42 L90,74 C90,80 22,80 22,74 Z" fill="#000000" fill-opacity="0.15" />')
    add('EyePatch2', '<ellipse cx="28" cy="30" rx="20" ry="17" fill="#000000" />'
                     '<path d="M10,22 L46,20" fill="none" stroke="#000000" stroke-width="4" />')
    add('RoundShades', '<circle cx="28" cy="30" r="19" fill="#000000" fill-opacity="0.8" />'
                       '<circle cx="84" cy="30" r="19" fill="#000000" fill-opacity="0.8" />'
                       '<path d="M47,30 L65,30" stroke="#000000" stroke-width="4" />')
    add('BrowGlasses', '<path d="M8,24 L48,18" stroke="#000000" stroke-width="3" /><path d="M104,24 L64,18" stroke="#000000" stroke-width="3" />')
    add('ScarfLoop', '<path d="M30,90 C34,80 78,80 82,90 C76,100 36,100 30,90 Z" fill="#000000" fill-opacity="0.85" />')
    add('SquareGlassesBold', rect_glasses(w=24, h=17, rx=0))
    add('OvalGlasses', '<ellipse cx="28" cy="30" rx="23" ry="15" fill="none" stroke="#000000" stroke-width="3" />'
                       '<ellipse cx="84" cy="30" rx="23" ry="15" fill="none" stroke="#000000" stroke-width="3" />'
                       '<path d="M51,30 L61,30" stroke="#000000" stroke-width="3" />')
    add('TempleGlasses', '<path d="M12,26 L48,22" stroke="#000000" stroke-width="3" />'
                         '<path d="M100,26 L64,22" stroke="#000000" stroke-width="3" />')
    add('HalfMoonGlasses', '<path d="M14,26 L42,26 L42,40 L14,40 Z" fill="none" stroke="#000000" stroke-width="3" />'
                            '<path d="M70,26 L98,26 L98,40 L70,40 Z" fill="none" stroke="#000000" stroke-width="3" />'
                            '<path d="M42,28 L70,28" stroke="#000000" stroke-width="3" />')
    add('ChokerPendant', '<path d="M24,88 C34,96 46,100 56,100 C66,100 78,96 88,88" fill="none" stroke="#000000" stroke-width="4" />'
                          '<circle cx="56" cy="106" r="5" fill="#000000" />')
    add('ChainNecklace', '<path d="M22,86 C30,100 46,106 56,106 C66,106 82,100 90,86" fill="none" stroke="#000000" stroke-width="1.6" />')
    add('AnkleBand', '<path d="M22,86 C32,94 46,98 56,98 C66,98 80,94 90,86" fill="none" stroke="#000000" stroke-width="8" stroke-linecap="round" />')
    add('NoseStud', '<circle cx="56" cy="56" r="2.4" fill="#000000" />')
    add('CheekBlush', '<ellipse cx="18" cy="48" rx="8" ry="5" fill="#000000" fill-opacity="0.16" />'
                       '<ellipse cx="94" cy="48" rx="8" ry="5" fill="#000000" fill-opacity="0.16" />')
    add('UnderEyeShading', '<path d="M22,38 Q30,44 38,38" fill="none" stroke="#000000" stroke-opacity="0.18" stroke-width="3" />'
                            '<path d="M74,38 Q82,44 90,38" fill="none" stroke="#000000" stroke-opacity="0.18" stroke-width="3" />')
    add('GlassesStrap', '<path d="M6,30 L22,30" stroke="#000000" stroke-width="3" /><path d="M106,30 L90,30" stroke="#000000" stroke-width="3" />')
    add('NeckRibbon', '<path d="M48,88 L64,88 L60,96 L52,96 Z" fill="#000000" />'
                       '<path d="M56,96 L50,112" stroke="#000000" stroke-width="3" stroke-linecap="round" />')
    add('ShoulderBagStrap', '<path d="M30,30 L70,100" fill="none" stroke="#000000" stroke-width="4" />')
    return out


# ===========================================================================
#  BACKGROUND  - avatar frame, circle background
# ===========================================================================
def background_items():
    out = []
    def add(name, body):
        out.append((name, body))
    return out


# ===========================================================================
#  SKIN  - 50 distinct tones (this IS the colour category)
# ===========================================================================
def skin_items():
    tones = [
        ('Porcelain', '#FFE9D6'), ('Ivory', '#FCE4CB'), ('Fair', '#F8DCC0'),
        ('LightPeach', '#F5D3B2'), ('Peach', '#F2CBA6'), ('Almond', '#EFC79C'),
        ('Honey', '#E9BC8C'), ('Sand', '#E5B585'), ('Beige', '#E0AC7C'),
        ('WarmTan', '#DCA476'), ('Tan', '#D69C6C'), ('Apricot', '#D1925F'),
        ('Caramel', '#C9885A'), ('Bronze', '#C07F52'), ('Copper', '#B7764A'),
        ('GoldenBrown', '#AC6D42'), ('Cinnamon', '#A4643A'), ('Chestnut', '#9A5B33'),
        ('Clay', '#8F522C'), ('Umber', '#844A26'), ('Toffee', '#794220'),
        ('Cocoa', '#6F3B1B'), ('CocoaDeep', '#663417'), ('ChestnutDark', '#5C2E14'),
        ('Mahogany', '#542810'), ('Espresso', '#4B240E'), ('DarkBrown', '#43200C'),
        ('DeepBrown', '#3B1C0A'), ('Ebony', '#331809'), ('Sepia', '#2E1608'),
        ('WarmBrown', '#5A3418'), ('BronzeDeep', '#8A5A2B'), ('TanDeep', '#A9713F'),
        ('GoldenDeep', '#B8853F'), ('Sunlit', '#C99A5C'), ('HoneyDeep', '#D2A463'),
        ('Amber', '#DBB06A'), ('Ochre', '#E2BE76'), ('Sandy', '#E9CB84'),
        ('PaleGold', '#EFD795'), ('Cream', '#F4E2A8'), ('Shell', '#F7E9BC'),
        ('Vanilla', '#FAEFCE'), ('Butter', '#FCF4DA'), ('Snow', '#FEF9E6'),
        ('RoseBeige', '#F0C8B4'), ('SoftRose', '#EBB7A6'), ('DustyRose', '#E3A898'),
        ('Terracotta', '#D99A86'), ('ClayRose', '#CE8C77'),
    ]
    return [(n, f'<g id="SkinColor/{n}" mask="url(#mask-6)" fill="{c}"><rect x="0" y="0" width="264" height="280" /></g>')
            for n, c in tones]
