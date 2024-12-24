event_inherited();

if keyboard_check(vk_control) && keyboard_check_pressed(ord("V")) && !global.online_mode {
	var str = clipboard_get_text();
	var version = read_string_until(str, 1, "|").substr
	if !string_is_uint(version) || int64_safe(version) > global.latest_lvl_format
		exit;
	
	try {
		var file = file_text_open_write(global.levels_directory + generate_save_name() + "." + level_extension)
		file_text_write_string(file, str);
		file_text_close(file)
		ev_notify("Level pasted!")
	}
	catch (e) {
		show_debug_message(e)
		ev_notify("Couldn't paste level!")	
	}


	on_level_update();
}

