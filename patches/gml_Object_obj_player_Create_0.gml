// TARGET: STRING
scr_steam_achievement_get()> { /* do nothing*/ }
// TARGET: STRING
scr_steam_achievement_clear()> { /* do nothing*/ }

// TARGET: LINENUMBER
// 98
if global.level.burdens[1] 
	spr_wings = 2561
if global.level.burdens[2] 
	spr_blade = 1685
// TARGET: TAIL
if (global.stranger == 5) {
    spr_m_right = spr_prin_wed_r
    spr_m_up = spr_prin_wed_u
    spr_m_left = spr_prin_wed_l
    spr_m_down = spr_ev_lily_down
    spr_blink = spr_ev_lily_blink
    spr_hurt = spr_ev_lily_hit
    spr_sleep = 53
    spr_wakey = 54
    spr_enter = 45
    spr_item = spr_ev_lily_item_get
    spr_a_right = spr_ev_lily_attack_r
    spr_a_up = spr_ev_lily_attack_u
    spr_a_left = spr_ev_lily_attack_l
    spr_a_down = spr_ev_lily_attack_d
	voice = snd_princess
    wake_speed = 6
}
else if (global.stranger == 6) {
    spr_m_right = spr_ev_ninnie
    spr_m_up = spr_ev_ninnie
    spr_m_left = spr_ev_ninnie
    spr_m_down = spr_ev_ninnie
    spr_blink = spr_ev_ninnie
    spr_hurt = spr_ev_ninnie
    spr_sleep = 53
    spr_wakey = 54
    spr_enter = 45
    spr_item = spr_ev_ninnie
    spr_a_right = spr_ev_ninnie
    spr_a_up = spr_ev_ninnie
    spr_a_left = spr_ev_ninnie
    spr_a_down = spr_ev_ninnie
    wake_speed = 6
}