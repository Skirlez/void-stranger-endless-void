
if keyboard_check_pressed(vk_f11)
	window_set_fullscreen(!window_get_fullscreen())



global.editor_time++

if global.erasing != -1 {
	global.erasing--;	
	if global.erasing == -1 {
		// previously i actually added an additional add_undo() here so you could 
		// undo erasing the level, but now i'd have to implement metadata undoing, and i don't want to
		history = [] 
		ev_stop_music()
		reset_everything()
		audio_play_sound(global.goes_sound, 10, false)	
		room_goto(asset_get_index("rm_ev_after_erase"))
	}
}

if play_transition != -1 {
	play_transition--;
	
	with (play_transition_display) {
		var t = (other.max_play_transition - other.play_transition) 
			/ other.max_play_transition
		var move = animcurve_channel_evaluate(other.move_curve, t)	
		var grow = animcurve_channel_evaluate(other.grow_curve, t)	
		image_xscale = lerp(scale_x_start, 1, grow)
		image_yscale = lerp(scale_y_start, 1, grow)
		x = lerp(xstart, (room_width / 2) - (sprite_width / 2), move)
		y = lerp(ystart, (room_height / 2) - (sprite_height / 2), move)
	
	}

	if play_transition == -1 {
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

if mouse_check_button_pressed(mb_right) {
	global.mouse_right_pressed = true;
	global.mouse_right_held = true;
}
else
	global.mouse_right_pressed = false;
if mouse_check_button_released(mb_right) {
	global.mouse_right_held = false;	
}
