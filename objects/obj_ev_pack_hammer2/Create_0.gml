dragged = false;


enum hammer_states {
	idle,
	dragged,
	animation
}

state = hammer_states.idle;

judging_display = noone;
judge_animation_timer = 0;