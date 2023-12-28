event_inherited()
function get_all_files(dir, ext) {
	var files = [];
	var file_name = file_find_first(dir + "*." + ext, 0);

	while (file_name != "") {
	    array_push(files, global.levels_directory + file_name);
	    file_name = file_find_next();
	}
	file_find_close(); 
	return files;
}

var files = get_all_files(global.levels_directory, "lvl")

var display_object = asset_get_index("obj_ev_display")


var line = 0;
var pos = 0

for (var i = 0; i < array_length(files); i++) {
	var file = file_text_open_read(files[i])
	
	var lvl_string = file_text_read_string(file)
	var lvl_struct = import_level(lvl_string)
	
	instance_create_layer(20 + pos * 50, 40 + line * 40, "Levels", display_object, {
		lvl : lvl_struct,
		image_xscale : 0.2,
		image_yscale : 0.2
	});
	
	pos++;
	if pos > 2 {
		pos = 0
		line++;
	}
	
	file_text_close(file)
}

search_box = instance_create_layer(112, 15, "Instances", asset_get_index("obj_ev_textbox"), 
{empty_text : "Search...",
automatic_newline : false,
char_limit : 50,
base_scale_x : 5})
search_box.depth = -1

add_child(search_box)