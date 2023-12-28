if ev_mouse_pressed() && ev_is_mouse_on_me() {
	audio_play_sound(snd, 10, false)
	image_index = !image_index	
	with (asset_get_index("obj_ev_settings_window"))
		commit()
}