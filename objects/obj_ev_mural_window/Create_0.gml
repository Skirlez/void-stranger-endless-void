event_inherited();
draw_brand = instance_create_layer(112 - 40, 72 - 20, "WindowElements", agi("obj_ev_make_brand"), {
	brand : mural_properties.brd,
})
add_child(draw_brand)

mural_text = instance_create_layer(112 - 40, 72 + 20, "WindowElements", agi("obj_ev_textbox"), {
	empty_text : "Mural text",
	base_scale_x : 4.5,
	exceptions : "",
	allow_newlines : false,
	opened_x : 112,
	opened_y : 72 + 40,
	txt : mural_properties.txt,
})
add_child(mural_text)