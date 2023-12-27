
var scale = 1;
var mouse_on_me = ev_is_mouse_on_me();

if (selected && hover_state != 1) {
	hover_state = 1;	
}

if hover_state == 0 {
	if mouse_on_me
		hover_state = 1;	
	
}


else if hover_state == 1 {
	if hover_time < 100 {
		hover_time += 5
		scale += animcurve_channel_evaluate(hover_curve, hover_time / 100) / 5
	}
	else
		scale = 1.2
	if !ev_is_mouse_on_me() && !selected {
		hover_time = 100
		hover_state = 2	
	}
	
}
else if hover_state == 2 {
	hover_time -= 5
	scale += animcurve_channel_evaluate(unhover_curve, hover_time / 100) / 5
	if ev_is_mouse_on_me()
		hover_state = 1
}


hover_time = clamp(hover_time, 0, 100)

if animated {
	image_xscale = scale * base_scale_x
	image_yscale = scale * base_scale_y
}


if ev_mouse_pressed() && mouse_on_me
	event_user(0)