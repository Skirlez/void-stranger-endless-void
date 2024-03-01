
function ev_leave_level() {
	if (global.playtesting)
		room_goto(asset_get_index("rm_ev_editor"))
	else
		room_goto(asset_get_index("rm_ev_level_select"))
	global.playtesting = false;
}