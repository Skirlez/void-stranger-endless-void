global.selected_thing = 2
global.selected_placeable_num = num

var list = (global.tile_mode) ? global.editor_object.tiles_list : global.editor_object.objects_list
var tile = list[global.selected_placeable_num]
global.display_object.switch_held_tile(new tile_with_state(tile))