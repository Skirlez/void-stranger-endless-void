event_inherited()
image_speed = 0
burdens_sprite = asset_get_index("spr_items")
switch burden_ind
{
	case 2:
		if global.blade_style != 2 burdens_sprite = ev_get_burden_sprite(global.blade_style)
		else burdens_sprite = asset_get_index("spr_ev_items_lev")   		
		break
	case 1:
		burdens_sprite = ev_get_burden_sprite(global.wings_style)
		break
	case 0:
		burdens_sprite = ev_get_burden_sprite(global.memory_style)
		break
	default:
		burdens_sprite = asset_get_index("spr_items")
		break
}
stackrod_sprite = asset_get_index("spr_voidrod_icon2")
swapper_sprite = asset_get_index("spr_ev_swapper")

snd = asset_get_index("snd_ev_togglebox_click")