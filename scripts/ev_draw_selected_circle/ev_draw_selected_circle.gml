
function ev_draw_selected_circle(pos_x, pos_y) {
	var scale = 1 + dsin(global.editor_time) * 0.1
	draw_sprite_ext(global.circle_sprite, 0, pos_x, pos_y, scale, scale, 0, c_white, 1)
}