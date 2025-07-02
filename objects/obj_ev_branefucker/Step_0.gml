if global.is_merged {
	if (!instance_exists(add_inst)
			|| array_length(program) == 0)
		return;

	global.add_current_x = add_inst.x div 16
	global.add_current_y = add_inst.y div 16

	current_deaths = 0
	current_deaths += ds_list_find_value(asset_get_index("obj_inventory").ds_rcrds, 5)
	current_deaths += ds_list_find_value(asset_get_index("obj_inventory").ds_rcrds, 6)
	global.death_count = current_deaths - global.editor_instance.starting_deaths

	if (global.death_count != global.editor_instance.last_death_count) {
		//Player has just died
		current_death_x = asset_get_index("obj_player").x div 16
		current_death_y = asset_get_index("obj_player").y div 16
	
		if (global.death_x == current_death_x && global.death_y == current_death_y) {
			global.annoyance_count += 1
		}
		else {
			global.annoyance_count = 1
		}
	
		global.death_x = current_death_x
		global.death_y = current_death_y
		global.death_frames = 0
	}

	global.editor_instance.last_death_count = global.death_count
}


var destroy_value;
if destroy_value_str == ""
	destroy_value = "" // statue will never destroy
if string_is_int(destroy_value_str)
	destroy_value = int64(destroy_value_str)
else
	destroy_value = execute_branefuck($",g:{destroy_value_str},", 0)
value = execute_branefuck(program, destroy_value)
if (value == destroy_value) {
	with (add_inst)
		event_perform(ev_other, ev_user1)
	instance_destroy(id)	
}
