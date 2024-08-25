event_inherited()

var quill_exists = global.compiled_for_merge && instance_exists(asset_get_index("obj_quill"))

if mouse_y < 48 && mouse_x < 64 && !quill_exists {
	y = lerp(y, 14, 0.3)	
}
else {
	y = lerp(y, ystart, 0.3)	
}