// TARGET: LINENUMBER
// 31
// Secret player drawing mode
if global.g_mode {
    var spin_h = (dsin(global.level_time * 0.3) + 1) / 2;
    var spin_v = (dcos(global.level_time * 0.5) + 1) / 2;
    ev_draw_cube(sprite_index, i_imageframe, (x + xslide), (y + yslide), 8, spin_h, spin_v)
}
else
    // normal line runs