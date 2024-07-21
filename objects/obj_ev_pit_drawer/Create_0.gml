/* This object's one and only purpose is so that wall tiles will draw the
pit sprite if they have glass below them. Woah!!!
Usually, the pit object does this, but it doesn't exist when there's a glass tile there instead.
So this object exists to do it in that specific case.
It also draws the pit when there isn't a glass tile, meaning it could get drawn twice, but we do not care.
*/

sprite_index = asset_get_index("spr_floor")

/* 
These pits are drawn at nearly the lowest layer ("More_Pits"), so they'll be obstructed by anything 
above them like walls (which is good), or they'll be seen through transparent floors like glass (also good).
However, very annoyingly, EX wall tiles, and DIS edge tiles, can be transparent, when we actually want them
to obscure the pit. so we need to explicitly not draw the pit if there exists a tile of that type at our 
position. */
tilemaps_to_check = [global.wall_tilemaps[wall_types.ex], global.edge_tilemaps[edge_types.dis]]
