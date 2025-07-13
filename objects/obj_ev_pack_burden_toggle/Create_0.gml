event_inherited()
image_speed = 0
burdens_sprite = agi("spr_items")
switch burden_ind
{
	case 2:
		if global.blade_style != 2 burdens_sprite = ev_get_burden_sprite(global.blade_style)
		else burdens_sprite = agi("spr_ev_items_lev")   		
		break
	case 1:
		burdens_sprite = ev_get_burden_sprite(global.wings_style)
		break
	case 0:
		burdens_sprite = ev_get_burden_sprite(global.memory_style)
		break
	default:
		burdens_sprite = agi("spr_items")
		break
}
stackrod_sprite = agi("spr_voidrod_icon2")
swapper_sprite = agi("spr_ev_swapper")

snd = agi("snd_ev_togglebox_click")