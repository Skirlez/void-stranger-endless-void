// This patch adds a case for the pack editor room, so the ambience doesn't play there if music isn't playing.
// TARGET: LINENUMBER
// 136
case rm_ev_pack_editor:
    scr_stop_ambience(true, 0)
    global.ambience_shutdown = true
    exceptions = true
    break;