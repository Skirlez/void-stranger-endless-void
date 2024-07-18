/* This object's one and only purpose is so that wall tiles will draw the
pit sprite if they have glass below them. Woah!!!
Usually, the pit object does this, but it doesn't exist when there's a glass tile there instead.
So this object exists to do it in that specific case.
It also draws the pit when there isn't a glass tile, meaning it could get drawn twice, but we do not care.
*/

sprite_index = asset_get_index("spr_floor")