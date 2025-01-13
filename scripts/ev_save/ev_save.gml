
function ev_save(){
	ini_open(global.save_directory + "ev_options.ini")
	ini_write_string("options", "username", global.author.username)
	ini_write_string("options", "brand", global.author.brand)
	ini_write_string("options", "server_ip", global.server_ip)
	ini_write_string("options", "stranger", global.stranger)
	
	ini_write_string("options", "memory", global.memory_style)
	ini_write_string("options", "wings", global.wings_style)
	ini_write_string("options", "blade", global.blade_style)
	
	ini_write_string("stats", "grube", global.highest_grube_stack)
	
	ini_close()
}
function ev_load() {
	ini_open(global.save_directory + "ev_options.ini")
	global.author.username = ini_read_string("options", "username", "Anonymous")
	global.author.brand = int64(ini_read_string("options", "brand", 0))
	global.server_ip = ini_read_string("options", "server_ip", "skirlez.com")
	global.stranger = ini_read_real("options", "stranger", 0)
	global.memory_style = ini_read_real("options", "memory", 0)
	global.wings_style = ini_read_real("options", "wings", 0)
	global.blade_style = ini_read_real("options", "blade", 0)
	global.highest_grube_stack = ini_read_real("stats", "grube", 0)
	
	ini_close()
	ev_update_vars()
}

function ev_update_vars() {
	global.server = "http://" + global.server_ip + ":3000/voyager"
	var folder = string_lettersdigits(global.server_ip);
	global.levels_directory = game_save_id + folder + "/levels/"
	global.packs_directory = game_save_id + folder + "/packs/"
	if (global.compiled_for_merge)
		asset_get_index("scr_menueyecatch")(0)

}

function save_level(lvl)
{
	var file = file_text_open_write(global.levels_directory + lvl.save_name + "." + level_extension)
	if (file == -1)
		return;
	var str = export_level(lvl)
	file_text_write_string(file, str)
	file_text_close(file)
}

function save_pack(pack)
{
	var file = file_text_open_write(global.packs_directory + pack.save_name + "." + pack_extension)
	if (file == -1)
		return;
	var str = export_pack(pack)
	file_text_write_string(file, str)
	file_text_close(file)
}