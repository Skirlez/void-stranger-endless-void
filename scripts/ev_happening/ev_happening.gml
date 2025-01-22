/* Happenings
A happening object represents an happening. Instances may create happenings, and anyone can then subscribe
to the happening, supplying a callback function. When the happening is triggered, the callbacks will all be called.

Happenings may pass a struct argument to every callback function. 
Be sure to check the .trigger calls to find out if it's relevant to you.
Make sure to not modify it. It might get passed around to other callbacks.

To keep this system easily searchable, please don't call your happening objects something generic,
like "happening". We want to easily be able to search for "variable_name".subscribe, so a generic name
makes this difficult
(Even in cases where you have an obj_that_does_a_thing, call the variable thing_it_does instead of happening.
While it might look like it's still easily searchable, like obj_that_does_a_thing.happening, objects
may be accessed in different ways, so that prefix doesn't always exist (and pretty much never does in EV))

Happenings may be optionally registered (and created) with register_happening(name). 
You can get the happening struct with get_happening(name).
This is for cases where no instance should be responsible for this happening and thus hold the struct.
It also works in cases where it's annoying to obtain a reference to the object holding the happening.

You are allowed to subscribe more than once to a happening with the same function. It will do nothing.

*/

function ev_happening() constructor {
	self.callbacks = []
	function subscribe(callback) {
		if (ev_array_contains(callback))
			return;
		array_push(callbacks, callback)
	}
	function unsubscribe(callback) {
		for (var i = 0; i < array_length(callbacks); i++) {
			if (callbacks[i] == callback) {
				array_delete(callbacks, i, 1)
				return;
			}
		}
	}
	
	function trigger(struct) {
		for (var i = 0; i < array_length(callbacks); i++) {
			callbacks[i](struct);
		}
	}
}

function register_happening(name) {
	var happening = new ev_happening();
	ds_map_add(global.happenings, name, happening)
	return happening;
}
function get_happening(name) {
	return ds_map_find_value(global.happenings, name);
}