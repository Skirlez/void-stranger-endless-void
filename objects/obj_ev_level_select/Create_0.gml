event_inherited()




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
		ev_claim_level(global.level)
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

	if (global.level_start <= -1)
		global.level_start = (array_length(levels) - 1) div 6;
	else if (global.level_start * 6 >= array_length(levels))
		global.level_start = 0;	

	var search_text = string_lower(search_box.txt);
	
	var start = (search_box.txt == "" ? global.level_start * 6 : 0)
	for (var i = start; i < array_length(levels) && count < 6; i++) {


		var lvl_string = levels[i];
		var lvl_name = get_level_name_from_string(lvl_string);
		if (search_text != "" && string_pos(search_text, string_lower(lvl_name)) == 0)
			continue;
		
		var lvl_struct = import_level(lvl_string)
		if (!global.online_mode)
			lvl_struct.save_name = files[i]

		var display = instance_create_layer(20 + pos * 50, 40 + line * 50, "Levels", display_object, {
			lvl : lvl_struct,
			lvl_sha : level_string_content_sha1(lvl_string),
			no_spoiling : true,
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



search_box = instance_create_layer(112 - 30, 12, "Instances", asset_get_index("obj_ev_textbox"), 
{
	empty_text : "Search...",
	allow_newlines : false,
	automatic_newline : false,
	char_limit : 50,
	layer_num : 0,
	base_scale_x : 5,
	change_func : function () {
		asset_get_index("obj_ev_level_select").create_displays();
	}
})

search_box.depth--;

var online_switch = instance_create_layer(112 + 29, 12, "Instances", asset_get_index("obj_ev_online_switch"), {
	level_select_instance : id,	
});
var refresh_button = instance_create_layer(112 + 56, 12, "Instances", asset_get_index("obj_ev_refresh"), {
	level_select_instance : id,	
});

online_levels = copy_array(global.online_levels)
function switch_mode(new_mode) {
	global.level_start = 0
	if (new_mode == 0)
		levels = offline_levels 
	else
		levels = online_levels 
	create_displays();
}


add_child(online_switch)
add_child(refresh_button)
add_child(search_box)



display_object = asset_get_index("obj_ev_display")
files = []
function read_offline_levels() {
	files = get_all_files(global.levels_directory, level_extension)
	var offline_levels = array_create(array_length(files));
	for (var i = 0; i < array_length(files); i++) {
		var file = file_text_open_read(global.levels_directory + files[i] + "." + level_extension)
		var lvl_string = file_text_read_string(file)
		offline_levels[i] = lvl_string
		file_text_close(file)
	
	}
	return offline_levels
}
function sort_online_levels() {	
	array_sort(online_levels, function (lvl_str_1, lvl_str_2) {
		var date_1 = int64_safe(get_level_date_from_string(lvl_str_1), 0)
		var date_2 = int64_safe(get_level_date_from_string(lvl_str_2), 0)
		if (date_1 < date_2)
			return 1
		else if (date_1 > date_2)
			return -1;
		return 0;
	})	
}


offline_levels = read_offline_levels();
online_levels = copy_array(global.online_levels)
sort_online_levels()

function on_level_update() {
	if (global.online_mode) {
		online_levels = copy_array(global.online_levels)
		sort_online_levels()
		levels = online_levels
	}
	else {
		offline_levels = read_offline_levels()
		levels = offline_levels
	}
	if (!instance_exists(asset_get_index("obj_ev_level_highlight")))
		create_displays();

}

levels = global.online_mode ? online_levels : offline_levels;

create_displays()