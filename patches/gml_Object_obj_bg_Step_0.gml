// TARGET: HEAD
// no_edge is set by EV when placing a tile to decide if it shouldn't draw the edge (like in cases with specific wall tiles that do have collision but it doesn't make sense for an edge to be under them)
if (no_edge) {
    sprite_index = spr_pit
    exit;
}