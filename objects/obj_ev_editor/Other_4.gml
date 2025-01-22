global.mouse_layer = 0
global.mouse_held = false;
global.mouse_pressed = false;


if room == asset_get_index("rm_ev_menu") || room == asset_get_index("rm_ev_level_select") || room == asset_get_index("rm_ev_pack_select") {
	history = []
	global.level_sha = "";
	var music = global.menu_music;
	if !audio_is_playing(music)
		ev_play_music(music)
	global.jukebox_song = 0;
}
if room == asset_get_index("rm_ev_editor") {
	draw_set_circle_precision(48)
	global.selected_thing = -1
	
	switch_tile_mode(false)
	if (!audio_is_playing(asset_get_index(global.level.music)))
		ev_play_music(asset_get_index(global.level.music))	
}
else {
	var quill = asset_get_index("obj_quill")
	if quill != -1
		instance_destroy(quill)	
}


if (room == asset_get_index("rm_ev_startup")) {
	read_beaten_levels()
	
	uploaded_levels = get_all_files(global.levels_directory, "key")
	uploaded_keys = array_create(array_length(uploaded_levels), "")

	for (var i = 0; i < array_length(uploaded_levels); i++) {
		var save_name = uploaded_levels[i] 
		var file = file_text_open_read(global.levels_directory + save_name + ".key")
		var key = file_text_read_string(file);
		uploaded_keys[i] = key;
		file_text_close(file)
	}
	
	global.online_levels = []
	startup_timeout = 300; // amount of frames before we give up
	startup_actions_count = 3; 
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
	request_version_string()
}

if (is_gameplay_room(room)) {
	global.level_time = 0;	
}

global.turn_frames = 0

if room == asset_get_index("rm_ev_pack_editor") {
	place_pack_into_room(global.pack)
}
