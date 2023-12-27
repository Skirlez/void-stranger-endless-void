event_inherited()
if pre_save_func != 0
	pre_save_func()
show_debug_message("Saving level " + global.level.name)
var name = global.level.name;
if (name == "")
	exit;
show_debug_message("HERE 1")
var file = file_text_open_write(global.levels_directory + name + ".lvl")
show_debug_message(global.levels_directory + name + ".lvl")
if (file == -1)
	exit;
show_debug_message("HERE 2")
var str = export_level(global.level)
file_text_write_string(file, str)
file_text_close(file)
show_debug_message("Level saved")