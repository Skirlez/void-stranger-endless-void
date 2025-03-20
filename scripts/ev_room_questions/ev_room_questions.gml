
function ev_room_should_play_ambience(rm){
	return (rm != global.pack_editor_room)
}
function ev_is_room_gameplay(rm){
	return (rm == global.level_room || rm == global.pack_level_room)
}
// this is here for gml_Object_obj_universe_Draw_0, as enums like level_themes don't exist during merge
function ev_level_is_universe_theme(lvl){
	return lvl.theme == level_themes.universe;
}