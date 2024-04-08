// TARGET: LINENUMBER
// 99
else if (variable_instance_exists(id, "ev_scaredeer")) {
    if place_meeting((x - e_move_x), (y - e_move_y), obj_obstacle_parent)
        e_state = 0
    else if place_meeting((x - e_move_x), (y - e_move_y), obj_npc_parent)
        e_state = 0
    else if place_meeting((x - e_move_x), (y - e_move_y), obj_pit)
    {
        x -= e_move_x
        y -= e_move_y
        e_state = 12
        cycle = 0
    }
    else
    {
        x -= e_move_x
        y -= e_move_y
        e_state = 0
    }
}
