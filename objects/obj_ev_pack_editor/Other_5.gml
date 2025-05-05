if (room != global.pack_editor_room && room != global.pack_level_room && in_pack_editor) {
	log_info("leaving pack editor")
	ds_map_clear(node_state_to_id_map)
	ds_map_clear(node_id_to_instance_map)
	undo_actions = []
	in_pack_editor = false;
	last_nid = -1
}