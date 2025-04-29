if (global.is_merged) {
	event_inherited()
	if (highlighter != noone)
		highlighter.hide_textbox();
	if (nodeless_pack != noone && display_instance != noone) {
		global.editor_instance.play_pack_transition(nodeless_pack, display_instance)
	}
}
else
	audio_play_sound(snd_reveal, 10, false)