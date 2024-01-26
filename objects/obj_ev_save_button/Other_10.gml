event_inherited()
if pre_save_func != 0
	pre_save_func()
show_debug_message("Saving level " + global.level.name)
var name = global.level.name;
if (name == "") {
	ev_notify("Cannot save a level\nwithout a name.")
	exit;
}
var file = file_text_open_write(global.levels_directory + name + "." + level_extension)
show_debug_message(global.levels_directory + name + "." + level_extension)
if (file == -1)
	exit;
var str = export_level(global.level)
file_text_write_string(file, str)
file_text_close(file)
ev_notify("Level saved!")