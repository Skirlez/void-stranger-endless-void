update()
var ind = global.tile_mode ? tile_ind : object_ind
var tile = global.editor_instance.current_list[ind]
selected = (global.selected_thing == 2 && tile == global.display_object.held_tile_state.tile)
event_inherited()
