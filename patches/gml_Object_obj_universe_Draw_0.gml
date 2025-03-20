// TARGET: LINENUMBER
// 9

// Prevent universe object from drawing itself if not in a level, or if the level's theme isn't universe
if !ev_is_room_gameplay(room)
    exit
if !ev_level_is_universe_theme(global.level)
    exit