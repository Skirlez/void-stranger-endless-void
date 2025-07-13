
function ev_leave_pack() {
	if (global.playtesting)
		room_goto(asset_get_index("rm_ev_pack_editor"))
	else
		room_goto(asset_get_index("rm_ev_pack_select"))
	global.playtesting = false;
	ds_map_clear(global.locusts_collected_this_level)
	ds_map_clear(global.pack_memories)
	global.editor.reset_branefuck_persistent_memory()
}

function ev_clear_pack_level(exit_number = 0) {
	var asset = agi("obj_ev_pack_player")
	if asset == -1
		exit;
	var index = exit_number;
	with (asset) {
		if index >= array_length(current_node_state.exits)
			index = array_length(current_node_state.exits) - 1;
		if (index == -1) {
			ev_leave_pack()
			ev_notify("Cleared level with no exits!")
			return;
		}
		var new_state = current_node_state.exits[index]
		ds_map_clear(global.locusts_collected_this_level)
		var gotten_crystal = (global.token_check != 0)
		if gotten_crystal
			ds_map_set(global.pack_memories, current_node_state.properties.level.name, 1)
		move_to_node_state(new_state);
	}
}