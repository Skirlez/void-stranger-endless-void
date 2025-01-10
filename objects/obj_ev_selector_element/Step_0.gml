if !doing_animation {
	var radius_before = radius;
	radius = lerp(radius, max_radius, 0.1)
	angle += (radius - radius_before) * 2;

	if ev_is_mouse_on_me() && ev_mouse_pressed() && selector.state != selector_states.animating {
		selector.start_return_sequence(index)
		audio_play_sound(asset_get_index("snd_ev_textbox_click"), 10, false, 1, 0, 0.9)
		vsp = -3;
		animation_power = 2;
	}
}
else {
	animation_time++;
	radius = animcurve_channel_evaluate(curve, power(animation_time / 15, animation_power)) * animation_radius

	if animation_time == 15 {
		
		selector.return_bounce(id)
		instance_destroy(id)
	}
}

x = pos_x + dcos(angle) * radius
y = pos_y + dsin(angle) * radius

y_bounce += vsp
vsp += 0.5;

if y_bounce > 0 {
	y_bounce = 0;
	vsp = 0;
}