// TARGET: REPLACE
surface_reset_target()
shader_set(shader_palette)
var sx = surface_get_width(application_surface)
var sy = surface_get_height(application_surface)
var mx = (224 / sx)
var my = (144 / sy)
draw_surface_ext(application_surface, 0, 0, mx, my, 0, c_white, 1)
shader_reset()