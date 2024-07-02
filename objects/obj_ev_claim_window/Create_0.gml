event_inherited()
if (lvl == noone || highlighter == noone)
	exit;
var no = instance_create_layer(142, 102, "WindowElements", asset_get_index("obj_ev_executing_button"), 
{
	txt: "No",
	base_scale_x: 0.8,
	base_scale_y: 0.6,
	layer_num: global.mouse_layer,
	func : function() {
		instance_destroy(window)
	}
}
)
var yes = instance_create_layer(82, 102, "WindowElements", asset_get_index("obj_ev_executing_button"), 
{
	txt: "Yes",
	base_scale_x: 0.8,
	base_scale_y: 0.6,
	layer_num: global.mouse_layer,
	func : function () {
		with (window) {
			lvl.author = global.author.username
			lvl.author_brand = global.author.brand
			highlighter.author_textbox.txt = ((lvl.author == "") ? "No author?" : ("Author:\n" + lvl.author))
			save_level(lvl)
			instance_destroy(id)
		}
	}
})
add_child(no)
add_child(yes)
