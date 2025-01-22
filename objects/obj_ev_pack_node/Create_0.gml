/*
This object represents almost all nodes in the pack editor.
I say almost all nodes, because displays are also nodes.
Due to gamemaker not providing any sort of way to inherit from multiple objects,
or any way to make a "trait" or an "interface" of any way, we can't have display
inherit from this object.

Most of the node logic is in the node_instance functions so it can be used by display objects.
*/

node_instance_setup(-1, 0, 0)

spin_time_h = 0;
spin_time_v = 0;
spin_h = 0
spin_v = 0
image_speed = 0.1
animate = true

