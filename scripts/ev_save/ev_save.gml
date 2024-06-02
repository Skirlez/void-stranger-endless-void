
function ev_save(){
	ini_open(global.save_directory + "ev_options.ini")
	ini_write_string("options", "username", global.author.username)
	ini_write_string("options", "brand", global.author.brand)
	ini_write_string("options", "server_ip", global.server_ip)
	ini_write_string("options", "stranger", global.stranger)
	ini_close()
}
function ev_load() {
	ini_open(global.save_directory + "ev_options.ini")
	global.author.username = ini_read_string("options", "username", "Anonymous")
	global.author.brand = int64(ini_read_string("options", "brand", 0))
	global.server_ip = ini_read_string("options", "server_ip", "skirlez.com")
	global.stranger = ini_read_real("options", "stranger", 0)
	ini_close()
	ev_update_vars()
}

function ev_update_vars() {
	global.server = "http://" + global.server_ip + ":3000/voyager"
	var folder = string_lettersdigits(global.server_ip);
	global.levels_directory = game_save_id + folder + "\\levels\\"
	
	if (compiled_for_merge)
		asset_get_index("scr_menueyecatch")(0)

}

