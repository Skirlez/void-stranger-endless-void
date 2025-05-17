timer = 80
state = end_animation_states.start
enum end_animation_states {
	start,
	you_win,
	stats,
}

you_win_y = -20
stats_text_y = -20

stats_x = [-200, 424, -200, 424, -200]
stat_texts = ["Deaths", "Time spent", "Crystals collected", "Locusts collected", "Distinct rooms visited"]
stats_level = -1
stats_delay = 25

var lengths = [];
draw_set_font(global.ev_font)
for (var i = 0; i < array_length(stat_texts); i++) {
	array_push(lengths, string_width(stat_texts[i] + ":"))	
}
array_sort(lengths, false)

stats_final_x = floor(112 - lengths[0] / 2)