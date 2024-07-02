event_inherited()
if pre_save_func != noone
	pre_save_func()
if (global.level.name == "") {
	ev_notify("Cannot save a level\nwithout a name.")
	exit;
}
save_level(global.level)
ev_notify("Level saved!")

if post_save_func != noone
	post_save_func()