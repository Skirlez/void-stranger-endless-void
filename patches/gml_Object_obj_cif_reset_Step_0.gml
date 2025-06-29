
// two patches to make cif statue send you to the root node in packs

// Cif's challenge check - we'll do it ourselves for tis' challenge, so remove it
// TARGET: LINENUMBER_REPLACE
// 79
if (false)

// Reset player data check. We're also doing this ourselves
// TARGET: LINENUMBER_REPLACE
// 64
ev_on_pack_cif_reset()
if (false)

// TARGET: LINENUMBER_REPLACE
// 39
// don't send back to B001
if (false)

