var cam_x = camera_get_view_x(view_camera[0])
var cam_y = camera_get_view_y(view_camera[0])
var cam_width = camera_get_view_width(view_camera[0])
var cam_height = camera_get_view_height(view_camera[0])
var ratio_x = cam_width / 224;
var ratio_y = cam_height / 144;
image_xscale = ratio_x * base_scale_x_start
image_yscale = ratio_y * base_scale_y_start
x = cam_x + xstart * ratio_x;
y = cam_y + ystart * ratio_y;

pressable = visible;