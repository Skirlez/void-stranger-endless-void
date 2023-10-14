global.mouse_layer = 0
global.mouse_held = false;
global.mouse_pressed = false;
if room == rm_ev_editor {
	var quill = asset_get_index("obj_quill")
	if quill != -1
		instance_destroy(quill)
	draw_set_circle_precision(48)
}