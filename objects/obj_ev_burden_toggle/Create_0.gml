image_speed = 0

if global.stranger == 2
    burdens_sprite = asset_get_index("spr_items_cif")
else if global.stranger == 4
    burdens_sprite = asset_get_index("spr_items_special")
else
    burdens_sprite = asset_get_index("spr_items")
stackrod_sprite = asset_get_index("spr_voidrod_icon2")

snd = asset_get_index("snd_ev_togglebox_click")