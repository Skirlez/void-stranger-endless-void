var iframes = sprite_get_number(sprite_index)
var func = asset_get_index("scr_music_strobe_integer")
if func == -1
	var i_imageframe = image_index
else
	i_imageframe = func(iframes)
draw_sprite(sprite_index, i_imageframe, x, y)
