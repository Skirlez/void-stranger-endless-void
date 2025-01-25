
function ev_clear_pack_level() {
	var asset = asset_get_index("obj_ev_pack_player")
	if asset == -1
		exit
	with (asset) {
		var new_state = current_node_state.exits[0]
		move_to_node_state(new_state);	
	}
}