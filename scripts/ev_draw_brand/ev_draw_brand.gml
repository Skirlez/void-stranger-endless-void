function ev_draw_brand(brand, _x, _y){
	if (brand >= 68719476736)
		brand = 68719476735
	var i = 0;
	while (brand > 0) {
		var bit = brand % 2
		brand /= 2;
			
		if (bit == 1)
			ev_draw_pixel(_x + (i % 6), _y + (i div 6)) 
		i++;
	}
}