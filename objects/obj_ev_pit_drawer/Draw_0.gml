function should_draw() {
	for (var i = 0; i < array_length(tilemaps_to_check); i++) {
		var tilemap = tilemaps_to_check[i];
		if !tile_get_empty(tilemap_get(tilemap, x div 16, y div 16 + 1))
			return false;
	}
	return true;
}
if should_draw()
	draw_sprite(sprite_index, 1, x, y + 16)