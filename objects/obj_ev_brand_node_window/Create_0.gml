event_inherited();
draw_brand = instance_create_layer(x, y, "WindowElements", asset_get_index("obj_ev_make_brand"), {
	brand : node_instance.brand,
})
add_child(draw_brand)