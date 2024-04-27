draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_color(c_black)
ev_draw_rectangle(x - 2, y - 2, x + string_width(txt) + 2, y + string_height(txt), false)
draw_set_color(c_white)
draw_text(x, y, txt)

vspeed -= 0.3
if vspeed < 0
	vspeed = 0