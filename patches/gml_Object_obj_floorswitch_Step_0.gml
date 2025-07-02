// TARGET: HEAD
// Fix crash (button expects player to always exist, not the case!)
if !instance_exists(obj_player)
	exit;