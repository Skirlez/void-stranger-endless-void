if ev_mouse_pressed() && ev_is_mouse_on_me() {
	audio_play_sound(snd, 10, false)
	image_index = !image_index	
	with (asset_get_index("obj_ev_level_settings_window"))
		commit()
		
	if (burden_ind != burden_stackrod && global.level.music == "msc_test2")
		ev_play_music(asset_get_index("msc_test2"))
}