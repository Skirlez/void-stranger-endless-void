if (compiled_for_merge) {
	event_inherited()
	global.mouse_layer = -1
	global.play_transition = global.max_play_transition
}
else
	audio_play_sound(snd_reveal, 10, false)