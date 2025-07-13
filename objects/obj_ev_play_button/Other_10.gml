if (global.is_merged) {
	if (room == asset_get_index("rm_ev_editor"))
		lvl = global.level;
	event_inherited()
	if (highlighter != noone)
		highlighter.hide_textbox();
	if (lvl != noone && display_instance != noone) {
		global.editor.play_level_transition(lvl, lvl_sha, display_instance)
	}
}
else
	audio_play_sound(snd_reveal, 10, false)