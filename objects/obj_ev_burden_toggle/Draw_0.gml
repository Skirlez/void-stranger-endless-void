draw_self()
if burden_ind != burden_stackrod 
	draw_sprite_part(burdens_sprite, 0, 16 + burden_ind * 16, 0, 16, 16, x - 8, y + 8)

else 
	draw_sprite(stackrod_sprite, 1, x - 8, y + 8)
