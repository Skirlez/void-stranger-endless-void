// TARGET: REPLACE
// Make bee statues clear the EV level instead of vanilla behavior
if (room == rm_ev_level) {
	ev_clear_level()
}
else if (room == rm_ev_pack_level) {
	// TODO: Send player to appropriate place in pack
	ev_exit_number = 0
	ev_clear_pack_level()
}
instance_destroy()