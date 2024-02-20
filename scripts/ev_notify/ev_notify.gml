
function ev_notify(txt, spd = 6){
	static obj = asset_get_index("obj_ev_notification")
	instance_destroy(obj)
	var i = instance_create_layer(5, -30, "Notifications", obj)
	i.txt = txt
	i.vspeed = spd

}