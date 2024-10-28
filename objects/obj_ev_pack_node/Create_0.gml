/*
This object represents almost all nodes in the pack editor.
I say almost all nodes, because displays are also nodes.
Due to gamemaker not providing any sort of way to inherit from multiple objects,
or any way to make a "trait" or an "interface" of any way, we can't have display
inherit from this object.

Although it is not enforced by anything, displays should all have the same variables as nodes,
and can be effectively treated as such.
*/
center_x = x;
center_y = y;
mouse_moving = false;
connecting_exit = false;
exit_instances = []
max_exits = 1;
can_connect_to_me = true;

spin_time_h = 0;
spin_time_v = 0;
image_speed = 0.1
animate = true

