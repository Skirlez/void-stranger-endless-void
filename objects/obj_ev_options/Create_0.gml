event_inherited();

function can_commit() {
	var length = string_length(author_textbox.txt)
	return (length > 0)
}

function commit() {
	global.author.username = author_textbox.txt
	global.author.brand = author_brand.brand;
	global.server_ip = server_textbox.txt;
	ev_save()	
	ev_update_vars()
}


save_server_ip = global.server_ip;

instance_create_layer(200, 16, "Instances", asset_get_index("obj_ev_executing_button"), {
	base_scale_x : 1,
	base_scale_y : 0.7,
	txt : "Back",
	room_name : "rm_ev_menu",
	func : function () {
		var options = asset_get_index("obj_ev_options");
		with (options) {
			if (can_commit()) {
				commit();
				if save_server_ip != global.server_ip
					room_goto(asset_get_index("rm_ev_startup"))
				else
					room_goto(asset_get_index("rm_ev_menu"))
			}
		}
	}
});

instance_create_layer(112 + 30, 72 + 50, "Instances", asset_get_index("obj_ev_executing_button"), {
	base_scale_x : 1.7,
	base_scale_y : 0.7,
	txt : "Random",
	func : function () {
		asset_get_index("obj_ev_make_brand").brand = int64(irandom_range(0, $FFFFFFFFF))
	}
});
author_brand = instance_create_layer(112 + 30, 72 + 10, "Instances", asset_get_index("obj_ev_make_brand"), {
	brand : global.author.brand
})
add_child(author_brand)

change_character = instance_create_layer(112 - 30, 72 + 10, "Instances", asset_get_index("obj_ev_change_character"));
add_child(change_character)
/* Maybe one day, but today ain't the day
change_memory = instance_create_layer(112 - 46, 72 + 30, "Instances", asset_get_index("obj_ev_change_memory"));
add_child(change_memory)
change_wings = instance_create_layer(112 - 30, 72 + 30, "Instances", asset_get_index("obj_ev_change_wings"));
add_child(change_wings)
change_blade = instance_create_layer(112 - 14, 72 + 30, "Instances", asset_get_index("obj_ev_change_blade"));
add_child(change_blade)
*/

author_textbox = instance_create_layer(112, 72 - 20, "Instances", asset_get_index("obj_ev_textbox"), 
{
	empty_text : "Username",
	allow_newlines : false,
	automatic_newline : false,
	char_limit : 30,
	base_scale_x : 4,
	txt : global.author.username
})
add_child(author_textbox)


server_textbox = instance_create_layer(112, 72 - 40, "Instances", asset_get_index("obj_ev_textbox"), 
{
	empty_text : "Server IP",
	allow_newlines : false,
	automatic_newline : false,
	char_limit : 100,
	base_scale_x : 6,
	txt : global.server_ip
})
add_child(server_textbox)