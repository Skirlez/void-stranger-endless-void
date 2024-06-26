// TARGET: REPLACE
sprite_index = spr_void_wings_dissipate
image_speed = 0
wing_dir = 0
switch global.wings_style
{
    case 4:
        sprite_index = spr_ev_void_wings_dissipate_two
        break
    case 3:
        sprite_index = spr_ev_void_wings_dissipate_one
        break
    case 2:
        sprite_index = spr_ev_void_wings_dissipate_lev
        break
    case 1:
        sprite_index = spr_void_wings_dissipate_cif
        break
    default:
        sprite_index = spr_void_wings_dissipate
        break
}

wing_frames = (sprite_get_number(sprite_index) - 1)
