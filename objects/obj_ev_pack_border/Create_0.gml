function toggle() {
	visible = !visible
	
	objects = ["obj_ev_pack_hammer", "obj_ev_pack_add_level_button", "obj_ev_pack_node_button"]
	
	for (var i = 0; i < array_length(objects); i++) {
		with (asset_get_index(objects[i])) {
			visible = other.visible
		}
	}
	

	
}