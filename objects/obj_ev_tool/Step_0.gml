if (image_index < 2)
	selected = (global.selected_thing == image_index)
event_inherited()

if image_index == 2 {
	if global.tile_mode == false
		image_index = 3
}
else if image_index == 3 {
	if global.tile_mode == true
		image_index = 2
}


if image_index == 6 && global.erasing != -1 && (!ev_is_mouse_on_me() || !mouse_check_button(mb_left)) {
	global.erasing = -1
	audio_stop_sound(comes_sound)
}