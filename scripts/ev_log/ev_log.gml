
function log_error(text){
	if !is_string(text)
		text = string(text)
	show_debug_message(text)
	if global.should_log_udp
		log_udp(text)
}

function log_info(text){
	if !is_string(text)
		text = string(text)
	show_debug_message(text)
	if global.should_log_udp
		log_udp(text)
}


function log_udp(text) {
	var buffer = buffer_create(string_length(text) + 1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, text);
	network_send_udp_raw(global.logging_socket, "127.0.0.1", global.logging_port, buffer, buffer_tell(buffer))
	buffer_delete(buffer)
}