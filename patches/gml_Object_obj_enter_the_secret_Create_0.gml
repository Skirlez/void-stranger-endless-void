// TARGET: LINENUMBER_REPLACE
// 50

// remove some weird code creating collision objects for some reason
if (false)

// TARGET: LINENUMBER
// 25
else {
	spr_enter_hurt = ev_get_stranger_down_sprite(global.stranger)
	spr_enter = ev_get_stranger_down_sprite(global.stranger)
	spr_drop = ev_get_stranger_down_sprite(global.stranger)
	drop_speed = 8
	alarm[1] = 60;
}