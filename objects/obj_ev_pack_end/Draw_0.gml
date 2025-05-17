draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(global.ev_font)

draw_text(224 / 2, stats_text_y, "Stats")
draw_text(224 / 2, you_win_y, "Pack cleared!")
draw_set_halign(fa_left)
for (var i = 0; i < array_length(stat_texts); i++) {
	draw_text(stats_x[i], 50 + 12 * i, stat_texts[i] + ":")
}

