if room != global.pack_editor_room
	exit;
	
if global.void_radio_on && !audio_is_playing(global.music_inst) {
	ev_play_void_radio()
}
if ev_mouse_pressed() && global.instance_touching_mouse == noone 
		&& (global.mouse_layer == 0 || selected_thing == pack_things.wrench) {
	dragging_camera = true;
}
else if ev_mouse_released()
	dragging_camera = false;

if dragging_camera {
	var cam_x = camera_get_view_x(view_camera[0])
	var cam_y = camera_get_view_y(view_camera[0])
	
	var cam_width = camera_get_view_width(view_camera[0])
	var cam_height = camera_get_view_height(view_camera[0])
	
	
	var target_x = clamp(cam_x + previous_mouse_x - mouse_x, 0, room_width - cam_width)
	var target_y = clamp(cam_y + previous_mouse_y - mouse_y, 0, room_height - cam_height)
	
	camera_set_view_pos(view_camera[0], target_x, target_y)
}

previous_mouse_x = mouse_x;
previous_mouse_y = mouse_y;

if (global.mouse_layer == 0 || selected_thing == pack_things.wrench) {
	var prev_zoom = zoom
	if mouse_wheel_down()  {
		zoom += 1;
	}
	if mouse_wheel_up() && zoom > -10 {
		zoom -= 1;
		
	}

	if (prev_zoom != zoom) {
		calculate_zoom()
	}
}

if play_transition_time != -1 {
	var cam_x = camera_get_view_x(view_camera[0])
	var cam_y = camera_get_view_y(view_camera[0])
	zoom = lerp(zoom, zoom_level_needed_to_be_directly_on_level, 0.2)
	calculate_zoom()
	var target_x = play_transition_target.center_x - (224 / 2) * level_size;
	var target_y = play_transition_target.center_y - (144 / 2) * level_size;
	
	cam_x = lerp(cam_x, target_x, 0.2)
	cam_y = lerp(cam_y, target_y, 0.2)
	

	
	camera_set_view_pos(view_camera[0], cam_x, cam_y)
	play_transition_time--;
	if play_transition_time == 0 {
		
		global.mouse_layer = 0;
		global.pack.starting_node_states = convert_room_nodes_to_structs() 
		room_goto(global.pack_level_room)
		
		play_transition_time = -1;
	}
}

/*
if keyboard_check_pressed(ord("S")) {
	var room_nodes = convert_room_nodes_to_structs()
	global.pack.starting_node_states = room_nodes;
	var str = export_pack(global.pack)
	show_debug_message(str)
	
	var pack = import_pack(str);
	place_pack_into_room(pack);
}