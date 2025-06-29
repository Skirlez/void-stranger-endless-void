// remove part of the code that makes cif above exit remain on screen for the cif reset graphics.
// in EV the statue doesn't have to be above our exit.

// TARGET: LINENUMBER_REPLACE
// 1
var cif_atoner = noone;
with (obj_boulder) {
	if (b_form == 4 && !variable_instance_exists(id, "editor_lamp") && place_meeting(x, y + 16, obj_exit)) {
		depth = 80
        atoner = true
	}

}