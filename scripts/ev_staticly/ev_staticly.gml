// This function will run the function only if it hasn't ran before.

global.static_hashset = ds_map_create();
function staticly(func) {
	/*
	That's stupid. why would you ever do it like that
	var stack = debug_get_callstack(2);
	var previous = stack[1]; // since we called this function
	var name = ev_string_split(previous, ":")[0];
	*/
	
	
	if ds_map_exists(global.static_hashset, func)
		return;
	ds_map_set(global.static_hashset, func, 1);
	func();
}

