
function ev_play_music(track){
	if (track == -1) {
		ev_stop_music()
		return;
	}
	
	if compiled_for_merge {
		if (audio_get_name(track) == "msc_test2") {
			track = ev_get_elysium_music(global.level)
			if (global.music_file == track)
				return;
			ev_stop_music()
			asset_get_index("scr_play_music")(track, true, 1)
		}
		else {
			ev_stop_music()	
			asset_get_index("scr_play_music")(track, true)
		}
	}
	else { 
		ev_stop_music()	
		global.music = audio_play_sound(track, 10, true)
	}
	
}
function ev_stop_music() {
	if compiled_for_merge {
		global.music_file = noone
		asset_get_index("scr_stop_music")(0)
	}
	else {
		audio_stop_sound(global.music)
		global.music = -4;
	}
}
