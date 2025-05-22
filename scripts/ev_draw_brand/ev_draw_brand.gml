function ev_draw_brand(pos_x, pos_y, brand){
	if (brand >= 68719476736)
		brand = 68719476735
	var i = 0;
	while (brand > 0) {
		var bit = brand % 2
		brand /= 2;
		if (bit == 1)
			ev_draw_pixel(pos_x + (i % 6), pos_y + (i div 6)) 
		i++;
	}
}

function ev_draw_mural_brand(pos_x, pos_y, brand, text) {
	if (brand >= 68719476736)
		brand = 68719476735
	var i = 0;
	var text_index = 1;
	while (brand > 0) {
		var bit = brand % 2
		brand /= 2;
		if (bit == 1) {
			var ind;
			var sprite;
			
			if text_index > string_length(text) {
				sprite = agi("spr_ev_mural_alphabet_empty")
				ind = 0;
			}
			else {
				var char = string_ord_at(text, text_index)
				text_index++;
				
				if (char == "j")
					sprite = agi("spr_ev_mural_alphabet_j") // the index for j is missing, instead being a duplicate of i
				else
					sprite = agi("spr_mural_alphabet")
				
				ind = string_ord_at(text, i + 1) - ord("a")
			}
			
			
			draw_sprite(sprite, ind, pos_x + (i % 6) * 8, pos_y + (i div 6) * 8)
		}
		i++;
	}
}