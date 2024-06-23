if (!instance_exists(add_inst)|| array_length(program) == 0)
	return;

global.add_current_x = floor(add_inst.x/16)
global.add_current_y = floor(add_inst.y/16)


current_deaths = 0
current_deaths += ds_list_find_value(asset_get_index("obj_inventory").ds_rcrds, 5)
current_deaths += ds_list_find_value(asset_get_index("obj_inventory").ds_rcrds, 6)
global.death_count = current_deaths - asset_get_index("obj_ev_editor").starting_deaths

if (global.death_count != asset_get_index("obj_ev_editor").last_death_count){
	//Player has just died
	current_death_x = floor(asset_get_index("obj_player").x/16)
	current_death_y = floor(asset_get_index("obj_player").y/16)
	
	if (global.death_x == current_death_x && global.death_y == current_death_y){
		global.annoyance_count += 1
	} else{
		global.annoyance_count = 1
	}
	
	global.death_x = current_death_x
	global.death_y = current_death_y
	global.death_frames = 0
}

asset_get_index("obj_ev_editor").last_death_count = global.death_count

var input_1 = evaluate_input(input_1_str)
var input_2 = evaluate_input(input_2_str)
var destroy_value = evaluate_input(destroy_value_str)

value = execute(program, input_1, input_2, destroy_value)
if (value == destroy_value) {
	with (add_inst)
		event_perform(ev_other, ev_user1)
	instance_destroy(id)	
}
