time--;
if time == 0 {
	audio_play_sound(asset_get_index("snd_voidrod_place"), 10, false)
	audio_stop_sound(global.goes_sound)
	room_goto(asset_get_index("rm_ev_editor"))
	
}