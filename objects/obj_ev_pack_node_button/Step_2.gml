var cam_x = camera_get_view_x(view_camera[0])
var cam_y = camera_get_view_y(view_camera[0])
var cam_width = camera_get_view_width(view_camera[0])
var cam_height = camera_get_view_height(view_camera[0])
var ratio_x = cam_width / 224;
var ratio_y = cam_height / 144;

scale_x *= ratio_x
scale_y *= ratio_y

image_xscale = scale_x / base_scale_x
image_yscale = scale_y / base_scale_y
x = cam_x + xstart * ratio_x;
y = cam_y + ystart * ratio_y;



if (array_length(node_instances) != 0 && pack_editor_inst().selected_thing != pack_things.selector) {
	for (var i = 0; i < array_length(node_instances); i++) {
		instance_destroy(node_instances[i])
		
	}
	node_instances = []
}

update_node_instances_positions()