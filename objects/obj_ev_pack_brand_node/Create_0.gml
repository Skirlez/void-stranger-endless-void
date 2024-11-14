event_inherited();

max_exits = 1
can_connect_to_me = false;

brand = int64(irandom_range(0, $FFFFFFFFF));

var brand_surface = surface_create(6, 6)
surface_set_target(brand_surface)
draw_clear(c_black)
ev_draw_brand(brand, 0, 0)
surface_reset_target()

brand_sprite = sprite_create_from_surface(brand_surface, 0, 0, 6, 6, false, false, 3, 3)
sprite_index = brand_sprite