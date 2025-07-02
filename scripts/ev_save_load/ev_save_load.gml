
function ev_save(){
	ini_open(global.save_directory + "ev_options.ini")
	ini_write_string("options", "username", global.author.username)
	ini_write_string("options", "brand", global.author.brand)
	ini_write_string("options", "server_ip", global.server_ip)
	ini_write_string("options", "server_port", global.server_port)
	ini_write_string("options", "stranger", global.stranger)
	
	ini_write_string("options", "memory", global.memory_style)
	ini_write_string("options", "wings", global.wings_style)
	ini_write_string("options", "blade", global.blade_style)
	
	ini_write_string("options", "should_log", global.should_log_udp)
	ini_write_string("options", "logging_ip", global.logging_ip)
	ini_write_string("options", "logging_port", global.logging_port)
	
	ini_write_string("options", "disable_3d_cube_bs", global.disable_3d_cube_bs)
	
	ini_write_string("stats", "grube", global.highest_grube_stack)
	
	ini_close()
}
function ev_load() {
	ini_open(global.save_directory + "ev_options.ini")
	global.author.username = ini_read_string("options", "username", "Anonymous")
	global.author.brand = int64(ini_read_string("options", "brand", 0))
	global.server_ip = ini_read_string("options", "server_ip", "skirlez.com")
	global.server_port = ini_read_string("options", "server_port", 3000)
	global.stranger = ini_read_real("options", "stranger", 0)
	global.memory_style = ini_read_real("options", "memory", 0)
	global.wings_style = ini_read_real("options", "wings", 0)
	global.blade_style = ini_read_real("options", "blade", 0)
	global.highest_grube_stack = ini_read_real("stats", "grube", 1)
	global.seen_intro = true;
	global.should_log_udp = ini_read_real("options", "should_log", false)
	global.logging_ip = ini_read_string("options", "logging_ip", "localhost")
	global.logging_port = ini_read_real("options", "logging_port", 1235)
	global.disable_3d_cube_bs = ini_read_real("options", "disable_3d_cube_bs", false)
	ini_close()
	ev_update_vars()
}

function ev_update_vars() {
	global.server = $"http://{global.server_ip}:{global.server_port}/voyager"
	var folder;
	if global.server_port == 3000
		folder = string_lettersdigits(global.server_ip);
	else {
		folder = $"{string_lettersdigits(global.server_ip)}_{global.server_port}";
	}
	global.levels_directory = game_save_id + folder + "/levels/"
	global.packs_directory = game_save_id + folder + "/packs/"
	if (global.is_merged)
		asset_get_index("scr_menueyecatch")(0)
	
	if global.logging_socket != noone {
		network_destroy(global.logging_socket)
		global.logging_socket = noone;	
	}
	if global.should_log_udp {
		global.logging_socket = network_create_socket(network_socket_udp)
		log_info($"EV Starting to log on port {global.logging_port}")
	}

}

function save_level(lvl)
{
	var str = export_level(lvl)
	var file = file_text_open_write(global.levels_directory + lvl.save_name + "." + level_extension)
	if (file == -1)
		return false;
	file_text_write_string(file, str)
	file_text_close(file)
	return true;
}
function delete_level(save_name) {
	file_delete(global.levels_directory + save_name + "." + level_extension)	
}


function save_pack(pack)
{
	var str = export_pack(pack)
	var file = file_text_open_write(global.packs_directory + pack.save_name + "." + pack_extension)
	if (file == -1)
		return false;
	file_text_write_string(file, str)
	file_text_close(file)
	return true;
}
function delete_pack(save_name) {
	file_delete(global.packs_directory + save_name + "." + pack_extension)	
}


function load_pack_progress() {
	var file = file_text_open_read(global.packs_directory + global.pack.save_name + "." + pack_save_extension)
	if (file == -1)
		return noone;
	var save_string = file_text_read_string(file)
	file_text_close(file)
	try {
		return json_parse(save_string);	
	}
	catch (e) {
		ev_notify("Failed to parse save!")
		var file = file_text_open_write($"{global.packs_directory}backup_error{irandom_range(10000, 99999)}.{pack_save_extension}")
		if (file == -1)
			return noone;
		file_text_write_string(file, save_string)
		file_text_close(file)
		
		return noone;
	}
}

function save_pack_progress(current_level_name) {
	static inv = agi("obj_inventory")
	var save = {
		level_name : base64_encode(current_level_name),
		locust_count : ds_grid_get(inv.ds_player_info, 1, 1),
		music : audio_get_name(global.music_file),
		persistent_memory : global.branefuck_persistent_memory,
		burdens : [ds_grid_get(inv.ds_equipment, 0, 0) != 0,
					ds_grid_get(inv.ds_equipment, 0, 1) != 0,
					ds_grid_get(inv.ds_equipment, 0, 2) != 0,
					ds_grid_get(inv.ds_player_info, 10, 2) != 4,
					ds_grid_get(inv.ds_equipment, 0, 4) != 0]
	}
	static inv = agi("obj_inventory")

	
	var save_string = json_stringify(save, false)
	var file = file_text_open_write(global.packs_directory + global.pack.save_name + "." + pack_save_extension)
	if (file == -1)
		return false;
	file_text_write_string(file, save_string)
	file_text_close(file)
	return true;
}
