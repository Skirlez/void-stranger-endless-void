event_inherited();
var txt;
if node_instance.lvl.bount >= 0
	txt = string(node_instance.lvl.bount);
else
	txt = "???";

textbox_instance = instance_create_layer(x, y, "WindowElements", asset_get_index("obj_ev_textbox"), {
	empty_text : "Brane Count",
	txt : txt,
	allow_alphanumeric : false,
	exceptions : "?0123456789",
	char_limit : 3,
	base_scale_x : 2,
});

add_child(textbox_instance);