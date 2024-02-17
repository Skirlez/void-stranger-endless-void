if (true) {
	if (room == asset_get_index("rm_ev_editor"))
		lvl = global.level;
	event_inherited()
	if (lvl != noone && display_inst != noone) {
		global.editor_instance.play_level_transition(lvl, display_inst)
	}
}
else
	audio_play_sound(snd_reveal, 10, false)