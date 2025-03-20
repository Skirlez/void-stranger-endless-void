// TARGET: HEAD
// Black floor has another patch for making it actually draw the black floor sprite. sprite index is also used for the 
// edge graphic, so we set it to the default sprite even if global.universe is 1, since that pit doesn't look right with the black floor.
if variable_instance_exists(id, "black_floor")
    sprite_index = spr_floor
else