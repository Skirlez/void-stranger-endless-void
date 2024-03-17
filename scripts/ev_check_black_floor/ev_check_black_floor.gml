
function ev_check_black_floor(pos_x, pos_y) {
	static floor_obj = asset_get_index("obj_floor_tile")
	var inst = instance_place(pos_x, pos_y, floor_obj)
	if inst == noone
		return false;
	if (variable_instance_exists(inst, "black_floor"))
		return true;
}