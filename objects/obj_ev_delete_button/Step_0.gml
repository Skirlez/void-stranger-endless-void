event_inherited();

if (level_select == noone)
	exit

if deleting && (!ev_is_mouse_on_me() || !mouse_check_button(mb_left)) {
	deleting = false
	number = 6
	timer = -1
}

if deleting {
	timer--;
	if (timer < 0) {
		timer = max_time
		number--;
		
		if (number < 1) {
			level_select.delete_level(save_name);
			audio_play_sound(asset_get_index("snd_ev_erase"), 0, false)
			room_restart()
		}
		else
			audio_play_sound(pluck, 0, false)
	}
}