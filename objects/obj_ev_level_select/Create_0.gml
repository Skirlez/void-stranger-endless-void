event_inherited()


function get_all_files(dir, ext) {
	var files = [];
	var file_name = string_replace(file_find_first(dir + "*." + ext, 0), ".vsl", "");
	while (file_name != "") {
	    array_push(files, file_name);
	    file_name = string_replace(file_find_next(), ".vsl", "");
	}
	file_find_close(); 
	return files;
}

function delete_level(save_name) {
	file_delete(global.levels_directory + save_name + "." + level_extension)	
}


instance_create_layer(200, 16, "Instances", asset_get_index("obj_ev_main_menu_button"), {
	base_scale_x : 1,
	base_scale_y : 0.7,
	txt : "Back",
	room_name : "rm_ev_menu",
});

new_button = instance_create_layer(24, 16, "Instances", asset_get_index("obj_ev_executing_button"), {
	base_scale_x : 0.9,
	base_scale_y : 0.8,
	txt : "NEW",
	func : function () {
		global.editor_instance.reset_everything();
		room_goto(asset_get_index("rm_ev_editor"))	
	}
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
	if array_length(levels) == 0 {
		global.level_start = 0
		return;
	}

	if (global.level_start  < 0)
		global.level_start = 0
	if (global.level_start * 6 >= array_length(levels))
		global.level_start--;
	for (var i = global.level_start * 6; i < array_length(levels) && count < 6; i++) {

		var lvl_struct = levels[i]
		if (string_lower(search_box.txt) != "" && string_pos(string_lower(search_box.txt), string_lower(lvl_struct.name)) == 0)
			continue;
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
	
	
		count++;
	}	
}



search_box = instance_create_layer(112 - 20, 12, "Instances", asset_get_index("obj_ev_textbox"), 
{
	empty_text : "Search...",
	allow_newlines : false,
	automatic_newline : false,
	char_limit : 50,
	base_scale_x : 5,
	change_func : function () {
		asset_get_index("obj_ev_level_select").create_displays();
	}
})

search_box.depth--;

var online_switch = instance_create_layer(112 + 50, 12, "Instances", asset_get_index("obj_ev_online_switch"));
online_switch.level_select_instance = id

function switch_mode(new_mode) {
	global.level_start = 0
	if (new_mode == 0) {
		levels = offline_levels 
		new_button.pressable = true
		new_button.image_alpha = 1
	}
	else {
		levels = online_levels 
		new_button.pressable = false
		new_button.image_alpha = 0.5
	}
	create_displays();
}

add_child(online_switch)
add_child(search_box)


files = get_all_files(global.levels_directory, level_extension)
display_object = asset_get_index("obj_ev_display")

offline_levels = array_create(array_length(files));
for (var i = 0; i < array_length(files); i++) {
	var file = file_text_open_read(global.levels_directory + files[i] + "." + level_extension)
	var lvl_string = file_text_read_string(file)

	
	var lvl_struct = import_level(lvl_string)
	lvl_struct.save_name = files[i]
	offline_levels[i] = lvl_struct
	file_text_close(file)
	
}


online_levels = copy_array(global.online_levels)


levels = offline_levels;


create_displays()