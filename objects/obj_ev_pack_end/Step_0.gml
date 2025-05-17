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
			you_win_y = lerp(you_win_y, 18, 0.1)
			stats_text_y = lerp(stats_text_y, 35, 0.1)
			for (var i = 0; i < stats_level; i++) {
				stats_x[i] = lerp(stats_x[i], stats_final_x, 0.1)
			}
			if stats_level < 5 {
				stats_delay--;
				if stats_delay == 0 {
					stats_level++;
					stats_delay = 25;
				}
			}
			break;
	}
}