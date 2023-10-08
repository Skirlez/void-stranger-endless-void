event_inherited()
global.selected_thing = 2
var ind = global.tile_mode ? tile_ind : object_ind
global.selected_placeable_num = ind
var tile = global.editor_object.current_list[ind]
global.display_object.switch_held_tile(new tile_with_state(tile))