// TARGET: REPLACE
// I really didn't feel like sniping the areas I had to add this in...
hide_inventory = false
gameover = false
continue_game = false
void_ending = false
inventory_font = 4
rcds_ms = 0
cell_size = 16
inv_slots = 5
inv_slots_width = 4
inv_slots_height = 1
x_buffer = 8
y_buffer = 0
zeros = 4
inv_box_x1 = 0
inv_box_y1 = global.game_height - cell_size
inv_box_x2 = global.game_width
inv_box_y2 = global.game_height
b_col = 16777215
inv_UI_width = cell_size * 3
inv_UI_heigh = cell_size
info_x = inv_box_x1
info_y = inv_box_y1
spr_inv_items = spr_items
spr_inv_items_columns = sprite_get_width(spr_inv_items) / cell_size
spr_inv_items_rows = sprite_get_height(spr_inv_items) / cell_size
slots_x = info_x + 64
slots_y = info_y
ds_player_info = ds_grid_create(23, 4)
ds_grid_set(ds_player_info, 0, 0, "HP")
ds_grid_set(ds_player_info, 0, 1, 0)
ds_grid_set(ds_player_info, 0, 2, "B")
ds_grid_set(ds_player_info, 0, 3, "Voidrod")
ds_grid_set(ds_player_info, 1, 0, 10)
ds_grid_set(ds_player_info, 1, 1, 0)
ds_grid_set(ds_player_info, 1, 2, 1)
ds_grid_set(ds_player_info, 1, 3, 0)
ds_grid_set(ds_player_info, 2, 0, 0)
ds_grid_set(ds_player_info, 2, 1, 0)
ds_grid_set(ds_player_info, 2, 2, 0)
ds_grid_set(ds_player_info, 2, 3, 0)
ds_grid_set(ds_player_info, 3, 0, 0)
ds_grid_set(ds_player_info, 3, 1, 0)
ds_grid_set(ds_player_info, 3, 2, 0)
ds_grid_set(ds_player_info, 3, 3, 0)
ds_grid_set(ds_player_info, 4, 0, 0)
ds_grid_set(ds_player_info, 4, 1, 0)
ds_grid_set(ds_player_info, 4, 2, 0)
ds_grid_set(ds_player_info, 4, 3, 0)
ds_grid_set(ds_player_info, 5, 0, 0)
ds_grid_set(ds_player_info, 5, 1, 0)
ds_grid_set(ds_player_info, 5, 2, 0)
ds_grid_set(ds_player_info, 5, 3, 0)
ds_grid_set(ds_player_info, 6, 0, "")
ds_grid_set(ds_player_info, 6, 1, 0)
ds_grid_set(ds_player_info, 6, 2, 0)
ds_grid_set(ds_player_info, 6, 3, 0)
ds_grid_set(ds_player_info, 7, 0, 0)
ds_grid_set(ds_player_info, 7, 1, 0)
ds_grid_set(ds_player_info, 7, 2, 0)
ds_grid_set(ds_player_info, 7, 3, 0)
ds_grid_set(ds_player_info, 8, 0, 0)
ds_grid_set(ds_player_info, 8, 1, 0)
ds_grid_set(ds_player_info, 8, 2, 0)
ds_grid_set(ds_player_info, 8, 3, 0)
ds_grid_set(ds_player_info, 9, 0, 0)
ds_grid_set(ds_player_info, 9, 1, 0)
ds_grid_set(ds_player_info, 9, 2, date_current_datetime())
ds_grid_set(ds_player_info, 9, 3, date_current_datetime())
ds_grid_set(ds_player_info, 10, 0, 0)
ds_grid_set(ds_player_info, 10, 1, 0)
ds_grid_set(ds_player_info, 10, 2, 4)
ds_grid_set(ds_player_info, 10, 3, 0)
ds_grid_set(ds_player_info, 11, 0, 0)
ds_grid_set(ds_player_info, 11, 1, 0)
ds_grid_set(ds_player_info, 11, 2, 0)
ds_grid_set(ds_player_info, 11, 3, 0)
ds_grid_set(ds_player_info, 12, 0, false)
ds_grid_set(ds_player_info, 12, 1, false)
ds_grid_set(ds_player_info, 12, 2, false)
ds_grid_set(ds_player_info, 12, 3, false)
ds_grid_set(ds_player_info, 13, 0, 0)
ds_grid_set(ds_player_info, 13, 1, 0)
ds_grid_set(ds_player_info, 13, 2, 0)
ds_grid_set(ds_player_info, 13, 3, 0)
ds_grid_set(ds_player_info, 14, 0, 0)
ds_grid_set(ds_player_info, 14, 1, 0)
ds_grid_set(ds_player_info, 14, 2, 0)
ds_grid_set(ds_player_info, 14, 3, 0)
ds_grid_set(ds_player_info, 15, 0, 0)
ds_grid_set(ds_player_info, 15, 1, 0)
ds_grid_set(ds_player_info, 15, 2, 0)
ds_grid_set(ds_player_info, 15, 3, 0)
ds_grid_set(ds_player_info, 16, 0, 0)
ds_grid_set(ds_player_info, 16, 1, 0)
ds_grid_set(ds_player_info, 16, 2, 0)
ds_grid_set(ds_player_info, 16, 3, 0)
ds_grid_set(ds_player_info, 17, 0, 0)
ds_grid_set(ds_player_info, 17, 1, 0)
ds_grid_set(ds_player_info, 17, 2, 0)
ds_grid_set(ds_player_info, 17, 3, 0)
ds_grid_set(ds_player_info, 18, 0, 0)
ds_grid_set(ds_player_info, 18, 1, 0)
ds_grid_set(ds_player_info, 18, 2, 0)
ds_grid_set(ds_player_info, 18, 3, 0)
ds_grid_set(ds_player_info, 19, 0, 0)
ds_grid_set(ds_player_info, 19, 1, 0)
ds_grid_set(ds_player_info, 19, 2, "1111111111111111110000001111111100000011111111000000111111110000001111111100000011111111000000111111111111111111")
ds_grid_set(ds_player_info, 19, 3, 0)
ds_grid_set(ds_player_info, 20, 0, 0)
ds_grid_set(ds_player_info, 20, 1, 0)
ds_grid_set(ds_player_info, 20, 2, 0)
ds_grid_set(ds_player_info, 20, 3, 0)
ds_grid_set(ds_player_info, 21, 0, 0)
ds_grid_set(ds_player_info, 21, 1, 0)
ds_grid_set(ds_player_info, 21, 2, 0)
ds_grid_set(ds_player_info, 21, 3, 0)
ds_grid_set(ds_player_info, 22, 0, 0)
ds_grid_set(ds_player_info, 22, 1, 0)
ds_grid_set(ds_player_info, 22, 2, 0)
ds_grid_set(ds_player_info, 22, 3, 0)
ds_equipment = ds_grid_create(2, inv_slots)
var yy = 0
repeat inv_slots
{
    ds_grid_set(ds_equipment, 0, yy, 0)
    ds_grid_set(ds_equipment, 1, yy, 0)
    yy += 1
}
ds_album = ds_grid_create(11, 2)
ds_grid_set(ds_album, 0, 0, 0)
ds_grid_set(ds_album, 0, 1, 0)
ds_grid_set(ds_album, 1, 0, 0)
ds_grid_set(ds_album, 1, 1, 2)
ds_grid_set(ds_album, 2, 0, 0)
ds_grid_set(ds_album, 2, 1, 4)
ds_grid_set(ds_album, 3, 0, 0)
ds_grid_set(ds_album, 3, 1, 6)
ds_grid_set(ds_album, 4, 0, 0)
ds_grid_set(ds_album, 4, 1, 8)
ds_grid_set(ds_album, 5, 0, 0)
ds_grid_set(ds_album, 5, 1, 12)
ds_grid_set(ds_album, 6, 0, 0)
ds_grid_set(ds_album, 6, 1, 16)
ds_grid_set(ds_album, 7, 0, 0)
ds_grid_set(ds_album, 7, 1, 24)
ds_grid_set(ds_album, 8, 0, 0)
ds_grid_set(ds_album, 8, 1, 1)
ds_grid_set(ds_album, 9, 0, 0)
ds_grid_set(ds_album, 9, 1, 55)
ds_grid_set(ds_album, 10, 0, 0)
ds_grid_set(ds_album, 10, 1, 1)
ds_tokens = ds_grid_create(1, 7)
ds_grid_set(ds_tokens, 0, 0, 0)
ds_grid_set(ds_tokens, 0, 1, "")
ds_grid_set(ds_tokens, 0, 2, 0)
ds_grid_set(ds_tokens, 0, 3, 0)
ds_grid_set(ds_tokens, 0, 4, 0)
ds_grid_set(ds_tokens, 0, 5, 0)
ds_grid_set(ds_tokens, 0, 6, 0)
ds_jewels = ds_grid_create(1, 2)
ds_grid_set(ds_jewels, 0, 0, 0)
ds_grid_set(ds_jewels, 0, 1, "")
ds_cheats = ds_grid_create(2, 8)
ds_grid_set(ds_cheats, 0, 0, 0)
ds_grid_set(ds_cheats, 0, 1, 0)
ds_grid_set(ds_cheats, 0, 2, 0)
ds_grid_set(ds_cheats, 0, 3, 0)
ds_grid_set(ds_cheats, 0, 4, 0)
ds_grid_set(ds_cheats, 0, 5, 0)
ds_grid_set(ds_cheats, 0, 6, 0)
ds_grid_set(ds_cheats, 0, 7, 0)
ds_grid_set(ds_cheats, 1, 0, "Infinity")
ds_grid_set(ds_cheats, 1, 1, "Memory")
ds_grid_set(ds_cheats, 1, 2, "Blade")
ds_grid_set(ds_cheats, 1, 3, "Wings")
ds_grid_set(ds_cheats, 1, 4, "Lillie")
ds_grid_set(ds_cheats, 1, 5, "Cif")
ds_grid_set(ds_cheats, 1, 6, "0stRanger")
ds_grid_set(ds_cheats, 1, 7, "Music")
ds_rcrds = ds_list_create()
ds_list_set(ds_rcrds, 0, 0)
ds_list_set(ds_rcrds, 1, 0)
ds_list_set(ds_rcrds, 2, 0)
ds_list_set(ds_rcrds, 3, 0)
ds_list_set(ds_rcrds, 4, 0)
ds_list_set(ds_rcrds, 5, 0)
ds_list_set(ds_rcrds, 6, 0)
ds_list_set(ds_rcrds, 7, 0)
ds_list_set(ds_rcrds, 8, 0)
ds_list_set(ds_rcrds, 9, 0)
ds_list_set(ds_rcrds, 10, 0)
ds_list_set(ds_rcrds, 11, 0)
ds_list_set(ds_rcrds, 12, 0)
ds_list_set(ds_rcrds, 13, 0)
ds_ee = ds_list_create()
ds_list_set(ds_ee, 0, 0)
ds_list_set(ds_ee, 1, 0)
ds_list_set(ds_ee, 2, 0)
ds_list_set(ds_ee, 3, 0)
ds_list_set(ds_ee, 4, 0)
ds_list_set(ds_ee, 5, 0)
ds_list_set(ds_ee, 6, 0)
ds_tree = ds_list_create()
ds_list_set(ds_tree, 0, 0)
ds_list_set(ds_tree, 1, 0)
ds_list_set(ds_tree, 2, 0)
ds_list_set(ds_tree, 3, 0)
ds_list_set(ds_tree, 4, 0)
ds_list_set(ds_tree, 5, 0)
ds_list_set(ds_tree, 6, 0)
ds_list_set(ds_tree, 7, 0)
ds_list_set(ds_tree, 8, 0)
bbtrp_count = 0
glut_count = 0
inventory_draw = true
ds_monlist = ds_list_create()
ds_list_add(ds_monlist, "Tip number 0", "Tip number 1", "Tip number 2", "Tip number 3", "Tip number 4", "Tip number 5", "Tip number 6", "Tip number 7", "Tip number 8")
ds_mon_location = ds_list_create()
ds_list_add(ds_mon_location, 0, 0, 0, 0, 0)
ds_window = ds_list_create()
ds_list_add(ds_window, 0, 0, 0, 0, 0, 0)
ds_hlis = ds_grid_create(4, 10)
ds_grid_set(ds_hlis, 0, 0, 1991419)
ds_grid_set(ds_hlis, 0, 1, 900000)
ds_grid_set(ds_hlis, 0, 2, 800000)
ds_grid_set(ds_hlis, 0, 3, 700000)
ds_grid_set(ds_hlis, 0, 4, 600000)
ds_grid_set(ds_hlis, 0, 5, 500000)
ds_grid_set(ds_hlis, 0, 6, 400000)
ds_grid_set(ds_hlis, 0, 7, 300000)
ds_grid_set(ds_hlis, 0, 8, 200000)
ds_grid_set(ds_hlis, 0, 9, 100000)
ds_grid_set(ds_hlis, 1, 0, "1111111111111111111100011111111110100111111111100110111111110110011111111110010111111111100011111111111111111111")
ds_grid_set(ds_hlis, 1, 1, "1111111111111111111000011111111100011011111111011111111111111111101111111101100011111111100001111111111111111111")
ds_grid_set(ds_hlis, 1, 2, "1111111111111111111100111111111100110011111111110001111111111110111111111111011111111111110011111111111111111111")
ds_grid_set(ds_hlis, 1, 3, "1111111111111111110000011111111100110011111111111001111111111001111111111111001111111111111001111111111111111111")
ds_grid_set(ds_hlis, 1, 4, "1111111111111111111000111111111101110111111111110011111111110111011111111110001111111111111000111111111111111111")
ds_grid_set(ds_hlis, 1, 5, "1111111111111111111011011111111100110011111111101101111111111100111111111110110111111111110011111111111111111111")
ds_grid_set(ds_hlis, 1, 6, "1111111111111111110011001111111100110011111111100100111111111100011111111111110011111111111100111111111111111111")
ds_grid_set(ds_hlis, 1, 7, "1111111111111111111000111111111100111111111111100100111111110011001111111100000111111111110011111111111111111111")
ds_grid_set(ds_hlis, 1, 8, "1111111111111111111100011111111101010111111111010010111111111010001111111110010011111111110001111111111111111111")
ds_grid_set(ds_hlis, 1, 9, "1111111111111111110000001111111100000011111111000000111111110000001111111100000011111111000000111111111111111111")
ds_grid_set(ds_hlis, 2, 0, "ZZZ")
ds_grid_set(ds_hlis, 2, 1, "ZZZ")
ds_grid_set(ds_hlis, 2, 2, "ZZZ")
ds_grid_set(ds_hlis, 2, 3, "ZZZ")
ds_grid_set(ds_hlis, 2, 4, "ZZZ")
ds_grid_set(ds_hlis, 2, 5, "ZZZ")
ds_grid_set(ds_hlis, 2, 6, "ZZZ")
ds_grid_set(ds_hlis, 2, 7, "ZZZ")
ds_grid_set(ds_hlis, 2, 8, "ZZZ")
ds_grid_set(ds_hlis, 2, 9, "ZZZ")
ds_grid_set(ds_hlis, 3, 0, 0)
ds_grid_set(ds_hlis, 3, 1, 0)
ds_grid_set(ds_hlis, 3, 2, 0)
ds_grid_set(ds_hlis, 3, 3, 0)
ds_grid_set(ds_hlis, 3, 4, 0)
ds_grid_set(ds_hlis, 3, 5, 0)
ds_grid_set(ds_hlis, 3, 6, 0)
ds_grid_set(ds_hlis, 3, 7, 0)
ds_grid_set(ds_hlis, 3, 8, 0)
ds_grid_set(ds_hlis, 3, 9, 0)
ds_hlis2 = ds_grid_create(4, 10)
ds_grid_set(ds_hlis2, 0, 0, 2018928)
ds_grid_set(ds_hlis2, 0, 1, 25600)
ds_grid_set(ds_hlis2, 0, 2, 12800)
ds_grid_set(ds_hlis2, 0, 3, 6400)
ds_grid_set(ds_hlis2, 0, 4, 3200)
ds_grid_set(ds_hlis2, 0, 5, 1600)
ds_grid_set(ds_hlis2, 0, 6, 800)
ds_grid_set(ds_hlis2, 0, 7, 400)
ds_grid_set(ds_hlis2, 0, 8, 200)
ds_grid_set(ds_hlis2, 0, 9, 100)
ds_grid_set(ds_hlis2, 1, 0, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 1, 1, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 1, 2, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 1, 3, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 1, 4, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 1, 5, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 1, 6, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 1, 7, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 1, 8, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 1, 9, "1111111111111111111111111111111110110111111111011010111111110101101111111110110111111111111111111111111111111111")
ds_grid_set(ds_hlis2, 2, 0, "ZZZ")
ds_grid_set(ds_hlis2, 2, 1, "ZZZ")
ds_grid_set(ds_hlis2, 2, 2, "ZZZ")
ds_grid_set(ds_hlis2, 2, 3, "ZZZ")
ds_grid_set(ds_hlis2, 2, 4, "ZZZ")
ds_grid_set(ds_hlis2, 2, 5, "ZZZ")
ds_grid_set(ds_hlis2, 2, 6, "ZZZ")
ds_grid_set(ds_hlis2, 2, 7, "ZZZ")
ds_grid_set(ds_hlis2, 2, 8, "ZZZ")
ds_grid_set(ds_hlis2, 2, 9, "ZZZ")
ds_grid_set(ds_hlis2, 3, 0, 1)
ds_grid_set(ds_hlis2, 3, 1, 1)
ds_grid_set(ds_hlis2, 3, 2, 1)
ds_grid_set(ds_hlis2, 3, 3, 1)
ds_grid_set(ds_hlis2, 3, 4, 1)
ds_grid_set(ds_hlis2, 3, 5, 1)
ds_grid_set(ds_hlis2, 3, 6, 1)
ds_grid_set(ds_hlis2, 3, 7, 1)
ds_grid_set(ds_hlis2, 3, 8, 1)
ds_grid_set(ds_hlis2, 3, 9, 1)
ds_ver = ds_list_create()
ds_list_set(ds_ver, 0, "1.0.0")
ds_list_set(ds_ver, 1, "1.0.0")
ds_list_set(ds_ver, 2, "1.0.0")
ds_list_set(ds_ver, 3, "1.0.0")
ds_list_set(ds_ver, 4, "1.0.0")
ds_list_set(ds_ver, 5, "1.0.0")
ds_list_set(ds_ver, 6, "1.0.0")
ds_list_set(ds_ver, 7, "1.0.0")
ds_list_set(ds_ver, 8, "1.0.0")
ds_list_set(ds_ver, 9, "1.0.0")
ds_ver2 = ds_list_create()
ds_list_set(ds_ver2, 0, "1.0.0")
ds_list_set(ds_ver2, 1, "1.0.0")
ds_list_set(ds_ver2, 2, "1.0.0")
ds_list_set(ds_ver2, 3, "1.0.0")
ds_list_set(ds_ver2, 4, "1.0.0")
ds_list_set(ds_ver2, 5, "1.0.0")
ds_list_set(ds_ver2, 6, "1.0.0")
ds_list_set(ds_ver2, 7, "1.0.0")
ds_list_set(ds_ver2, 8, "1.0.0")
ds_list_set(ds_ver2, 9, "1.0.0")
ds_ccr = ds_list_create()
ds_list_set(ds_ccr, 0, 0)
ds_list_set(ds_ccr, 1, 0)
ds_list_set(ds_ccr, 2, 0)
ds_list_set(ds_ccr, 3, global.vs_version)
ds_list_set(ds_ccr, 4, global.vs_version)
ds_list_set(ds_ccr, 5, 0)
ds_list_set(ds_ccr, 6, irandom_range(1, 17))
