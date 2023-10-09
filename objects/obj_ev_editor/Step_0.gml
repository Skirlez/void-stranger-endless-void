
if keyboard_check_pressed(vk_f11)
	window_set_fullscreen(!window_get_fullscreen())



global.editor_time++

if global.erasing != -1 {
	global.erasing--;	
	if global.erasing == -1 {
		reset_everything()
		audio_play_sound(global.goes_sound, 10, false)	
		room_goto(asset_get_index("rm_ev_after_erase"))
	}
}

if global.play_transition != -1 {
	global.play_transition--;
	if global.play_transition == -1 {
		room_goto(asset_get_index("rm_ev_level"))	
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