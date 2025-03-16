function ev_room_should_play_ambience(rm){
	return (rm != global.pack_editor_room)
}
function ev_is_room_gameplay(rm){
	return (rm == global.level_room || rm == global.pack_level_room)
}