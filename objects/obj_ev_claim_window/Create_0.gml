event_inherited()

var no = instance_create_layer(142, 102, "WindowElements2", asset_get_index("obj_ev_executing_button"), 
{
	txt: "No",
	base_scale_x: 0.8,
	base_scale_y: 0.6,
	layer_num: global.mouse_layer,
	func : function() {
		instance_destroy(window)
	}
})
var yes = instance_create_layer(82, 102, "WindowElements2", asset_get_index("obj_ev_executing_button"), 
{
	txt: "Yes",
	base_scale_x: 0.8,
	base_scale_y: 0.6,
	layer_num: global.mouse_layer,
	func : function () {
		with (window) {
			global.level.author = global.author.username
			global.level.author_brand = global.author.brand
			instance_destroy(id)
		}
	}
})
add_child(no)
add_child(yes)
