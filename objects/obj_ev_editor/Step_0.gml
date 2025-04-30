if keyboard_check_pressed(vk_f4)
	window_set_fullscreen(!window_get_fullscreen())


var list = ds_list_create()
var length = instance_position_list(mouse_x, mouse_y, all, list, false)
var min_depth = infinity
var min_inst = noone
for (var i = 0; i < length; i++) {
	var inst = list[| i]
	if (inst.depth < min_depth && inst.visible) {
		min_inst = inst
		min_depth = inst.depth	
	}
}
ds_list_destroy(list)
global.instance_touching_mouse = min_inst;

if room == global.level_room {
	if !global.pause { 
		if (ev_is_leave_key_pressed()) {
			ev_leave_level()
		}
		global.level_time++;
	}
}
if (ev_is_room_gameplay(room)) {
	global.level_time++;
}

if (room == asset_get_index("rm_ev_startup")) {
	if (startup_timeout != -1) {
		startup_timeout--;
		if (startup_timeout == -1 || startup_actions_count == 0)
			on_startup_finish()
	}
}

global.editor_time++
global.selected_thing_time++;

if global.erasing != -1 {
	global.erasing--;	
	if global.erasing == -1 {
		// previously i actually added an additional add_undo() here so you could 
		// undo erasing the level, but now i'd have to implement metadata undoing, and i don't want to
		history = []
		var retain_save_name = global.level.save_name
		ev_stop_music()
		reset_global_level()
		ev_claim_level(global.level)
		global.level.save_name = retain_save_name
		audio_play_sound(global.goes_sound, 10, false)	
		room_goto(asset_get_index("rm_ev_after_erase"))
	}
}

if play_transition != -1 {
	with (play_transition_display) {
		var t = (other.max_play_transition - other.play_transition) 
			/ other.max_play_transition
		var move = animcurve_channel_evaluate(other.move_curve, t)	
		var grow = animcurve_channel_evaluate(other.grow_curve, t)	
		image_xscale = lerp(scale_x_start, 1, grow)
		image_yscale = lerp(scale_y_start, 1, grow)
		x = lerp(xstart, (room_width / 2) - (sprite_width / 2), move)
		y = lerp(ystart, (room_height / 2) - (sprite_height / 2), move)
	}
	
	play_transition--;

	if play_transition == -1 {
		if (room == global.editor_room)
			global.playtesting = true;

		starting_deaths = 0
		starting_deaths += ds_list_find_value(asset_get_index("obj_inventory").ds_rcrds, 5)
		starting_deaths += ds_list_find_value(asset_get_index("obj_inventory").ds_rcrds, 6)
		last_death_count = 0
		global.death_count = 0
		global.death_x = -1
		global.death_y = -1
		global.annoyance_count = 0
		
		audio_play_sound(asset_get_index("snd_ev_start_level"), 10, false)
		room_goto(global.level_room)
		if (!ev_is_music_playing(asset_get_index(global.level.music)))
			ev_play_music(asset_get_index(global.level.music))	
	}
}

else if preview_transition != -1 {
	preview_transition--;
	var t = (other.max_preview_transition - other.preview_transition) 
	/ other.max_preview_transition
	
	var display = preview_transition_display;
	
	with (display) {
		var curve = animcurve_channel_evaluate(other.preview_curve, t)
		image_xscale = lerp(scale_x_start, 0.78, curve)
		image_yscale = lerp(scale_y_start, 0.78, curve)
		x = lerp(xstart, 1.5, curve)
		y = lerp(ystart, 1.5, curve)
	}
	with (preview_transition_highlight) {
		alpha = t;
		for (var i = 0; i < array_length(children); i++) {
			children[i].image_alpha = t	
		}
	}
	
	if preview_transition == -1 {
		with (display) {
			xstart = x
			ystart = y
			scale_x_start = image_xscale
			scale_y_start = image_yscale
			with (asset_get_index("obj_ev_level_select"))
				destroy_displays(display)
		}
		global.mouse_layer = 1
	}

}
else if (edit_transition != -1) {
	edit_transition--;

	
	with (edit_transition_display) {
		var t = (other.max_edit_transition - other.edit_transition) 
			/ other.max_edit_transition
		
		var curve = animcurve_channel_evaluate(other.edit_curve, t)
		image_xscale = lerp(scale_x_start, 0.7615918, curve)
		image_yscale = lerp(scale_y_start, 0.7615918, curve)
		x = lerp(xstart, room_width - sprite_width - 1.5, curve)
		y = lerp(ystart, room_height - sprite_height - 1.5, curve)
	}
	
	if (edit_transition == -1) {
		global.mouse_layer = 0;
		room_goto(asset_get_index("rm_ev_editor"));
	}
}
else if (edit_pack_transition != -1) {
	edit_pack_transition--;
}
else if play_pack_transition_time != -1 {
	play_pack_transition_time--;
	if play_pack_transition_time == 0 {
		global.pack_save = noone;
		room_goto(global.pack_level_room)
	}
}

if room == global.editor_room { 
	if ev_is_tile_mode_hotkey_pressed() && global.mouse_layer == 0 {
		switch_tile_mode(!global.tile_mode)
		audio_play_sound(global.select_sound, 10, false, 1, 0, 1.2)
	}

	if keyboard_check(vk_control) && global.mouse_layer == 0 {
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
				undo_repeat = undo_repeat_frames_start-undo_repeat_frames_speed
			}
		}
		else {
			undo_repeat = -1	
			undo_repeat_frames_speed = 0
		}
	}
}
else if ev_is_room_gameplay(room) {
	global.floor_count = instance_number_string(tile_default.obj_name)
	global.glass_count = instance_number_string(tile_glass.obj_name)
	
	global.leech_count = instance_number_string(object_leech.obj_name)
	global.maggot_count = instance_number_string(object_maggot.obj_name)
	global.beaver_count = instance_number_string(object_bull.obj_name)
	global.smile_count = instance_number_string(object_gobbler.obj_name)
	global.eye_count = instance_number_string(object_hand.obj_name)
	global.mimic_count = instance_number_string(object_mimic.obj_name)
	global.octahedron_count = instance_number_string(object_diamond.obj_name)
	global.spider_count = instance_number_string(object_spider.obj_name)
	global.orb_count = instance_number_string(object_orb.obj_name)
	global.scaredeer_count = instance_number_string(object_scaredeer.obj_name)
	
	with (agi("obj_player")) {
		global.player_x = x div 16;
		global.player_y = y div 16;
	}
	
	global.add_count = 0;
	global.mon_count = 0;
	global.tan_count = 0;
	global.lev_count = 0;
	global.eus_count = 0;
	global.bee_count = 0;
	global.gor_count = 0;
	global.cif_count = 0;
	global.jukebox_count = 0;
	global.egg_count = 0;
	
	with (asset_get_index(egg_statue_obj)) {
		switch (b_form) {
			case 8:
				global.add_count++;
				break;
			case 7:
				global.mon_count++;
				break;
			case 3:
				global.tan_count++;
				break;
			case 1:
				global.lev_count++;
				break;
			case 4:
				global.cif_count++;
				break;
			case 6:
				global.eus_count++;
				break;
			case 2:
				global.bee_count++;
				break;
			case 5:
				global.gor_count++;
				break;
			case 9:
				global.jukebox_count++;
				break;
			case 0:
				global.egg_count++;
				break;
			default:
				break;
		}
	}
}
function instance_number_string(object_string) {
	return instance_number(agi(object_string))
}

if mouse_check_button_pressed(mb_left) {
	global.mouse_pressed = true;
	global.mouse_held = true;
}
else
	global.mouse_pressed = false;
if mouse_check_button_released(mb_left) {
	global.mouse_held = false;	
	global.mouse_released = true;
}
else
	global.mouse_released = false;

if mouse_check_button_pressed(mb_right) {
	global.mouse_right_pressed = true;
	global.mouse_right_held = true;
}
else
	global.mouse_right_pressed = false;
if mouse_check_button_released(mb_right) {
	global.mouse_right_held = false;
	global.mouse_right_released = true;
}
else
	global.mouse_right_released = false;

if global.is_merged {
	with (asset_get_index("obj_player")) {
		if (enemyturn_countdown <= 0 && enemy_cycle == 0) {
			global.turn_frames += 1
		} 
		else {
			global.turn_frames = 0
		}
	}
}

if(global.death_count > 0){
	global.death_frames += 1
}

if (stupid_sprite_i_can_only_delete_later_lest_the_cube_shall_whiten != noone) {
	sprite_delete(stupid_sprite_i_can_only_delete_later_lest_the_cube_shall_whiten)
	stupid_sprite_i_can_only_delete_later_lest_the_cube_shall_whiten = noone
}


