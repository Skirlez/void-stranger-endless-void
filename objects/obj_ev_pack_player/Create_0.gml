ev_set_play_variables()

current_node_state = noone;
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
	if current_node_state == noone {
		var first_state;
		if global.pack_save == noone
			first_state = global.pack.starting_node_states[0];
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
					break;	
				}
			}
			ds_map_destroy(map)
		}
		move_to_node_state(first_state)
	}
	else {
		current_node_state.node.play_evaluate(current_node_state);	
	}
}

// checked and changed at level_node.play_evaluate
is_first_level = !global.playtesting;