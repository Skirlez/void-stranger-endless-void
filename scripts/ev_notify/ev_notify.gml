
function ev_notify(txt, spd = 4){
	static obj = asset_get_index("obj_ev_notification")
	instance_destroy(obj)
	var i = instance_create_layer(5, 0, "EditorObject", obj)
	i.txt = txt
	i.vspeed = spd

}