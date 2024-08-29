event_inherited()
global.mouse_layer++;

var cam_x = camera_get_view_x(view_camera[0])
var cam_y = camera_get_view_y(view_camera[0])

camera_set_view_size(view_camera[0], 224, 144)
new_window(cam_x, cam_y, asset_get_index("obj_ev_level_select"), {
	pack_selector : true,
	layer_num : global.mouse_layer,
	buttons_layer : "LevelSelectWindowElements"
})