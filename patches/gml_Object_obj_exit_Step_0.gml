// redundant check
// TARGET: LINENUMBER_REPLACE
// 84
if (true)

// redundant check
// TARGET: LINENUMBER_REPLACE
// 82
if (true)


// TARGET: LINENUMBER_REPLACE
// 80
// kill player if cif statue is ontop of exit instead of reseting the playthrough. also override the line that checks for cif statue, we're doing that on our own.
var cif_flicker = false
var are_all_lamp = true
with (obj_exit) {
	var cif = instance_place(x, y - 16, obj_boulder)
	with (cif) {
		if (b_form == 4 && !variable_instance_exists(id, "editor_lamp")) {
			are_all_lamp = false
			break;
		}
	}
}

should_kill_instead = room != rm_ev_pack_level || are_all_lamp

if (should_kill_instead) {
	with (obj_player)
		state = 6
	with (obj_exit) {
		var cif_flicker = instance_place(x, (y - 16), obj_boulder)
		with (cif_flicker)
		{
			if (b_form == 4)
			{
				flicker = 1
			}
		}
	}
	next_room = 1
	exit
}

// make all cifs above exits flicker
with (obj_boulder) {
	flicker = (b_form == 4 && !variable_instance_exists(id, "editor_lamp") && place_meeting(x, y + 16, obj_exit));
}