// remove check that places collision where there are walls. EV calls gml_Object_obj_game_Alarm_5 to do this.
// TARGET: LINENUMBER_REPLACE
// 185
if (false)

// because the patch above makes some local variables unused, their declaration is pushed to the top of the file,
// moving all the numbers below up by one. i swear i am going to rewrite this patching system

// remove checks that create/destroy the universe object (not needed)
// TARGET: LINENUMBER_REPLACE
// 148
if (false)

// TARGET: LINENUMBER_REPLACE
// 115
if (false)