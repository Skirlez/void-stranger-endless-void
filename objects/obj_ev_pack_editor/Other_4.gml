if (room == global.pack_editor_room) {
	if !in_pack_editor {
		remember_camera_x = 250;
		remember_camera_y = 993;
		remember_zoom = 0;
		in_pack_editor = true;
	}

	camera_set_view_pos(view_camera[0], remember_camera_x, remember_camera_y)
	zoom = remember_zoom;
	calculate_zoom()
	
	place_pack_into_room(global.pack)
	
	if !global.void_radio_on 
		ev_stop_music();
	else
		ev_play_void_radio()
	ev_stop_music()
	
	selected_thing = pack_things.nothing
	
}