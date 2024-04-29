if (room == global.editor_room) {
	
	if (global.selected_thing == thing_placeable) && global.mouse_layer == 0 {

		var state = global.display_object.held_tile_state;
		if !surface_exists(spin_surface)
			spin_surface = surface_create(16, 16)
		surface_set_target(spin_surface)
		draw_clear_alpha(c_black, 0)
		state.tile.draw_function(state, 0, 0, false, global.level)
		surface_reset_target()
		
		var size = 1

		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_font(global.ev_font)
		
		draw_set_color(c_black)
		draw_text_transformed(27 + 0.5, 100, state.tile.display_name, 0.5, 0.5, 0)
		draw_text_transformed(27 - 0.5, 100, state.tile.display_name, 0.5, 0.5, 0)
		draw_text_transformed(27, 100 + 0.5, state.tile.display_name, 0.5, 0.5, 0)
		draw_text_transformed(27, 100 - 0.5, state.tile.display_name, 0.5, 0.5, 0)
		draw_set_color(c_white)
		draw_text_transformed(27, 100, state.tile.display_name, 0.5, 0.5, 0)
		

		if stupid_sprite_i_can_only_delete_later == noone {
			var sprite = sprite_create_from_surface(spin_surface, 0, 0, 16, 16, false, false, 8, 0)
			ev_draw_cube(sprite, 0, 27, 84, 7, (dsin(global.editor_time / 2.8 + 120) + 1) / 2, (dsin(global.editor_time / 3) + 1) / 2)		
			stupid_sprite_i_can_only_delete_later = sprite;
		}
		

		
	}
	if (global.selected_thing == thing_multiplaceable) {
		
	}
}

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
	
	draw_text_transformed(112, 72 + 67, "0.875", 0.5, 0.5, 0)
}
else if (room == global.startup_room) {
	draw_set_color(c_white)
	draw_set_font(global.ev_font)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text_transformed(112, 72, "Communicating with server...", 1, 1, 0)
}

