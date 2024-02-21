event_inherited()
if (lvl == noone)
	exit
var str = export_level(lvl);
try {
	var file = file_text_open_write(global.levels_directory + generate_level_save_name() + "." + level_extension)
	file_text_write_string(file, str);
	file_text_close(file)
	ev_notify("Copied!")
}
catch (e) {
	show_debug_message(e)
	ev_notify("Couldn't copy level!")	
}

