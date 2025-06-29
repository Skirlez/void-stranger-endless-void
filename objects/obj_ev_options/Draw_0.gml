var camera_y = camera_get_view_y(view_camera[0]);

var page_string = string(current_page + 1) + "/" + string(max_page + 1)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_color(c_white)
draw_set_font(global.ev_font)
draw_text_shadow(200, camera_y + 88 - 16, page_string)