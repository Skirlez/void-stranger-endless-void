var cam_x = camera_get_view_x(view_camera[0])
var cam_y = camera_get_view_y(view_camera[0])
var cam_width = camera_get_view_width(view_camera[0])
var cam_height = camera_get_view_height(view_camera[0])
image_xscale = cam_width / 224
image_yscale = cam_height / 144

x = cam_x + xstart;
y = cam_y + ystart;