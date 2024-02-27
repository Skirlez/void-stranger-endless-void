
function ev_save(){
	ini_open(global.save_directory + "author.ini")
	ini_write_string("author", "username", global.author.username)
	ini_write_string("author", "brand", global.author.brand)
	ini_close()
}
function ev_load() {
	ini_open(global.save_directory + "author.ini")
	global.author.username = ini_read_string("author", "username", "Anonymous")
	global.author.brand = int64(ini_read_string("author", "brand", 0))
	ini_close()
}