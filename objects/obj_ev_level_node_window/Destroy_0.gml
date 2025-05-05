node_instance.properties.level.bount = int64_safe(bount_textbox.txt, -1);
node_instance.properties.level.name = name_textbox.txt
try_level_name_and_rename(node_instance.properties.level, get_all_level_node_instances())

node_instance.sync_display_level();
event_inherited();
