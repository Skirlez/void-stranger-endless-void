
function ev_get_elysium_music(level) {
	var song = 0;
	for (var i = 0; i < 3; i++) {
		if (level.burdens[i])
			song++;	
	}
	switch (song) {
		case 0:
			return asset_get_index("msc_test2")
		case 1:
			return asset_get_index("msc_ending2")
		case 2:
			return asset_get_index("msc_looptest")
		case 3:
			return asset_get_index("msc_sendoff")
	}
}


