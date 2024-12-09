if pack_editor_inst().selected_thing != pack_things.hammer || !instance_exists(node_inst) {
	instance_destroy(id)
	exit
}
event_inherited()