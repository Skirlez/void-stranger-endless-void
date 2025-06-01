function get_weekday() {
	switch (current_weekday) {
		case 0: return "Sunday"
		case 1: return "Monday"
		case 2: return "Tuesday"
		case 3: return "Wednesday"
		case 4: return "Thursday"
		case 5: return "Friday"
		default: return "Saturday"
	}	
}

if !transition {
	if !animate {
		event_inherited();
		draw_set_color(c_white)
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_font(global.ev_font)
		draw_text(224 / 2, 144 / 2 + 20, "Use Mouse")

		draw_text(224 / 2, 144 - 10, get_weekday())
	}
	else { 
		
		if timer >= 90 {
			event_inherited()
			gpu_set_fog(true, c_white, 0, 1)
			image_alpha = 1 - ((timer - 90) / 60);
			event_inherited()
			image_alpha = 1
			gpu_set_fog(false, c_white, 0, 1)
	

		}
	}
}
else
	event_inherited();
	
