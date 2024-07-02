event_inherited()
if ((lvl == noone) || (highlighter == noone))
	return;
global.mouse_layer++
new_window(12, 6, asset_get_index("obj_ev_claim_window"), 
{
	layer_num: global.mouse_layer,
	lvl: lvl,
	highlighter: highlighter
})
