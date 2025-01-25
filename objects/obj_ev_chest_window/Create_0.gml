event_inherited()

selector = instance_create_layer(112, 72, "WindowElements", asset_get_index("obj_ev_selector"), {
	elements : ["Locust", "Memory", "Wings", "Sword", "Empty", "Opened", "Idol", "Endless"],
	
	selected_element : chest_properties.itm,
	max_radius : 60
});
add_child(selector)

function get_item_name(item_id) {
	switch (item_id) {
		case chest_items.empty: return "Empty";
		case chest_items.locust: return "Locust";
		case chest_items.memory: return "Memory";
		case chest_items.wings: return "Wings";
		case chest_items.sword: return "Sword";
		case chest_items.opened: return "Opened";
		case chest_items.swapper: return "Idol";
		case chest_items.endless: return "Endless";
		default: return "IDK";
	}
}
/*

item_textbox = instance_create_layer(112, 72 - 10, "WindowElements", asset_get_index("obj_ev_textbox"), {
	base_scale_x : 4,
	allow_edit : false
})
add_child(item_textbox)


item_textbox.txt = get_item_name(chest_properties.itm)


next_button = instance_create_layer(112, 72 + 10, "WindowElements", asset_get_index("obj_ev_executing_button"), {
	txt : "Next",
	base_scale_y : 0.6,
	func : function () {
		chest_properties.itm++
		if (chest_properties.itm >= chest_items.size)
			chest_properties.itm = 0
		item_textbox.txt = get_item_name(chest_properties.itm)
	},
	layer_num : 1,
	chest_properties : id.chest_properties,
	item_textbox : id.item_textbox,
	get_item_name : id.get_item_name
})

add_child(next_button)