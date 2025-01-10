if selector == noone
	instance_destroy(id)

radius = 0;

doing_animation = false;
animation_radius = 0;
animation_time = 0;
curve = animcurve_get_channel(ac_selector_element_return, 0)

function start_return_animation() {
	doing_animation = true;
	animation_radius = radius;
}

image_xscale = max(1, (string_width(txt) + string_width(" |")) / 16)
x -= image_xscale * 8
y -= image_yscale * 8

pos_x = x;
pos_y = y;

y_bounce = 0;
vsp = 0;
animation_power = 1;