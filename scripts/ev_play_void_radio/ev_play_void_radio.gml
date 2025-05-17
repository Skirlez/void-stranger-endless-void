global.void_radio_disable_stack = 0;
function ev_play_void_radio() {
	if global.void_radio_disable_stack != 0
		return;
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
	var track;
	var track_length;
	var start;
	var endpoint;
	do {
		var previous_index = index;
		while (index == previous_index)
			index = irandom_range(1, array_length(global.music_names) - 1)
		track = asset_get_index(global.music_names[index]);
		if (ev_is_music_elysium(track)) {
			// swap to a variation
			track = global.elysium_tracks[irandom_range(0, 3)]
		}
		track_length = audio_sound_length(track);
		start = ev_get_real_track_start(track);
		endpoint = ev_get_real_track_end(track);
		var track_after_endpoint = track_length - endpoint
		track_length -= start + track_after_endpoint;
		endpoint = ev_get_real_track_end(track);
		previous_sum_seconds = sum_seconds;
		sum_seconds += track_length;
	} until (sum_seconds >= seconds);
	var time = track_length - (sum_seconds - seconds)
	
	if track == global.music_file && abs(audio_sound_get_track_position(global.music_inst) - time) < 0.2
		return;
	
	ev_play_music(track, false, true)
	audio_sound_set_track_position(global.music_inst, start + time);
	
	// play static and fade in
	var static_sfx = audio_play_sound(agi("snd_ev_radio_static"), 0, false, 1)
	audio_sound_gain(static_sfx, 0, 800)
	
	// fade in
	audio_sound_gain(global.music_inst, 0, 0)
	audio_sound_gain(global.music_inst, 1, 800);
	
	date_set_timezone(timezone_local)
	randomize();
}

function ev_get_real_track_start(track) {
	for (var i = 0; i < 4; i++) {
		if track == global.elysium_tracks[i]
			return 188.57;
	}
	return 0;
}

function ev_get_real_track_end(track) {
	for (var i = 0; i < 4; i++) {
		if track == global.elysium_tracks[i]
			return 471;
	}
	return audio_sound_length(track);
}