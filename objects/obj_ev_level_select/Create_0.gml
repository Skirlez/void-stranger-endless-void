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

files = get_all_files(global.levels_directory, level_extension)
display_object = asset_get_index("obj_ev_display")

instance_create_layer(200, 16, "Instances", asset_get_index("obj_ev_main_menu_button"), {
	base_scale_x : 1,
	base_scale_y : 0.7,
	txt : "Back",
	room_name : "rm_ev_menu",
});

instance_create_layer(24, 16, "Instances", asset_get_index("obj_ev_main_menu_button"), {
	base_scale_x : 0.9,
	base_scale_y : 0.8,
	txt : "NEW",
	room_name : "rm_ev_editor",
});

function destroy_displays(except = noone) {
	for (var i = 0; i < array_length(children); i++) {
		var inst = children[i]
		if (inst.object_index == display_object && inst != except) { 
			array_delete(children, i, 1)
			i--;
			instance_destroy(inst)	
		}
	}
}

function create_displays() {
	destroy_displays()
	var line = 0;
	var pos = 0

	var count = 0;
	if array_length(files) == 0
		return;

	if (level_start < 0)
		level_start = 0
	if (level_start * 6 >= array_length(files))
		level_start--;
	for (var i = level_start * 6; i < array_length(files) && count < 6; i++) {
		var file = file_text_open_read(files[i])
	
		var lvl_string = file_text_read_string(file)
		var lvl_struct = import_level(lvl_string)
	
		var display = instance_create_layer(20 + pos * 50, 40 + line * 50, "Levels", display_object, {
			lvl : lvl_struct,
			image_xscale : 0.2,
			image_yscale : 0.2
		});
		add_child(display);

	
		pos++;
		if pos > 2 {
			pos = 0
			line++;
		}
	
		file_text_close(file)
		count++;
	}	
}

create_displays()

var search_box = instance_create_layer(112, 15, "Instances", asset_get_index("obj_ev_textbox"), 
{empty_text : "Search...",
allow_newlines : false,
automatic_newline : false,
char_limit : 50,
base_scale_x : 5})

search_box.depth--;

add_child(search_box)