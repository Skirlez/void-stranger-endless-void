node_instance.lvl.bount = int64_safe(bount_textbox.txt, -1);

node_instance.lvl.name = name_textbox.txt
try_level_name_and_rename(node_instance.lvl, get_all_level_node_instances())

node_instance.name = node_instance.lvl.name;
node_instance.delete_cached_game_surface();
node_instance.delete_cached_name_surface();
event_inherited();
