event_inherited()
if (lvl == noone)
	exit
var str = export_level(lvl);
clipboard_set_text(str)
ev_notify("Copied to clipboard!")

