image_alpha = max(0, (hspeed * hspeed + vspeed * vspeed) / 9)
if image_alpha == 0
	instance_destroy(id)
