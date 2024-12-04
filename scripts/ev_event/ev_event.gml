/* Events
An event object represents an event. Instances may create events, and anyone can then subscribe
to the event, supplying a callback function. When the event is triggered, the callbacks will all be called.


To keep this system easily searchable, please don't call your event objects something generic,
like "event". We want to easily be able to search for "variable_name".subscribe, so a generic name
makes this difficult
(Even in cases where you have an obj_that_does_a_thing, call the variable thing_it_does instead of event.
While it might look like it's still easily searchable, like obj_that_does_a_thing.event, objects
may be accessed in different ways, so that prefix doesn't always exist (and pretty much never does in EV))

*/
function ev_event() constructor {
	self.callbacks = []
	function subscribe(callback) {
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