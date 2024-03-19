update()
var ind = global.tile_mode ? tile_ind : object_ind
var tile = global.editor_instance.current_list[ind]
selected = (global.selected_thing == 2 && tile == global.display_object.held_tile_state.tile)

event_inherited()

if keyboard_check_pressed(ord(string(num + 1))) && !selected && window == noone && !layer_has_instance("Windows", asset_get_index("obj_ev_window"))
	event_user(0)	
