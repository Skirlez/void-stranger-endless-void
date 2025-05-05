event_inherited();
var level = node_instance.properties.level;

var txt;
if level.bount >= 0
	txt = string(level.bount);
else
	txt = "???";


name_textbox = instance_create_layer(x - 30, y - 30, "WindowElements", asset_get_index("obj_ev_textbox"), {
	empty_text : "Level Name",
	txt : level.name,
	allow_newlines : false,
	automatic_newline: false,
	char_limit : 30,
	base_scale_x : 5,
});
name_warning = instance_create_layer(x + 40, y - 30, "WindowElements", asset_get_index("obj_ev_textbox"), {
	txt : "WARNING! To save pack progress for players, EV saves the level's name to a file."
		+ " If you have uploaded this pack, DON'T modify the level names! Otherwise players"
		+ " who saved on those levels will have their save erased!",
	allow_deletion : false,
	char_limit : -1,
	
	allow_deletion : false,
	base_scale_x : 3,
});

bount_textbox = instance_create_layer(x - 54, y, "WindowElements", asset_get_index("obj_ev_textbox"), {
	empty_text : "Brane Count",
	txt : txt,
	allow_alphanumeric : false,
	exceptions : "?0123456789",
	char_limit : 3,
	base_scale_x : 2,
});

var copy = instance_create_layer(x + 55, y + 30, "WindowElements", agi("obj_ev_executing_button"), {
	layer_num : 1,
	lvl : level,
	sprite_index : agi("spr_ev_copy"),
	func : function () {
		var str = export_level(lvl);
		clipboard_set_text(str)
		ev_notify("Copied to clipboard!")
	}
})


add_child(bount_textbox);
add_child(name_textbox);
add_child(name_warning);
add_child(copy);

is_brand_room = is_level_brand_room(level)

elements_depth = layer_get_depth("WindowElements")