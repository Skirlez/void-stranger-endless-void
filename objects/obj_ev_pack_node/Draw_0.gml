var i_imageframe;
if animate {
	var iframes = sprite_get_number(sprite_index)
	var func = asset_get_index("scr_music_strobe_integer")
	if func == -1
		i_imageframe = image_index
	else
		i_imageframe = func(iframes)
}
else
	i_imageframe = 0

/*
if connecting_exit {
	
	ev_draw_pack_line(x, y, mouse_x, mouse_y)
}
else if instance_exists(display_inst) {
	
	var other_center_x = display_inst.x + 112 * display_inst.image_xscale;
	var other_center_y = display_inst.y + 72 * display_inst.image_yscale;

	ev_draw_pack_line(x, y, other_center_x, other_center_y)
}
*/

spin_time_h += 0.45 + random_range(-0.05, 0.05)
spin_time_v += 0.38 + random_range(-0.05, 0.05)
	
var spin_h = (dsin(spin_time_h) + 1) / 2;
var spin_v = (dcos(spin_time_v) + 1) / 2;

ev_draw_cube(sprite_index, i_imageframe, x, y, 5, spin_h, spin_v)
draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(global.ev_font)

draw_text_shadow(x, y + 16, text)

