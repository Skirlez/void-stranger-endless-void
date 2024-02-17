event_inherited()
if pre_save_func != noone
	pre_save_func()
show_debug_message("Saving level " + global.level.name)
var name = global.level.name;
if (name == "") {
	ev_notify("Cannot save a level\nwithout a name.")
	exit;
}
var save_name = global.level.save_name;
var file = file_text_open_write(global.levels_directory + save_name + "." + level_extension)
show_debug_message(global.levels_directory + save_name + "." + level_extension)
if (file == -1)
	exit;
var str = export_level(global.level)
file_text_write_string(file, str)
file_text_close(file)
ev_notify("Level saved!")

if post_save_func != noone
	post_save_func()