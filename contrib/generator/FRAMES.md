"""README of the frame model actually used by avatar_maker.

Every family is authored in a DIFFERENT local frame; the built-in assets wrap
their geometry in an outer <g id="<Family>/<Name>" transform="..."> which is
what puts the drawing on the face. The measured facts (from
contrib/generator/_transforms.py and _refframe.py):

  Family        outer transform            content box          where it lands
  ------------  -------------------------  -------------------  ---------------
  OutfitTypes   translate(0, 170)         x 32..232 y 0..110   the torso
  HairStyles    (varies / none)           x 32..232 y 36..280  the skull
  FacialHair    (varies / none)           x -3..115 y 18..117  jaw + cheeks
  Eyebrows      (none)                    x 8..104  y 0..24    above the eyes
  Eyes          translate(0, 8)           x 16..96  y 16..28   eye line
  Noses         (none)                    x 38..74  y 34..61   nose
  Mouths        translate(2, 52)          x 0..100  y 0..44    the mouth
  Accessories   (varies / none)           x -22..129 y -24..112

So a generated item must emit the SAME wrapper the built-ins use, otherwise it
is drawn in the Face group's own coordinates and floats.

The generators therefore expose the wrapper in the item body itself and the
merge step must not add a second one.
"""
print(__doc__)
