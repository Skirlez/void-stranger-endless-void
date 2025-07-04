if room != global.pack_editor_room
	exit;
	
	
var gain = (1 - (global.pack_editor_instance.zoom + 10) / (global.pack_editor_instance.last_possible_zoom + 10)) * 2
global.pack_zoom_gain = clamp(gain, 0.2, 1.6)

if global.void_radio_on {
	var file = agi(audio_get_name(global.music_inst))
	var endpoint = ev_get_real_track_end(file)
	if (!audio_is_playing(global.music_inst) || 
			endpoint < audio_sound_get_track_position(global.music_inst)) {
		ev_play_void_radio()
	}
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
	var mult = power(zoom_factor, zoom);
	var final_mult = power(zoom_factor, zoom_level_needed_to_be_directly_on_level);
	var target_x = play_transition_target.center_x - (224 / 2) * global.level_node_display_scale * (mult/final_mult);
	var target_y = play_transition_target.center_y - (144 / 2) * global.level_node_display_scale * (mult/final_mult);
	
	cam_x = lerp(cam_x, target_x, 0.5)
	cam_y = lerp(cam_y, target_y, 0.5)
	
	camera_set_view_pos(view_camera[0], cam_x, cam_y)
	play_transition_time--;
	if play_transition_time == 0 {
		global.mouse_layer = 0;
		global.playtesting = true;
		global.pack.starting_node_states = convert_room_nodes_to_structs() 
		global.pack_save = {
			node_id : play_transition_target.node_id
		}
		with (agi("obj_ev_pack_editor_play_button")) {
			global.pack_playtest_parameters = get_playtest_parameters();
		}
		room_goto(global.pack_level_room)
		play_transition_time = -1;
	}
}
if global.mouse_layer == 0 {
	if keyboard_check_pressed(ord("D")) && selected_thing != pack_things.nothing {
		global.pack_editor_instance.select(pack_things.nothing)
		audio_play_sound(global.select_sound, 10, false, 1, 0, random_range(0.75, 0.8))
	}
	else if keyboard_check_pressed(ord("W")) && selected_thing != pack_things.wrench {
		global.pack_editor_instance.select(pack_things.wrench)
		audio_play_sound(global.select_sound, 10, false, 1, 0, random_range(1.1, 1.2))
	}
	else if keyboard_check_pressed(ord("S")) && selected_thing != pack_things.placechanger  {
		global.pack_editor_instance.select(pack_things.placechanger)
		audio_play_sound(global.select_sound, 10, false, 1, 0, random_range(1.1, 1.2))
	}
	else if mouse_check_button_pressed(mb_middle) && selected_thing != pack_things.hammer  {
		global.pack_editor_instance.select(pack_things.hammer)
		audio_play_sound(global.select_sound, 10, false, 1, 0, random_range(1.1, 1.2))
	}
	
	if keyboard_check(vk_control) && !instance_exists(agi("obj_ev_pack_node_judgment")) {
		if keyboard_check_pressed(ord("Z")) {
			undo_repeat = undo_repeat_frames_start
			undo();
		}
	
		if keyboard_check(ord("Z")) {
			undo_repeat--;	
			if undo_repeat <= 0 {
				undo()
				undo_repeat_frames_speed += 2
		
				if (undo_repeat_frames_speed > undo_repeat_frames_max_speed)
					undo_repeat_frames_speed = undo_repeat_frames_max_speed;
				undo_repeat = undo_repeat_frames_start - undo_repeat_frames_speed
			}
		}
		else {
			undo_repeat = -1	
			undo_repeat_frames_speed = 0
		}
	}
}