
function ev_leave_level() {
	if (global.playtesting)
		room_goto(asset_get_index("rm_ev_editor"))
	else
		room_goto(asset_get_index("rm_ev_level_select"))
	global.playtesting = false;
}

function ev_clear_level() {
	if (global.level != noone && !global.debug && !global.playtesting) {
		ds_map_add(global.beaten_levels_map, level_content_sha1(global.level), true)
		global.editor_instance.save_beaten_levels();
	}
	ev_leave_level();
}