// Called from gml_Object_obj_room_warp_Alarm_1
function ev_on_bee_warp(){
	if (room == agi("rm_ev_level")) {
		ev_clear_level()
	}
	else if (room == agi("rm_ev_pack_level")) {
		function find_node_state_statisfies_condition(node_state, condition, explored_states_map) {
			if ds_map_exists(explored_states_map, node_state)
				return ds_map_find_value(explored_states_map, node_state);
			if (condition(node_state)) {
				ds_map_set(explored_states_map, node_state, node_state)
				return node_state;
			}
			ds_map_set(explored_states_map, node_state, noone)
			for (var i = 0; i < array_length(node_state.exits); i++) {
				var maybe = find_node_state_statisfies_condition(node_state.exits[i], condition, explored_states_map)
				if maybe != noone
					return maybe;
			}
			return noone;
		}
		
		var state = noone;
		var bount_string = ds_grid_get(agi("obj_inventory").ds_player_info, 0, 2)
		if bount_string != "V???" {
			log_info($"Trying to find level with number {w_locusts}")
			var map = ds_map_create();
			// find a level with the required room number (in w_locusts, since this is called from gml_Object_obj_room_warp_Alarm_1)
			for (var i = 0; i < array_length(global.pack.starting_node_states); i++) {
				state = find_node_state_statisfies_condition(global.pack.starting_node_states[i], 
					function (state) {
						static level_node = global.pack_editor_instance.level_node;
						return state.node == level_node && state.properties.level.bount == w_locusts
					}, map)
			
				if state != noone
					break;
			}
			ds_map_destroy(map)
		}
		// we didn't find any OR we're in V???. check if there's an oob node
		if state == noone {
			log_info($"Trying to find oob node")
			for (var i = 0; i < array_length(global.pack.starting_node_states); i++) {
				if global.pack.starting_node_states[i].node == global.pack_editor_instance.oob_node {
					state = global.pack.starting_node_states[i]
					break;	
				}
			}
		}
		// no oob nodes too. damn! choose the root node
		if state == noone {
			log_info($"No oob node. Selecting root node")
			state = global.pack.starting_node_states[0];
		}
			
		
		agi("obj_ev_pack_player").move_to_node_state(state)
	}
	instance_destroy()
}