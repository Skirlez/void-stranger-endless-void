// TARGET: HEAD
// Make secret exits clear the EV level instead of vanilla behavior
if (room == rm_ev_level) {
	ev_clear_level()
	exit
}
else if (room == rm_ev_pack_level) {
	ev_clear_pack_level()
	exit
}