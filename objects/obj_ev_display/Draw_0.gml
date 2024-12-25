

if display_context == display_contexts.pack_editor {

}

if outside_view
	exit;


function draw() {
	surface_set_target(game_surface)
	draw_clear_alpha(c_black, 1)

	var tile_mode = display_context == display_contexts.level_editor ? global.tile_mode : false


	function draw_tile_state(i, j, tile_state, preview = false) {
		var tile = tile_state.tile
		tile.draw_function(tile_state, i, j, preview, lvl, no_spoiling)
	}

	draw_sprite(base_ui, 0, 0, 8 * 16)

	draw_set_font(global.ev_font)
	draw_set_halign(fa_left)
	draw_set_valign(fa_right)
	draw_set_color(c_black)


	draw_text_ext(1 * 16, 9 * 16 + 1, "VO", 0, -1)
	draw_text_ext(2 * 16, 9 * 16 + 1, "ID", 0, -1)

	draw_sprite(asset_get_index("spr_locust_idol"), 0, 5 * 16 - 8, 8 * 16 + 8)
	draw_text(5 * 16, 9 * 16 + 1, "00")

	// idk how void stranger draws it but this is the only way i could make it align properly
	draw_text(12 * 16, 9 * 16 + 1, "V?")
	draw_text(13 * 16, 9 * 16 + 1, "?")
	draw_text(13 * 16 + 8, 9 * 16 + 1, "?")

	var rodsprite = (lvl.burdens[burden_stackrod]) ? stackrod_sprite : voidrod_sprite
	draw_sprite(rodsprite, 1, 16 * 6, 8 * 16)
	if (lvl.burdens[burden_swapper]) draw_sprite(asset_get_index("spr_ev_swapper"), 0, 16 * 6 + 16, 8 * 16) //I'm bad at math.
	for (var i = 0; i < array_length(lvl.burdens) - 1; i++) {
		if lvl.burdens[i] {
			switch i {
			case 2:
				if global.blade_style != 2 burdens_sprite = ev_get_burden_sprite(global.blade_style)
				else burdens_sprite = asset_get_index("spr_ev_items_lev")   	
				break
			case 1:
				burdens_sprite = ev_get_burden_sprite(global.wings_style)
				break
			case 0:
				burdens_sprite = ev_get_burden_sprite(global.memory_style)
				break
			default:
				burdens_sprite = asset_get_index("spr_ev_items_lev") //Avoid displaying the diamond thing
				break
			}
			if (i != 4) draw_sprite_part(burdens_sprite, 0, 16 + i * 16, 0, 16, 16, 16 * (8 + i), 8 * 16)		
		}
	}

	for (var i = 0; i < 9; i++)	{
		for (var j = 0; j < 14; j++) {
			if i != 8 {
				var tile_state = lvl.tiles[i][j]
				draw_tile_state(i, j, tile_state)
			}
	
			if (tile_mode)
				draw_set_alpha(0.3)
			var object_state = lvl.objects[i][j]
			draw_tile_state(i, j, object_state)
			if (tile_mode)
				draw_set_alpha(1)
		}
	}


	if (display_context == display_contexts.level_editor && ev_is_mouse_on_me()) {
		var tile_j = floor((mouse_x - x) / (16 * image_xscale))
		var tile_i = floor((mouse_y - y) / (16 * image_yscale))

		if dragging {
			var small_tile_i = drag_box_i
			var small_tile_j = drag_box_j
		
			if (tile_i < drag_box_i) {
				small_tile_i = tile_i
				tile_i = drag_box_i
			}
			if (tile_j < drag_box_j) {
				small_tile_j = tile_j
				tile_j = drag_box_j
			}
		
			draw_sprite_ext(global.selection_sprite, 0, 
				small_tile_j * 16, small_tile_i * 16, 
				tile_j - small_tile_j + 1, tile_i - small_tile_i + 1,
				0, c_white, 1)
		}
	
		else if global.selected_thing == thing_placeable 
		&& held_tile_state.tile != global.editor_instance.object_empty {
			draw_set_alpha((dsin(global.editor_time * 3) / 4) + 0.75)
			draw_tile_state(tile_i, tile_j, held_tile_state, true)
			draw_set_alpha(1)
		}
		else if global.selected_thing == thing_multiplaceable {
			draw_set_alpha((dsin(global.editor_time * 3) / 4) + 0.75)
			for (var i = 0; i < array_length(held_tile_array); i++) {
				for (var j = 0; j < array_length(held_tile_array[i]); j++) {
					var tile_state = held_tile_array[i][j]
					if (tile_state.tile == global.editor_instance.current_empty_tile)
						continue;
					var new_tile_i = tile_i + i;
					if new_tile_i >= 9
						continue;
					var new_tile_j = tile_j + j
					if new_tile_j >= 14
						continue;
					draw_tile_state(tile_i + i, tile_j + j, tile_state, false)
				}
			}
			draw_set_alpha(1)
		}
	}
		
	surface_reset_target()
}

if !surface_exists(game_surface) {
	game_surface = surface_create(224, 144);
	if (no_redraw) {
		draw();
	}
}

if (!no_redraw)
	draw();
	
draw_surface_ext(game_surface, x, y, image_xscale, image_yscale, 0, c_white, 1)
draw_sprite_ext(border_sprite, 0, x, y, image_xscale, image_yscale, 0, c_white, 1)


if brand != 0 {
	if !surface_exists(brand_surface) || cached_author_brand != lvl.author_brand {
		brand_surface = surface_create(8, 8)
		surface_set_target(brand_surface)
		draw_clear_alpha(c_black, 1)
		
		draw_set_color(c_grey)
		ev_draw_rectangle(0, 0, 7, 7, true)
		
		draw_set_color(c_white)
		
		ev_draw_brand(brand, 1, 1)
		
		surface_reset_target()
		cached_author_brand = lvl.author_brand
	}	
	var size = 1;
	draw_surface_ext(brand_surface, x + sprite_width - 4 * size,
		y + sprite_height - 4 * size, size, size, 0, c_white, image_alpha)
}



if name != "" {
	if (!surface_exists(name_surface)) {
		var txt = name;
		name_surface = surface_create((string_width(txt) + 2), (string_height(txt) + 2));	
		surface_set_target(name_surface)
		draw_clear_alpha(c_black, 0)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		draw_set_color(c_white)
		draw_set_font(global.ev_font)
		draw_text_shadow(2, 1, txt, c_black)
		surface_reset_target()
	}


	
	draw_set_font(global.ev_font)
	var size = 1
	var text_width = string_width(lvl.name);
	if (text_width > sprite_width) { 
		size = sprite_width / text_width
	}
	draw_surface_ext(name_surface, x + sprite_width / 2 - (surface_get_width(name_surface) / 2) * size,
		y + sprite_height + 2, size, size, 0, c_white, image_alpha)
}

if draw_beaten == 1 {
	draw_sprite(asset_get_index("spr_ev_checkmark"), 0, x + sprite_width - 9, y + sprite_height)
}
else if draw_beaten == 2 {
	var time = (global.editor_time / 2) % 80
	var spr = asset_get_index("spr_ev_memory_collected")
	if time > sprite_get_number(spr) - 1
		time = 0;
	draw_sprite(spr, time, x + sprite_width - 9, y + sprite_height)
	
}

