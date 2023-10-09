if !surface_exists(surf) {
	surf = surface_create(16, 16)
	surface_set_target(surf)
	draw_set_color(c_white)
	draw_tile(global.tileset_1, ind, 0, 0, 0)	
	surface_reset_target()
}


draw_sprite_ext(black_sprite, 0, x, y, 
	image_xscale * 1.15, image_yscale * 1.15, 0, c_white, 1)

draw_surface_ext(surf, x - image_xscale * 8, y - image_yscale * 8, 
	image_xscale, image_yscale, 0, c_white, 1)
