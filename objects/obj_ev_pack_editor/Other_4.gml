if (room == global.pack_editor_room) {
	if !global.void_radio_on 
		ev_stop_music();
	else
		ev_play_void_radio()
	ev_stop_music()
	zoom = 0;
	calculate_zoom()
	place_pack_into_room(global.pack)
	selected_thing = pack_things.nothing
}