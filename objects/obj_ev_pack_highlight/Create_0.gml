event_inherited()

var play = instance_create_layer(208, 40, "LevelHighlightButtons", asset_get_index("obj_ev_play_button"))
play.layer_num = 1
//play.lvl = lvl
//play.lvl_sha = lvl_sha
play.display_instance = display_instance
play.highlighter = id;
play.image_alpha = 0
/*
var copy = instance_create_layer(192, 40, "LevelHighlightButtons", asset_get_index("obj_ev_copy_button"))
copy.layer_num = 1
copy.lvl = lvl
copy.image_alpha = 0
*/

var back = instance_create_layer(200, 16, "LevelHighlightButtons", asset_get_index("obj_ev_main_menu_button"), {
	base_scale_x : 1,
	base_scale_y : 0.7,
	txt : "Back",
	room_name : room_get_name(room),
	layer_num : 1,
	image_alpha : 0
});



add_child(play)
add_child(back)
//add_child(copy)


function format_date(date_str) {
	if string_length(date_str) < 8
		return "15/05/2015"
	var str = "";
	var pos = string_length(date_str);
	str += string_char_at(date_str, pos - 1) + string_char_at(date_str, pos) + "/";
	pos -= 2;
	str += string_char_at(date_str, pos - 1) + string_char_at(date_str, pos) + "/";
	pos -= 2;
	
	var amount_left = pos + 1;
	while (pos >= 1) {
		str += string_char_at(date_str, amount_left - pos)
		pos--;
	}
	return str;	
}


var textbox_offset;
if (!global.online_mode) {
	date_textbox = noone
	
	var edit = instance_create_layer(192, 73, "LevelHighlightButtons", asset_get_index("obj_ev_executing_button"), {
		layer_num : 1,
		nodeless_pack : nodeless_pack,
		display_instance : display_instance,
		highlighter : id,
		sprite_index : asset_get_index("spr_ev_edit_level"),
		image_alpha : 0,
		func : function () {
			highlighter.hide_textbox();
			global.editor_instance.edit_level_pack_transition(nodeless_pack, display_instance);
		}
	})
	/*
	var claim = instance_create_layer(208, 73, "LevelHighlightButtons", asset_get_index("obj_ev_claim_button"))
	claim.layer_num = 1
	claim.lvl = lvl
	claim.highlighter = id
	claim.image_alpha = 0
	
	var deleteb = instance_create_layer(192, 90, "LevelHighlightButtons", asset_get_index("obj_ev_delete_button"))
	deleteb.layer_num = 1
	deleteb.level_select = instance_find(asset_get_index("obj_ev_level_select"), 0)
	deleteb.save_name = lvl.save_name
	deleteb.display_instance = display_instance
	deleteb.image_alpha = 0

	var upload = instance_create_layer(208, 90, "LevelHighlightButtons", asset_get_index("obj_ev_upload_button"))
	upload.layer_num = 1
	upload.lvl = lvl;
	upload.image_alpha = 0

	
	
	add_child(claim)
	add_child(deleteb)
	add_child(upload)
	
	*/
	textbox_offset = 20;
	add_child(edit)
}
else {
	date_textbox = instance_create_layer(201, 130, "LevelDescription", asset_get_index("obj_ev_textbox"), 
	{
		txt : ("Upload date:\n" 
			+ format_date(nodeless_pack.upload_date) 
			+ "\nLast edited date:\n" 
			+ format_date(nodeless_pack.last_edit_date)),
		base_scale_x : 2,
		base_scale_y : 1,
		layer_num : 1,
		allow_deletion : false,
		char_limit : 0,	
		opened_x : room_width / 2,
		opened_y : room_height / 2,
		image_alpha : 0
	})
	textbox_offset = 0;
	add_child(date_textbox)
}

description_textbox = instance_create_layer(201, 90 + textbox_offset, "LevelDescription", asset_get_index("obj_ev_textbox"), 
{
	txt : (nodeless_pack.description == "" ? "No description provided." : "Description:\n" + nodeless_pack.description),
	base_scale_x : 2,
	base_scale_y : 1,
	layer_num : 1,
	allow_deletion : false,
	char_limit : 0,	
	opened_x : room_width / 2,
	opened_y : room_height / 2,
	image_alpha : 0
})

author_textbox = instance_create_layer(201, 110 + textbox_offset, "LevelDescription", asset_get_index("obj_ev_textbox"), 
{
	txt : (nodeless_pack.author == "" ? "No author?" : "Author:\n" + nodeless_pack.author),
	base_scale_x : 2,
	base_scale_y : 1,
	layer_num : 1,
	allow_deletion : false,
	char_limit : 0,	
	opened_x : room_width / 2,
	opened_y : room_height / 2,
	image_alpha : 0
})

add_child(description_textbox)
add_child(author_textbox)


function hide_textbox() {
	textbox_open_depth = layer_get_depth("LevelHighlightButtons")
}

textbox_depth = layer_get_depth("LevelHighlightButtons")
textbox_open_depth = layer_get_depth("WindowElements")