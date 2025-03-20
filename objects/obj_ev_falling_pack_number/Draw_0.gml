draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(global.ev_font)
draw_set_color(c_white)
function draw_falling_number(_x, _y, params) {
	draw_text_transformed(_x, _y, params.txt, 1, 1, params.angle)
}

draw_shadow_generic(x, y, draw_falling_number, { txt : string(number), angle : image_angle });