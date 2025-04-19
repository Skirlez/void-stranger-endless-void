/*
This object represents almost all nodes in the pack editor.
I say almost all nodes, because displays are also nodes.
Due to gamemaker not providing any sort of way to inherit from multiple objects,
or any way to make a "trait" or an "interface" of any way, we can't have display
inherit from this object.

Most of the node logic is in the node_instance functions so it can be used by display objects.
*/
node_instance_setup()