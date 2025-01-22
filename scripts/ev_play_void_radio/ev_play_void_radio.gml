
function ev_play_void_radio() {
	ev_stop_music();
	date_set_timezone(timezone_utc)
	var date = date_current_datetime();
		
	var year = date_get_year(date)
	var month = date_get_month(date)
	var day = date_get_day(date)
		

	random_set_seed(year * 1000 + month * 100 + day);
		
		
	var hour = date_get_hour(date)
	var minute = date_get_minute(date)
	var second = date_get_second(date)
		
	var seconds = second + minute * 60 + hour * 60 * 60;
		
	var sum_seconds = 0;
	var previous_sum_seconds = 0;
	var index = 0;
	var song;
	do {
		var previous_index = index;
		while (index == previous_index)
			index = irandom_range(1, array_length(global.music_names) - 1)
		song = asset_get_index(global.music_names[index]);
		var song_length = audio_sound_length(song);
		var start = ev_get_real_song_start(song);
		var endpoint = ev_get_real_song_end(song);
		var song_after_endpoint = song_length - endpoint
		song_length -= start + song_after_endpoint;
		
		previous_sum_seconds = sum_seconds;
		sum_seconds += song_length;
	} until (sum_seconds >= seconds);
	
	var time = audio_sound_length(song) - (sum_seconds - seconds)
	ev_play_music(song, false)
	audio_sound_set_track_position(global.music_inst, time);
	
	// fade in
	audio_sound_gain(global.music_inst, 0, 0)
	audio_sound_gain(global.music_inst, 1, 500);
	
	date_set_timezone(timezone_local)
	randomize();
}

function ev_get_real_song_start(song) {
	static elysium_songs = [asset_get_index("msc_test2"), asset_get_index("msc_ending2"),
		asset_get_index("msc_looptest"), asset_get_index("msc_sendoff")]
		
	for (var i = 0; i < 4; i++) {
		if song == elysium_songs[i]
			return 188.57;
	}
	return 0;
}

function ev_get_real_song_end(song) {
	static elysium_songs = [asset_get_index("msc_test2"), asset_get_index("msc_ending2"),
		asset_get_index("msc_looptest"), asset_get_index("msc_sendoff")]
		
	for (var i = 0; i < 4; i++) {
		if song == elysium_songs[i]
			return 471;
	}
	return audio_sound_length(song);
}