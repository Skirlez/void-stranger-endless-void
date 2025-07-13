global.elysium_tracks = [agi("msc_test2"), agi("msc_ending2"),
		agi("msc_looptest"), agi("msc_sendoff")]
		
function ev_get_elysium_music(level) {
	var track = 0;
	for (var i = 0; i < 3; i++) {
		if (level.burdens[i])
			track++;	
	}
	return global.elysium_tracks[track]
}

function ev_is_music_elysium(track) {
	return ev_array_contains(global.elysium_tracks, track)
}
function ev_is_elysium_music_playing() {
	for (var i = 0; i < 4; i++) {
		if audio_is_playing(global.elysium_tracks[i])
			return true
	}
	return false
}