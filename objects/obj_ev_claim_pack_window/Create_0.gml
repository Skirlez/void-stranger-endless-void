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
})
var yes = instance_create_layer(82, 102, "WindowElements", asset_get_index("obj_ev_executing_button"), 
{
	txt: "Yes",
	base_scale_x: 0.8,
	base_scale_y: 0.6,
	layer_num: global.mouse_layer,
	func : function () {
		with (window) {
			pack.author = global.author.username
			pack.author_brand = global.author.brand

			highlighter.author_textbox.txt = ev_make_author_textbox_text(pack.author)
			save_pack(pack)
			instance_destroy(id)
		}
	}
})
add_child(no)
add_child(yes)
