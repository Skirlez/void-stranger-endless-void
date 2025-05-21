// Lightning Bolt!
function ev_run_tis_lightning_check() {
	if !variable_instance_exists(id, "has_moved")
		has_moved = false;
	
	if has_moved {
		if o_move_x == 0 and o_move_y == 0 and (xprevious != x || yprevious != y) {
			if point_distance(x, y, xprevious, yprevious) > 16 {
				instance_create_layer(x, (y - 56), "Player", agi("obj_judgment_flash"));
			}
			has_moved = false;
		}
	}
	else {
		if o_move_x != 0 || o_move_y != 0 {
			has_moved = true;
		}
	}
}