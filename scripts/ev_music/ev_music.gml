
function ev_play_music(track){
	if compiled_for_merge {
		asset_get_index("scr_stop_music")(0)
		asset_get_index("scr_play_music")(track, true)
	}
	else {
		audio_stop_sound(global.music)
		global.music = audio_play_sound(track, 10, true)
	}
}
function ev_stop_music(){
	if compiled_for_merge
		asset_get_index("scr_stop_music")(0)
	else {
		audio_stop_sound(global.music)
		global.music = -4;
	}
}