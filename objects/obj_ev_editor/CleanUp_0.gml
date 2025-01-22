ds_map_destroy(global.placeable_name_map)
ds_map_destroy(global.beaten_levels_map)
ds_map_destroy(global.level_key_map)
ds_map_destroy(global.key_level_map)
ds_map_destroy(global.happenings);

clean_struct_maps()
ds_map_destroy(global.struct_map_cleaner)
surface_free(spin_surface)