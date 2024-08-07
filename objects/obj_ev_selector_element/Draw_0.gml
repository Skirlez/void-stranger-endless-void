draw_set_font(global.ev_font)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_top)


draw_sprite_ext(sprite_index, 0, x, y + y_bounce, image_xscale, image_yscale, 0, c_white, 1)
draw_text_ext(x + 3, y + 1 + y_bounce, txt, 15, -1)
