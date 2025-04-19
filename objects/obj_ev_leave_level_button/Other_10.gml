event_inherited()
if !global.pause {
	if room == global.level_room
		ev_leave_level()
	else if room == global.pack_level_room
		ev_leave_pack();
}