function get_node_at_position(pos_x, pos_y) {
	var display_inst = instance_position(mouse_x, mouse_y, global.display_object)
	if instance_exists(display_inst) && display_inst != id
		return display_inst
	var node_inst = instance_position(mouse_x, mouse_y, global.node_object)
	if node_inst == id
		return noone;
	return node_inst;
}


function ev_draw_pack_line(x1, y1, x2, y2) {
	draw_set_color(c_black)
	draw_line_width(x1, y1,	x2, y2, 2)
	static arrow_sprite = asset_get_index("spr_pack_arrow")
	
	var t = (global.editor_time % 200) / 200
	var pos_x = lerp(x1, x2, t)
	var pos_y = lerp(y1, y2, t)


	// makes the spin happen twice
	var t2 = t % 0.5;
	
	var angle_target = point_direction(x1, y1, x2, y2);
	var angle_start = point_direction(x1, y1, x2, y2) + 360;

	// (1-1/exp(x)) goes from 0 to 1 in a nice curve
	var angle = lerp(angle_start, angle_target, 1 - (1 / exp(t2 * 12)))


	// roots of sin x give us a sort of "rectangular" curve from 0-pi, which is what we want -
	// very quickly going to a near 1 value at the start and very quickly dropping off at the end
	var scale = power(sin(t * pi), 1/3)
	
	draw_sprite_ext(arrow_sprite, 0, pos_x + 0.5, pos_y + 0.5, scale, scale, angle, c_white, 1)
	
	/*
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_color(c_white)
	draw_text_ext_transformed(
		pos_x + 9 * dcos(angle_target + 90), 
		pos_y - 9 * dsin(angle_target + 90) - 4, "1", 0, 300, scale * 0.5, scale * 0.5, 0)
	*/
}