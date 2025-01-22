if pack_editor_inst().selected_thing != pack_things.hammer || !instance_exists(node_inst) {
	instance_destroy(id)
	exit
}
x = lerp(x, target_x, 0.5)
y = lerp(y, target_y, 0.5)
base_scale_x = lerp(base_scale_x, 1, 0.5)
base_scale_y = lerp(base_scale_y, 1, 0.5)
image_xscale = base_scale_x;
image_yscale = base_scale_y;
event_inherited()
