
if keyboard_check_pressed(vk_f11)
	window_set_fullscreen(!window_get_fullscreen())



global.editor_time++

if global.erasing != -1 {
	global.erasing--;	
	if global.erasing == -1 {
		add_undo() // lol
		reset_everything()
		audio_play_sound(global.goes_sound, 10, false)	
		room_goto(asset_get_index("rm_ev_after_erase"))
	}
}

if global.play_transition != -1 {
	global.play_transition--;
	if global.play_transition == -1 {
		audio_play_sound(asset_get_index("snd_ev_start_level"), 10, false)
		room_goto(asset_get_index("rm_ev_level"))	
	}
}

if room == global.editor_room && keyboard_check(vk_control) && global.mouse_layer == 0 {
	if keyboard_check_pressed(ord("Z")) {
		undo_repeat = undo_repeat_frames_start
		undo();
	}
	
	if keyboard_check(ord("Z")) {
		undo_repeat--;	
		if undo_repeat <= 0 {
			undo()
			undo_repeat_frames_speed += 2
		
			if (undo_repeat_frames_speed > undo_repeat_frames_max_speed)
				undo_repeat_frames_speed = undo_repeat_frames_max_speed;
			undo_repeat = undo_repeat_frames_start-undo_repeat_frames_speed
		}
	}
	else {
		undo_repeat = -1	
		undo_repeat_frames_speed = 0
	}
}

if mouse_check_button_pressed(mb_left) {
	global.mouse_pressed = true;
	global.mouse_held = true;
}
else
	global.mouse_pressed = false;
if mouse_check_button_released(mb_left) {
	global.mouse_held = false;	
}