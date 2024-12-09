/// @description By Flan, ported by Metis

target_index = asset_get_index("spr_exit_target_b")
target_speed = 0
target2_speed = 0
target_frames = sprite_get_number(target_index) - 1
arrow_index = asset_get_index("spr_exit_target_b2")
arrow_speed = 0
arrow_frames = sprite_get_number(arrow_index) - 1
t_x[0] = -8
t_y[0] = -8
t_x[1] = 8
t_y[1] = -8
t_x[2] = -8
t_y[2] = 8
t_x[3] = 8
t_y[3] = 8
ttx = 0
tty = 0
target_state = 10
fade_away = false
counter = 0
target_color = 16777215
color_counter = 0
target_object = -4

tree_index = asset_get_index("obj_rest")