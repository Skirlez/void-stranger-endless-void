event_inherited();
draw_brand = instance_create_layer(x, y, "WindowElements", agi("obj_ev_make_brand"), {
	brand : node_instance.properties.brand,
})
add_child(draw_brand)