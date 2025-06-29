function ev_on_pack_cif_reset(){
	static pack_player = agi("obj_ev_pack_player");
	ev_prepare_level_burdens()
	ev_set_play_variables()
	global.branefuck_persistent_memory = array_create(ADD_STATUE_MEMORY_AMOUNT)
	pack_player.move_to_root_state();
}