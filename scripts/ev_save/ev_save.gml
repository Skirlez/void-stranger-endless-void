
function ev_save(){
	ini_open(global.save_directory + "ev_options.ini")
	ini_write_string("options", "username", global.author.username)
	ini_write_string("options", "brand", global.author.brand)
	ini_write_string("options", "server_ip", global.server_ip)
	ini_close()
}
function ev_load() {
	ini_open(global.save_directory + "ev_options.ini")
	global.author.username = ini_read_string("options", "username", "Anonymous")
	global.author.brand = int64(ini_read_string("options", "brand", 0))
	global.server_ip = ini_read_string("options", "server_ip", "207.127.92.246:3000")
	
	ini_close()
	ev_update_vars()
}

function ev_update_vars() {
	global.server = "http://" + global.server_ip + "/voyager"
	show_debug_message(global.server)
	var folder = string_lettersdigits(global.server_ip);



	global.levels_directory = game_save_id + folder + "\\levels\\"
}