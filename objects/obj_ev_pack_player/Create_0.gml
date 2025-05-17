ev_set_play_variables()

current_node_state = noone;
brand_node_states = noone;



in_brand_room = false;
function move_to_node_state(state) {
	var potential_next_state = state;
	do {
		current_node_state = potential_next_state;
		potential_next_state = current_node_state.node.play_evaluate_immediate(current_node_state);
	} until (potential_next_state == noone)
	
	room_restart();
}
function end_pack() {
	ev_leave_pack()	
}

function on_room_create() {
	log_info("Pack player running on_room_create")
	if brand_node_states == noone {
		log_info($"Initializing brand nodes")
		brand_node_states = [];
		for (var i = 0; i < array_length(global.pack.starting_node_states); i++) {
			var state = global.pack.starting_node_states[i];
			if (state.node == global.pack_editor_instance.brand_node) {
				array_push(brand_node_states, state)
			}
		}
		log_info($"We have {array_length(brand_node_states)} brand nodes")
	}
	if current_node_state == noone {
		log_info("Choosing starting node")
		var first_state = noone;
		if global.pack_save == noone {
			log_info("No save, choosing root")
			first_state = global.pack.starting_node_states[0];
		}
		else if global.playtesting {
			var node_id = global.pack_save.node_id;
			var node_states = ds_map_keys_to_array(global.pack_editor_instance.node_state_to_id_map);
			for (var i = 0; i < array_length(node_states); i++) {
				if (ds_map_find_value(global.pack_editor_instance.node_state_to_id_map, node_states[i]) == node_id) {
					first_state = node_states[i]
					break;
				}
			}
		} 
		else {
			function find_level_node_state_with_name(node_state, name, explored_states_map) {
				static level_node = global.pack_editor_instance.level_node
				if (ds_map_exists(explored_states_map, node_state))
					return noone;
				if node_state.node == level_node {
					if node_state.properties.level.name == name
						return node_state;
				}
				ds_map_set(explored_states_map, node_state, 0)
		
				for (var i = 0; i < array_length(node_state.exits); i++) {
					var state = find_level_node_state_with_name(node_state.exits[i], name, explored_states_map)
					if state != noone
						return state;
				}
				return noone;
			}
			var map = ds_map_create();
			for (var i = 0; i < array_length(global.pack.starting_node_states); i++) {
				var node_state = find_level_node_state_with_name(global.pack.starting_node_states[i], global.pack_save.level_name, map)
				if (node_state != noone) {
					first_state = node_state
					log_info($"Found level from save with name {global.pack_save.level_name}")
					break;	
				}
			}
			ds_map_destroy(map)
			
			if first_state == noone {
				log_error($"Save existed, but could not find node with name {global.pack_save.level_name}."
					+ "Sadly choosing root node.")
				first_state = global.pack.starting_node_states[0];
			}
		}
		move_to_node_state(first_state)
	}
	else {
		current_node_state.node.play_evaluate(current_node_state);
		
	}
	
	alarm[0] = 1
}

// checked and changed at level_node.play_evaluate
is_first_level = !global.playtesting;
is_brand_room = false;

// called at level_node.play_evaluate
function evaluate_brand_room() {
	in_brand_room = is_level_brand_room(global.level)
	if in_brand_room {
		brand_secret_exit = instance_create_layer(-100, -100, "Instances",
			agi("obj_na_secret_exit"))
		brand_secret_exit.secret_stars = true;
	}
}
// instance we move around depending on if this is a brand room
brand_secret_exit = noone;

dust_emit_counter = 0;
dust_emit_limit = 0;