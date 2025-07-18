function ev_on_pack_cif_reset(){
	static pack_player = agi("obj_ev_pack_player");
	ev_prepare_level_burdens()
	ev_set_play_variables()
	global.editor.reset_branefuck_persistent_memory()
	ds_map_clear(pack_player.pack_memories)
	pack_player.move_to_root_state();
}