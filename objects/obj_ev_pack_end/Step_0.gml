timer--;
if timer == 0 {
	switch (state) {
		case end_animation_states.start:
			state = end_animation_states.you_win;
			audio_play_sound(agi("snd_ex_jingle"), 10, false)
			timer = 150;
			break;
		case end_animation_states.you_win:
			state = end_animation_states.stats;
			break;
		case end_animation_states.stats:
			break;
	}
}
else {
	switch (state) {
		case end_animation_states.start:
			break;
		case end_animation_states.you_win:
			you_win_y = lerp(you_win_y, 72, 0.2)
			break;
		case end_animation_states.stats:
		case end_animation_states.done:
			you_win_y = lerp(you_win_y, 18, 0.1)
			stats_title_y = lerp(stats_title_y, 35, 0.1)
			for (var i = 0; i < stats_level; i++) {
				stat_texts_x[i] = lerp(stat_texts_x[i], stats_x_left, 0.1)
				stat_values_y[i] = lerp(stat_values_y[i], get_stat_height(i), 0.1)
			}
			if stats_level < 5 {
				stats_delay--;
				if stats_delay == 0 {
					stats_level++;
					stats_delay = 25;
				}
			}
			else if state != end_animation_states.done
				state = end_animation_states.done
			break;
	}
}