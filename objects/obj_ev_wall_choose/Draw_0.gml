if !surface_exists(surf) {
	surf = surface_create(16, 16)
	surface_set_target(surf)
	draw_set_color(c_white)
	draw_tile(tileset, ind, 0, 0, 0)	
	surface_reset_target()
}


draw_sprite_ext(black_sprite, 0, x, y, 
	scale_x * 1.15, scale_y * 1.15, 0, c_white, 1)

draw_surface_ext(surf, x - scale_x * 8, y - scale_y * 8, 
	scale_x, scale_y, 0, c_white, 1)
