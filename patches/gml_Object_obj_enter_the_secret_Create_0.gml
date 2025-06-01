// TARGET: LINENUMBER_REPLACE
// 50

// spawnpoint has its own code for creating collision objects for where there aren't pits.
// usually done by the player in the room start event, but this object creates the player with a few seconds delay,
// so room start doesn't trigger. this is an issue because it starts creating collision as soon as it is placed by EV,
// and by that point it has only placed everything up and to the left of this object, so it creates collision
// everywhere else.

// fixed by executing gml_Object_obj_game_Alarm_5 manually after the level is created, which also does this,
// and disabling the player's room start collision creation code.
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