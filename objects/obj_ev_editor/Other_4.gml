global.mouse_layer = 0
global.mouse_held = false;
global.mouse_pressed = false;
if room == asset_get_index("rm_ev_menu") || room == asset_get_index("rm_ev_level_select") {
	var music = global.menu_music;
	if !audio_is_playing(music)
		ev_play_music(music)	
}
if room == asset_get_index("rm_ev_editor") {
	var quill = asset_get_index("obj_quill")
	if quill != -1
		instance_destroy(quill)
	draw_set_circle_precision(48)
	global.selected_thing = -1
	
	switch_tile_mode(false)
	if (!audio_is_playing(asset_get_index(global.level.music)))
		ev_play_music(asset_get_index(global.level.music))	
}

if (room == asset_get_index("rm_ev_level")) {
	if (!audio_is_playing(asset_get_index(global.level.music)))
		ev_play_music(asset_get_index(global.level.music))	
}


if (room == asset_get_index("rm_ev_startup")) {
	startup_timeout = 300; // frames seconds to do the following things
	startup_actions_count = 2; 
	
	try_update_online_levels()
	if array_length(uploaded_keys) != 0 {
		var build = uploaded_keys[0];
		for (var i = 1; i < array_length(uploaded_levels); i++) {
			build += "," + uploaded_keys[i]	
		}
		validate_levels = http_get(global.server + "/" + build)
	}
	else
		startup_actions_count--;
}