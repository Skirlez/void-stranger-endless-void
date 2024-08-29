var width = base_scale_x * 32 * 1.2 + 4;
var height = base_scale_y * 32 * 1.2 + 4;
if !surface_exists(button_surface)
	button_surface = surface_create(width, height)
else if surface_get_width(button_surface) != width
	|| surface_get_height(button_surface) != height
{
	surface_resize(button_surface, width, height)
}

surface_set_target(button_surface)
draw_clear_alpha(c_black, 0)
draw_sprite_ext(sprite_index, image_index, width / 2, height / 2, scale_x, scale_y, image_angle, image_blend, image_alpha)
draw_set_color(c_black)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(global.ev_font)
draw_text(width / 2, height / 2, txt)

surface_reset_target()


var cam_x = camera_get_view_x(view_camera[0])
var cam_y = camera_get_view_y(view_camera[0])
var cam_width = camera_get_view_width(view_camera[0])
var cam_height = camera_get_view_height(view_camera[0])
var ratio_x = cam_width / 224;
var ratio_y = cam_height / 144;

draw_surface_ext(button_surface, 
	cam_x + (xstart - width / 2) * ratio_x, 
	cam_y + (ystart - height / 2) * ratio_y,
	ratio_x,
	ratio_y,
	0,
	c_white,
	1)