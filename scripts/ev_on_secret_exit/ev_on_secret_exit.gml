function ev_on_secret_exit() {
	
	if (room == agi("rm_ev_level")) {
		ev_clear_level()
	
	}
	else if (room == agi("rm_ev_pack_level")) {
		global.ev_fall_down_next_level = true;
		if variable_instance_exists(id, "exit_brand") {
			log_info($"fell into secret exit with brand {exit_brand}")
			for (var i = 0; i < array_length(global.pack.starting_node_states); i++) {
				var state = global.pack.starting_node_states[i];
				if (state.node == global.pack_editor.brand_node
						&& state.properties.brand == exit_brand) {
					agi("obj_ev_pack_player").move_to_node_state(state);
					log_info($"found matching brand node")
					break;
				}
			}
			
			
			
		}
		else
			ev_clear_pack_level(ev_exit_number)

	}
}