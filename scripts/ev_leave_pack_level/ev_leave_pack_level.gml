
function ev_leave_pack_level() {
	if (global.playtesting)
		room_goto(asset_get_index("rm_ev_pack_editor"))
	else
		room_goto(asset_get_index("rm_ev_pack_select"))
	global.playtesting = false;
}

function ev_clear_pack_level() {
	var asset = asset_get_index("obj_ev_pack_player")
	if asset == -1
		exit
	var index = ev_exit_number;
	with (asset) {
		if index >= array_length(current_node_state.exits)
			index = array_length(current_node_state.exits) - 1;
		var new_state = current_node_state.exits[index]
		move_to_node_state(new_state);	
	}
}