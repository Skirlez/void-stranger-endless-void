event_inherited()

enum level_selector_modes {
	levels,
	packs,
	selecting_level_for_pack
}


function delete_level(save_name) {
	file_delete(global.levels_directory + save_name + "." + level_extension)	
}

if mode != level_selector_modes.selecting_level_for_pack {
	var back_button = instance_create_layer(200, 16, buttons_layer, asset_get_index("obj_ev_main_menu_button"), {
		base_scale_x : 1,
		base_scale_y : 0.7,
		txt : "Back",
		room_name : "rm_ev_menu",
	});
	
	var new_button;
	if (mode == level_selector_modes.levels) {
		new_button = instance_create_layer(24, 16, buttons_layer, asset_get_index("obj_ev_executing_button"), {
			base_scale_x : 0.9,
			base_scale_y : 0.8,
			txt : "NEW",
			func : function () {
				global.editor_instance.reset_global_level();
				ev_claim_level(global.level)
				room_goto(asset_get_index("rm_ev_editor"))	
			}
		});
	}
	else {
		new_button = instance_create_layer(24, 16, buttons_layer, asset_get_index("obj_ev_executing_button"), {
			base_scale_x : 0.9,
			base_scale_y : 0.8,
			txt : "NEW",
			func : function () {
				pack_editor_inst().reset_global_pack();
				ev_claim_pack(global.pack)
				
				room_goto(asset_get_index("rm_ev_pack_editor"))	
			}
		});
	}
	

	var online_switch = instance_create_layer(112 + 29, 12, buttons_layer, asset_get_index("obj_ev_online_switch"), {
		level_select_instance : id,	
	});
	var refresh_button = instance_create_layer(112 + 56, 12, buttons_layer, asset_get_index("obj_ev_refresh"), {
		level_select_instance : id,	
	});
	add_child(back_button)
	add_child(new_button)
	add_child(online_switch)
	add_child(refresh_button)
}
else {
	var back_button = instance_create_layer(200, 16, buttons_layer, asset_get_index("obj_ev_executing_button"), {
		base_scale_x : 1,
		base_scale_y : 0.7,
		txt : "Back",
		func : function () {
			instance_destroy(window);
		}
		
	});	
	add_child(back_button);
}


function level_clicked(display_inst) {
	if mode != level_selector_modes.selecting_level_for_pack {
		with (display_inst) {
			highlighted = true;	
		}
		if (other.mode == level_selector_modes.packs)
			global.editor_instance.preview_level_pack_transition(display_inst.nodeless_pack, display_inst)
		else
			global.editor_instance.preview_level_transition(display_inst.lvl, display_inst.lvl_sha, display_inst)
	}
	else {
		var lvl = display_inst.lvl;
		
		// no reason for us to store these things
		lvl.description = ""
		lvl.music = ""
		lvl.author = ""
		lvl.burdens = [false, false, false, false, false]
		lvl.upload_date = ""
		lvl.last_edit_date = ""
		lvl.save_name = ""
		
		// don't display brand (it hides level number)
		lvl.author_brand = 0;
		
		instance_destroy(id)
		
		var level_size = pack_editor_inst().level_size;
		instance_create_layer(
			mouse_x - 224 * level_size / 2, 
			mouse_y - 144 * level_size / 2, "PackLevels", display_object, 
			{
				lvl : lvl,
				name : lvl.name,
				brand : lvl.author_brand,
				draw_beaten : false,
				no_spoiling : false,
				no_redraw : true,
				display_context : display_contexts.pack_editor,
				image_xscale : level_size,
				image_yscale : level_size
			})
	}
	
}

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
		var lvl_version = get_level_version_from_string(lvl_string)
		if (lvl_version == -1 || lvl_version > global.latest_lvl_format)
			continue;
		var lvl_name = get_level_name_from_string(lvl_string);
		if (search_text != "" && string_pos(search_text, string_lower(lvl_name)) == 0)
			continue;
		
		var lvl_struct = import_level(lvl_string)
		
		if mode == level_selector_modes.packs {
			var nodeless_pack = nodeless_packs[i];
			
			var display = instance_create_layer(20 + pos * 50, 40 + line * 50, "Levels", display_object, {
				lvl : lvl_struct,
				name : nodeless_pack.name,
				brand : nodeless_pack.author_brand,
				nodeless_pack : nodeless_pack,
				layer_num : layer_num,
				display_context : display_contexts.level_select,
				no_spoiling : true,
				image_xscale : 0.2,
				image_yscale : 0.2
			});
			add_child(display);		
		}
		else {
			if (!global.online_mode)
				lvl_struct.save_name = files[i]
		
			var sha = level_string_content_sha1(lvl_string)
			var beat_value;
			if ds_map_exists(global.beaten_levels_map, sha)
				beat_value = ds_map_find_value(global.beaten_levels_map, sha)
			else
				beat_value = 0;
			
			var display = instance_create_layer(20 + pos * 50, 40 + line * 50, "Levels", display_object, {
				lvl : lvl_struct,
				lvl_sha : sha,
				name : lvl_struct.name,
				brand : lvl_struct.author_brand,
				layer_num : layer_num,
				draw_beaten : beat_value,
				display_context : display_contexts.level_select,
				no_spoiling : true,
				image_xscale : 0.2,
				image_yscale : 0.2
			});
			add_child(display);
		}

	
		pos++;
		if pos > 2 {
			pos = 0
			line++;
		}
	
	
		count++;
	}	
}



search_box = instance_create_layer(112 - 30, 12, buttons_layer, asset_get_index("obj_ev_textbox"), 
{
	empty_text : "Search...",
	allow_newlines : false,
	automatic_newline : false,
	char_limit : 50,
	layer_num : layer_num,
	base_scale_x : 5,
	change_func : function () {
		asset_get_index("obj_ev_level_select").create_displays();
	}
})

search_box.depth--;
add_child(search_box)


function switch_internet_mode(new_mode) {
	global.level_start = 0
	if (new_mode == 0)
		levels = offline_levels 
	else
		levels = online_levels 
	create_displays();
}

// TODO
if (mode == level_selector_modes.packs)
	global.online_mode = false;



display_object = asset_get_index("obj_ev_display")
files = []
nodeless_packs = [];
function read_offline_levels() {
	if (mode == level_selector_modes.packs) { 
		files = get_all_files(global.packs_directory, pack_extension)
		nodeless_packs = array_create(array_length(files));
		var offline_levels = array_create(array_length(files));
		for (var i = 0; i < array_length(files); i++) {
			var pack_string = read_pack_string_from_file(files[i])
			
			var pack = import_pack_nodeless(pack_string);
			pack.save_name = files[i];
			
			nodeless_packs[i] = pack;
			
			lvl_string = get_thumbnail_level_string_from_pack_string(pack_string);
			offline_levels[i] = lvl_string
		}
		return offline_levels
	}
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
if mode != level_selector_modes.selecting_level_for_pack { 
	online_levels = copy_array(global.online_levels)
	sort_online_levels()
	
	levels = global.online_mode ? online_levels : offline_levels;
}
else {
	levels = offline_levels
}

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





create_displays()


var scroll_up = instance_create_layer(194, 61, buttons_layer, asset_get_index("obj_ev_level_select_scroll"), {
	image_index : 1,
})
var scroll_down = instance_create_layer(194, 95, buttons_layer, asset_get_index("obj_ev_level_select_scroll"));
add_child(scroll_up)
add_child(scroll_down)