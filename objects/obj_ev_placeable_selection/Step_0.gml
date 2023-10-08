update()
var ind = global.tile_mode ? tile_ind : object_ind
selected = (global.selected_thing == 2 && ind == global.selected_placeable_num)
event_inherited()