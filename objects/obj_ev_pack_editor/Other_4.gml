if (room == global.pack_editor_room) {
	if !global.void_radio_on {
		ev_stop_music();
	}
	else
		ev_play_void_radio()
}