
function ev_play_music(track, looping = true) {
	ev_stop_music()
	if (track == -1) {
		return;
	}
	if global.compiled_for_merge {
		if ((room == global.editor_room || room == global.level_room) && audio_get_name(track) == "msc_test2") {
			track = ev_get_elysium_music(global.level)
			asset_get_index("scr_play_music")(track, looping, 1)
		}
		else {
			asset_get_index("scr_play_music")(track, looping)
		}
	}
	else { 
		if ((room == global.editor_room || room == global.level_room) && audio_get_name(track) == "msc_test2") {
			track = ev_get_elysium_music(global.level);
		}
		var start = ev_get_real_song_start(track);
		global.music_inst = audio_play_sound(track, 10, looping, 1, start)
		global.music_is_looping = looping
		/* function doesn't exist in VS and fixing that would be annoying
		if looping {
			audio_sound_loop_end(global.music_inst, ev_get_real_song_end(global.music_inst))
		}
		*/
	}
	
}
function ev_stop_music() {
	if global.compiled_for_merge {
		global.music_file = noone
		asset_get_index("scr_stop_music")(0)
	}
	else {
		audio_stop_sound(global.music_inst)
		global.music_inst = noone;
	}
}
