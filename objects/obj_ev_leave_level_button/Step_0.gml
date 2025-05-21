event_inherited()

var quill_exists = global.is_merged && instance_exists(asset_get_index("obj_quill"))

if mouse_y < 32 
	&& mouse_x < 48 
	&& !quill_exists 
	&& !global.pause 
	&& !(room == global.pack_level_room && !global.playtesting && !instance_exists(agi("obj_ev_pack_end")))
	&& !instance_exists(agi("obj_darkness_begins"))
	&& !instance_exists(agi("obj_darkness"))
{
	y = lerp(y, 14, 0.3)	
}	
else {
	y = lerp(y, ystart, 0.3)	
}