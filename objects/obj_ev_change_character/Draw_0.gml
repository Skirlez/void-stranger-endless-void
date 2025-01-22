// Inherit the parent event
event_inherited();

draw_sprite(asset_get_index("spr_ev_swapper"),0, 112 - 70, y + 20)
draw_sprite_part_ext(ev_get_burden_sprite(global.memory_style), 0, 16, 0, 16, 16, 112 - 54, y + 20, 1, 1, image_blend, image_alpha)
draw_sprite_part_ext(ev_get_burden_sprite(global.wings_style), 0, 32, 0, 16, 16, 112 - 38, y + 20, 1, 1, image_blend, image_alpha)
if global.blade_style == 2 
	draw_sprite_part_ext(asset_get_index("spr_ev_items_lev"), 0, 48, 0, 16, 16, 112 - 22, y + 20, 1, 1, image_blend, image_alpha)
else
	draw_sprite_part_ext(ev_get_burden_sprite(global.blade_style), 0, 48, 0, 16, 16, 112 - 22, y + 20, 1, 1, image_blend, image_alpha)

