
// i know that that's two surfaces per shard, but i don't care,
if !surface_exists(surface_invert) {
	surface_invert = surface_create(224, 144)	
}
if !surface_exists(surface) {
	surface = surface_create(224, 144)	
}
if !surface_exists(game_surface) {
	game_surface = surface_create(224, 144)	
}


// create the inverse of this shard
surface_set_target(surface_invert)
draw_clear_alpha(c_white, 1)
gpu_set_blendmode(bm_subtract)
draw_sprite(sprite_index, image_index, 0, 0)
gpu_set_blendmode(bm_normal)
surface_reset_target()

// subtract that inverse from the game surface to leave only the shard
surface_set_target(surface)
draw_surface(game_surface, 0, 0)
gpu_set_blendmode(bm_subtract)
draw_surface(surface_invert, 0, 0)
gpu_set_blendmode(bm_normal)
surface_reset_target()



draw_surface_ext(surface, x, y, image_xscale, image_yscale, 0, c_white, 1)
