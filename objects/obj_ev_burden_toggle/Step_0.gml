if ev_is_mouse_on_me() && ev_mouse_pressed() {
	audio_play_sound(snd, 10, false)
	image_index = !image_index	
}