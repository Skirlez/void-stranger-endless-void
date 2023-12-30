event_inherited()
// display only has a window managing it on the level select and not in the editor,
// so we know that this is for when it's been clicked in the level select
image_xscale = 0.8
image_yscale = 0.8

x = 0
xstart = x

y = 0
ystart = y 

global.mouse_layer = 1

with (asset_get_index("obj_ev_level_select"))
	destroy_displays(other.id)

instance_create_layer(0, 0, "Levels", asset_get_index("obj_ev_level_highlight"), {
	lvl : lvl	
})