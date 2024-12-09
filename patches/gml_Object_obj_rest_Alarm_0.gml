// TARGET: REPLACE
// This patch prevents you from talking to trees.
// The line talking = true is removed and the player's state is set to the default
if instance_exists(obj_player)
    obj_player.state = (0 << 0)
