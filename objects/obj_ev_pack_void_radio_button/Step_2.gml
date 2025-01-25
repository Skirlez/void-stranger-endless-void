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

spin_time_h += 0.45 + additional_spin
spin_time_v += 0.38 + additional_spin
spin_h = (dsin(spin_time_h) + 1) / 2;
spin_v = (dcos(spin_time_v) + 1) / 2;

if additional_spin > 0
	additional_spin *= 0.9
else
	additional_spin = 0;