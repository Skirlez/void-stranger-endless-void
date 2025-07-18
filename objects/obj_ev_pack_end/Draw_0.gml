draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(global.ev_font)

draw_text(224 / 2, stats_title_y, "Stats")
draw_text(224 / 2, you_win_y, "Pack cleared!")

for (var i = 0; i < array_length(stat_texts); i++) {
	draw_set_halign(fa_left)
	draw_text(stat_texts_x[i], get_stat_height(i), stat_texts[i] + ":")
	draw_set_halign(fa_right)
	draw_text(stats_x_right, stat_values_y[i], stat_values[i])
}

