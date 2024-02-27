if global.erasing != -1 {
	if !surface_exists(erasing_surface)
		erasing_surface = surface_create(224, 144)
	surface_set_target(erasing_surface)
	draw_clear(c_black)
	draw_set_color(c_white)
	gpu_set_blendmode(bm_subtract);	
	var rand_x = irandom_range(-3, 3)
	var rand_y = irandom_range(-3, 3)
	draw_circle(112 + rand_x, 72 + rand_y, global.erasing * 0.75, false)
	gpu_set_blendmode(bm_normal);
	
	draw_set_alpha(1 - min(1, global.erasing / 350))
	draw_circle(112 + rand_x, 72 + rand_y, global.erasing * 0.75, false)
	draw_set_alpha(1)
	
	surface_reset_target()
	draw_surface(erasing_surface, 0, 0)
}

if (edit_transition != -1) {
	draw_clear(c_black)	
}

if (room == asset_get_index("rm_ev_menu")) {
	draw_set_color(c_white)
	draw_set_font(global.ev_font)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text_transformed(112, 72 + 50, "Packs coming whenever..", 0.5, 0.5, 0)
}
if (room == global.startup_room) {
	draw_set_color(c_white)
	draw_set_font(global.ev_font)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text_transformed(112, 72, "Communicating with server...", 1, 1, 0)
}