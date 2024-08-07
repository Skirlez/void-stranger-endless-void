// TARGET: REPLACE
if (draw_infinity == 1)
{
    if (inf_dis != 256)
        inf_dis += 3
    if (inf_dir < 270)
    {
        inf_dir += inf_dir_add
        if (inf_dir_add != 1)
            inf_dir_add -= 0.05
    }
}
if global.pause
    return;
var iframes = 2
var i_shineloop = scr_music_strobe_integer(iframes)
shine_loop_sync = i_shineloop
if (shine_loop_sync == 1)
{
    if (shine_counter_add == 0)
    {
        shine_loop_counter++
        shine_counter_add = 1
    }
}
else if (shine_loop_sync == 0)
    shine_counter_add = 0
if (shine_loop_counter >= shine_loop_limit)
{
    with (obj_boulder)
        lev_glow = 1
    with (obj_glassfloor)
        shine_loop = 1
    with (obj_bombfloor)
        shine_loop = 1
    with (obj_floorswitch_glow)
        shine_loop = 1
    with (obj_deathfloor)
        shine_loop = 1
    with (obj_jewel_collect)
        shine_loop = 1
    with (obj_token_uncover)
        crack_state = 1
    with (obj_cc_medal)
        shine_phase = 1
    if (place_meeting(x, y, obj_copyfloor) && obj_player.state == (0 << 0))
        instance_create_depth(x, y, 80, obj_shock_fx)
    shine_loop_counter = 0
}
var _input_is_bufferable = 1
switch global.control
{
    case 0:
        var _holding = 0
        var _pressed = 0
        if (stored_input_index == -1)
        {
            if (!scr_input_check(button_priority))
            {
                if scr_input_check(0)
                    button_priority = 0
                if scr_input_check(1)
                    button_priority = 1
                if scr_input_check(2)
                    button_priority = 2
                if scr_input_check(3)
                    button_priority = 3
            }
        }
        if scr_input_check_pressed(0)
        {
            button_priority = 0
            _pressed = 1
        }
        if scr_input_check_pressed(1)
        {
            button_priority = 1
            _pressed = 1
        }
        if scr_input_check_pressed(2)
        {
            button_priority = 2
            _pressed = 1
        }
        if scr_input_check_pressed(3)
        {
            button_priority = 3
            _pressed = 1
        }
        if scr_input_check(button_priority)
            _holding = 1
        if (_pressed == 1 || _holding == 0)
            input_move_time_held = 0
        if (_holding == 1)
        {
            input_move_time_held++
            if (input_move_time_held >= 65535)
                input_move_time_held = 32768
        }
        if (obj_player.state == (13 << 0) || obj_player.state == (7 << 0) || obj_player.state == (14 << 0) || obj_player.state == (20 << 0))
            input_move_time_held = (-input_delay)
        if (global.movement == 0)
        {
            input_left_p = scr_input_check_pressed(0)
            input_right_p = scr_input_check_pressed(1)
            input_up_p = scr_input_check_pressed(2)
            input_down_p = scr_input_check_pressed(3)
            input_attack_p = scr_input_check_pressed(4)
        }
        else if (global.movement == 1)
        {
            input_left_p = scr_input_check_pressed(0)
            input_right_p = scr_input_check_pressed(1)
            input_up_p = scr_input_check_pressed(2)
            input_down_p = scr_input_check_pressed(3)
            input_attack_p = scr_input_check_pressed(4)
            if (!input_attack_p)
            {
                if (stored_input_index == -1)
                {
                    if (button_priority != -1)
                    {
                        if ((input_move_time_held % global.hold_speed) == 1)
                        {
                            switch button_priority
                            {
                                case 0:
                                    if (!input_left_p)
                                        _input_is_bufferable = 0
                                    input_left_p = 1
                                    break
                                case 1:
                                    if (!input_right_p)
                                        _input_is_bufferable = 0
                                    input_right_p = 1
                                    break
                                case 2:
                                    if (!input_up_p)
                                        _input_is_bufferable = 0
                                    input_up_p = 1
                                    break
                                case 3:
                                    if (!input_down_p)
                                        _input_is_bufferable = 0
                                    input_down_p = 1
                                    break
                            }

                        }
                    }
                }
            }
        }
        break
    case 1:
        if (global.movement == 0)
            input_mouse = mouse_check_button_pressed(mb_left)
        else if (global.movement == 1)
            input_mouse = mouse_check_button(mb_left)
        var imx = (mouse_x div 16) * 16 + 8
        var imy = (mouse_y div 16) * 16 + 8
        if ((imx < x && imy == y) || (imx > x && imy == y) || (imy > y && imx == x) || (imy < y && imx == x) || (imy == y && imx == x))
        {
            if (target_speed != 4)
                target_speed += 0.1
            else
                target_speed = 3
        }
        else
            target_speed = 3
        break
}

if (global.control == 0)
    button_pressed = (input_attack_p || input_left_p || input_right_p || input_up_p || input_down_p)
else if (global.control == 1)
    button_pressed = input_mouse
if (obj_player.state == (0 << 0) && regain_control == 1)
{
    if (stored_input_index == -1)
    {
    }
    else
    {
        switch stored_input_index
        {
            case 4:
                input_attack_p = 1
                break
            case 1:
                input_right_p = 1
                break
            case 0:
                input_left_p = 1
                break
            case 2:
                input_up_p = 1
                break
            case 3:
                input_down_p = 1
                break
        }

        show_debug_message("USED STORED INPUT")
        stored_input_index = -1
        buffer_counter = 0
    }
}
else if _input_is_bufferable
{
    if (obj_player.state == (10 << 0) || obj_player.state == (13 << 0) || obj_player.state == (11 << 0) || obj_player.state == (0 << 0) || obj_player.state == (7 << 0) || obj_player.state == (14 << 0) || obj_player.state == (20 << 0))
    {
        if input_attack_p
        {
            stored_input_index = 4
            buffer_counter = 0
        }
        else if input_right_p
        {
            stored_input_index = 1
            buffer_counter = 0
        }
        else if input_left_p
        {
            stored_input_index = 0
            buffer_counter = 0
        }
        else if input_up_p
        {
            stored_input_index = 2
            buffer_counter = 0
        }
        else if input_down_p
        {
            stored_input_index = 3
            buffer_counter = 0
        }
    }
}
if (stored_input_index != -1)
{
    buffer_counter++
    if (buffer_counter >= buffer_limit)
    {
        stored_input_index = -1
        buffer_counter = 0
    }
}
else
    buffer_counter = 0
if (obj_player.state == (0 << 0) && regain_control == 1)
{
    scr_lev_check(0, "Controls INTERRUPTING Lev check")
    if (state != (27 << 0))
    {
        if (input_attack_p == 1)
        {
            show_debug_message(string(input_attack_p))
            obj_player.state = (13 << 0)
            swordflash_counter = 0
            swapper_flash_counter = 0
            with (obj_exit_target)
                fade_away = 1
            with (obj_exit)
                exit_target_counter = 0
        }
        else if (input_right_p == 1)
        {
            obj_player.set_p_direction = 0
            obj_player.state = (11 << 0)
            swordflash_counter = 0
            swapper_flash_counter = 0
            with (obj_exit_target)
                fade_away = 1
            with (obj_exit)
                exit_target_counter = 0
        }
        else if (input_left_p == 1)
        {
            obj_player.set_p_direction = 2
            obj_player.state = (11 << 0)
            swordflash_counter = 0
            swapper_flash_counter = 0
            with (obj_exit_target)
                fade_away = 1
            with (obj_exit)
                exit_target_counter = 0
        }
        else if (input_up_p == 1)
        {
            obj_player.set_p_direction = 1
            obj_player.state = (11 << 0)
            swordflash_counter = 0
            swapper_flash_counter = 0
            with (obj_exit_target)
                fade_away = 1
            with (obj_exit)
                exit_target_counter = 0
        }
        else if (input_down_p == 1)
        {
            obj_player.set_p_direction = 3
            obj_player.state = (11 << 0)
            swordflash_counter = 0
            swapper_flash_counter = 0
            with (obj_exit_target)
                fade_away = 1
            with (obj_exit)
                exit_target_counter = 0
        }
        else if (input_mouse > 0)
        {
            imx = (mouse_x div 16) * 16 + 8
            imy = (mouse_y div 16) * 16 + 8
            if (imy == y && imx == x)
                obj_player.state = (13 << 0)
            else if (imx < x && imy == y)
            {
                obj_player.set_p_direction = 2
                obj_player.state = (11 << 0)
            }
            else if (imx > x && imy == y)
            {
                obj_player.set_p_direction = 0
                obj_player.state = (11 << 0)
            }
            else if (imy > y && imx == x)
            {
                obj_player.set_p_direction = 3
                obj_player.state = (11 << 0)
            }
            else if (imy < y && imx == x)
            {
                obj_player.set_p_direction = 1
                obj_player.state = (11 << 0)
            }
        }
    }
}
switch set_p_direction
{
    case 0:
        p_direction = 0
        break
    case 1:
        p_direction = 90
        break
    case 2:
        p_direction = 180
        break
    case 3:
        p_direction = 270
        break
}

p_move_x = lengthdir_x(spd, p_direction)
p_move_y = lengthdir_y(spd, p_direction)
if (state == (0 << 0))
{
    if (player_pause_countdown > 0)
    {
        player_pause_countdown--
        show_debug_message("Pausing shouldn't be allowed " + string(player_pause_countdown))
    }
    obj_pause.can_pause = 1
    aattack = 0
    prevdir = set_p_direction
    if (didyamuv == 1)
    {
        event_perform(ev_other, ev_user0)
        didyamuv = 0
    }
    with (obj_exit)
        event_perform(ev_other, ev_user2)
    if (ds_grid_get(obj_inventory.ds_equipment, 0, 2) == 3)
    {
        swordflash_counter++
        if (swordflash_counter >= 3)
        {
            if (place_meeting((x + p_move_x), (y + p_move_y), obj_enemy_parent) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_enemy_cm))))
            {
                with (obj_floor_memory3)
                    draw_swordflash = 1
            }
            else
            {
                with (obj_floor_memory3)
                    draw_swordflash = 0
            }
        }
    }
    if (swap_stage == 0 && ds_grid_get(obj_inventory.ds_equipment, 0, 4) == 1)
    {
        swapper_flash_counter++
        if (swapper_flash_counter >= 3)
        {
            var swapper_target = noone
            var test_i = 1
            var test_x = x
            var test_y = y
            while (test_i < 14)
            {
                test_x += p_move_x
                test_y += p_move_y
                if (place_meeting(test_x, test_y, obj_fakewall) || place_meeting(test_x, test_y, obj_text_parent) || place_meeting(test_x, test_y, obj_chest_parent) || place_meeting(test_x, test_y, obj_sealchest))
                    break
                else if (place_meeting(test_x, test_y, obj_obstacle_parent) && (!(place_meeting(test_x, test_y, obj_boulder))) && (!(place_meeting(test_x, test_y, obj_npc_talk))))
                    break
                else if (place_meeting(test_x, test_y, obj_enemy_parent) || place_meeting(test_x, test_y, obj_boulder) || place_meeting(test_x, test_y, obj_npc_talk))
                {
                    if (test_i >= 2)
                    {
                        with (instance_place(test_x, test_y, obj_enemy_parent))
                            swapper_target = id
                        with (instance_place(test_x, test_y, obj_boulder))
                            swapper_target = id
                        with (instance_place(test_x, test_y, obj_npc_talk))
                            swapper_target = id
                    }
                    break
                }
                else
                {
                    test_i++
                    continue
                }
            }
            if instance_exists(swapper_target)
            {
                var previous_target = -4
                with (obj_ev_swapper_target)
                {
                    if (!fade_away)
                    {
                        previous_target = target_object
                        if (target_object != swapper_target)
                            fade_away = true
                    }
                }
                if (previous_target != swapper_target)
                {
                    with (instance_create_depth(swapper_target.x, swapper_target.y, 80, obj_ev_swapper_target))
                        target_object = swapper_target
                }
                with (obj_ev_floor_memory_swapper)
                    draw_flash = 1
            }
            else
            {
                with (obj_ev_swapper_target)
                {
                    if (!fade_away)
                        fade_away = true
                }
                with (obj_ev_floor_memory_swapper)
                    draw_flash = 0
            }
        }
    }
    image_speed += 0.04
    switch set_p_direction
    {
        case 0:
            sprite_index = spr_m_right
            break
        case 1:
            sprite_index = spr_m_up
            break
        case 2:
            sprite_index = spr_m_left
            break
        case 3:
            sprite_index = spr_m_down
            break
    }

    scr_lev_check(0, "The Basic Lev Check")
}
else if (state == (11 << 0))
{
    if (input_move_time_held > 1)
        input_move_time_held = 1
    if place_meeting((x + p_move_x), (y + p_move_y), obj_collision)
    {
        if instance_exists(obj_enemy_cm)
            obj_enemy_cm.player_moved = 1
        with (instance_place((x + p_move_x), (y + p_move_y), obj_token_push))
            o_state = (10 << 0)
        with (instance_place((x + p_move_x), (y + p_move_y), obj_tot_mural))
            o_state = (10 << 0)
        var mural_knock = instance_place((x + p_move_x), (y + p_move_y), obj_mural)
        with (mural_knock)
        {
            if (inscription == 1 || inscription == 3 || inscription == 5)
            {
                if (mural_damage < 7)
                {
                    mural_damage += 1
                    var dust_mural = instance_create_layer(x, (y + 4), "Effects", obj_dust)
                    with (dust_mural)
                        fall_speed = 1
                }
            }
        }
        var chest_knock = instance_place((x + p_move_x), (y + p_move_y), obj_chest_parent)
        if (chest_knock != -4)
        {
            show_debug_message("knock knock")
            with (instance_place((x + p_move_x), (y + p_move_y), obj_chest_parent))
                secret_knock += 1
            with (instance_place(x, (y + 16), obj_chest_parent))
                secret_bknock += 1
            if (room == rm_secret_001 || room == rm_test2_049)
            {
                with (obj_chest_small)
                {
                    if (empty == 1)
                        audio_play_sound(snd_beginningbell, 1, 0)
                }
            }
        }
        audio_play_sound(snd_push_small, 1, 0)
        ds_grid_set(obj_inventory.ds_player_info, 3, 0, ((ds_grid_get(obj_inventory.ds_player_info, 3, 0)) + 1))
        ds_grid_set(obj_inventory.ds_player_info, 3, 2, ((ds_grid_get(obj_inventory.ds_player_info, 3, 2)) + 1))
        ds_list_set(obj_inventory.ds_rcrds, 1, ((ds_list_find_value(obj_inventory.ds_rcrds, 1)) + 1))
        state = (7 << 0)
    }
    else if place_meeting((x + p_move_x), (y + p_move_y), obj_boulder)
    {
        if instance_exists(obj_enemy_cm)
            obj_enemy_cm.player_moved = 1
        var b_push_x = p_move_x
        var b_push_y = p_move_y
        with (instance_place((x + p_move_x), (y + p_move_y), obj_boulder))
        {
            o_move_x += b_push_x
            o_move_y += b_push_y
            o_state = (10 << 0)
        }
        ds_grid_set(obj_inventory.ds_player_info, 3, 0, ((ds_grid_get(obj_inventory.ds_player_info, 3, 0)) + 1))
        ds_grid_set(obj_inventory.ds_player_info, 3, 2, ((ds_grid_get(obj_inventory.ds_player_info, 3, 2)) + 1))
        ds_list_set(obj_inventory.ds_rcrds, 1, ((ds_list_find_value(obj_inventory.ds_rcrds, 1)) + 1))
        state = (7 << 0)
    }
    else if place_meeting((x + p_move_x), (y + p_move_y), obj_demonlords_statue)
    {
        if instance_exists(obj_enemy_cm)
            obj_enemy_cm.player_moved = 1
        with (instance_place((x + p_move_x), (y + p_move_y), obj_demonlords_statue))
            o_state = (10 << 0)
        ds_grid_set(obj_inventory.ds_player_info, 3, 0, ((ds_grid_get(obj_inventory.ds_player_info, 3, 0)) + 1))
        ds_grid_set(obj_inventory.ds_player_info, 3, 2, ((ds_grid_get(obj_inventory.ds_player_info, 3, 2)) + 1))
        ds_list_set(obj_inventory.ds_rcrds, 1, ((ds_list_find_value(obj_inventory.ds_rcrds, 1)) + 1))
        state = (7 << 0)
    }
    else if place_meeting((x + p_move_x), (y + p_move_y), obj_npc_tail_void_hori)
    {
        if instance_exists(obj_enemy_cm)
            obj_enemy_cm.player_moved = 1
        with (instance_place((x + p_move_x), (y + p_move_y), obj_npc_tail_void_hori))
            o_state = (10 << 0)
        ds_grid_set(obj_inventory.ds_player_info, 3, 0, ((ds_grid_get(obj_inventory.ds_player_info, 3, 0)) + 1))
        ds_grid_set(obj_inventory.ds_player_info, 3, 2, ((ds_grid_get(obj_inventory.ds_player_info, 3, 2)) + 1))
        ds_list_set(obj_inventory.ds_rcrds, 1, ((ds_list_find_value(obj_inventory.ds_rcrds, 1)) + 1))
        state = (7 << 0)
    }
    else if place_meeting((x + p_move_x), (y + p_move_y), obj_npc_tail_void_vert)
    {
        if instance_exists(obj_enemy_cm)
            obj_enemy_cm.player_moved = 1
        with (instance_place((x + p_move_x), (y + p_move_y), obj_npc_tail_void_vert))
            o_state = (10 << 0)
        ds_grid_set(obj_inventory.ds_player_info, 3, 0, ((ds_grid_get(obj_inventory.ds_player_info, 3, 0)) + 1))
        ds_grid_set(obj_inventory.ds_player_info, 3, 2, ((ds_grid_get(obj_inventory.ds_player_info, 3, 2)) + 1))
        ds_list_set(obj_inventory.ds_rcrds, 1, ((ds_list_find_value(obj_inventory.ds_rcrds, 1)) + 1))
        state = (7 << 0)
    }
    else if place_meeting((x + p_move_x), (y + p_move_y), obj_npc_talk)
    {
        if instance_exists(obj_enemy_cm)
            obj_enemy_cm.player_moved = 1
        var n_push_x = p_move_x
        var n_push_y = p_move_y
        with (instance_place((x + p_move_x), (y + p_move_y), obj_npc_talk))
        {
            o_move_x += n_push_x
            o_move_y += n_push_y
            o_state = (10 << 0)
        }
        with (instance_place((x + p_move_x), (y + p_move_y), obj_rest))
            counter = 0
        ds_grid_set(obj_inventory.ds_player_info, 3, 0, ((ds_grid_get(obj_inventory.ds_player_info, 3, 0)) + 1))
        ds_grid_set(obj_inventory.ds_player_info, 3, 2, ((ds_grid_get(obj_inventory.ds_player_info, 3, 2)) + 1))
        ds_list_set(obj_inventory.ds_rcrds, 1, ((ds_list_find_value(obj_inventory.ds_rcrds, 1)) + 1))
        state = (7 << 0)
    }
    else if (place_meeting((x + p_move_x), (y + p_move_y), obj_enemy_parent) || place_meeting((x + p_move_x), (y + p_move_y), obj_npc_parent))
    {
        var ienemy = instance_place((x + p_move_x), (y + p_move_y), obj_enemy_parent)
        with (ienemy)
            playerhitme = 1
        state = (6 << 0)
    }
    else if place_meeting((x + p_move_x), (y + p_move_y), obj_pit)
    {
        x += p_move_x
        y += p_move_y
        if (ds_grid_get(obj_inventory.ds_equipment, 0, 1) == 2 && can_float == 1 && global.wings_toggle == 1)
        {
            if audio_is_playing(snd_wingspawn)
                audio_stop_sound(snd_wingspawn)
            audio_play_sound(snd_wingspawn, 1, 0)
            ds_list_set(obj_inventory.ds_rcrds, 8, ((ds_list_find_value(obj_inventory.ds_rcrds, 8)) + 1))
            show_debug_message("Wings used: " + (string(ds_list_find_value(obj_inventory.ds_rcrds, 8))))
            didyamuv = 1
            float = 1
            if (global.wings_used == 0)
                global.wings_used = 1
            if instance_exists(obj_enemy_cm)
                obj_enemy_cm.player_moved = 1
            if instance_exists(obj_npc_parent)
                obj_npc_parent.n_state = (2 << 0)
            can_float = 0
            ds_grid_set(obj_inventory.ds_player_info, 3, 0, ((ds_grid_get(obj_inventory.ds_player_info, 3, 0)) + 1))
            ds_grid_set(obj_inventory.ds_player_info, 3, 2, ((ds_grid_get(obj_inventory.ds_player_info, 3, 2)) + 1))
            ds_list_set(obj_inventory.ds_rcrds, 1, ((ds_list_find_value(obj_inventory.ds_rcrds, 1)) + 1))
            state = (10 << 0)
        }
        else
        {
            state = (23 << 0)
            xslide -= (p_move_x * 0.5)
            yslide -= (p_move_y * 0.5)
        }
    }
    else
    {
        didyamuv = 1
        var _explofloor_stepped = instance_place((x + p_move_x), (y + p_move_y), obj_explofloor)
        if (_explofloor_stepped == noone)
        {
            can_float = 1
            float_state = 0
        }
        else
        {
            with (_explofloor_stepped)
                self.fnc_explofloor__check_if_stepped_on()
        }
        if (float == 1)
        {
            switch set_p_direction
            {
                case 0:
                    var wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 0
                    break
                case 1:
                    wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 1
                    break
                case 2:
                    wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 2
                    break
                case 3:
                    wings_dis = instance_create_layer(x, y, "Player", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 3
                    break
            }

        }
        float = 0
        show_debug_message("Enemies, act!")
        if instance_exists(obj_enemy_cm)
            obj_enemy_cm.player_moved = 1
        if instance_exists(obj_npc_parent)
            obj_npc_parent.n_state = (2 << 0)
        x += p_move_x
        y += p_move_y
        ds_grid_set(obj_inventory.ds_player_info, 3, 0, ((ds_grid_get(obj_inventory.ds_player_info, 3, 0)) + 1))
        ds_grid_set(obj_inventory.ds_player_info, 3, 2, ((ds_grid_get(obj_inventory.ds_player_info, 3, 2)) + 1))
        ds_list_set(obj_inventory.ds_rcrds, 1, ((ds_list_find_value(obj_inventory.ds_rcrds, 1)) + 1))
        state = (10 << 0)
    }
    switch set_p_direction
    {
        case 0:
            sprite_index = spr_m_right
            break
        case 1:
            sprite_index = spr_m_up
            break
        case 2:
            sprite_index = spr_m_left
            break
        case 3:
            sprite_index = spr_m_down
            break
    }

}
else if (state == (13 << 0))
{
    var using_swapper = false
    if (ds_grid_get(obj_inventory.ds_equipment, 0, 4) == 1 && global.swapper_toggle == 1)
    {
        test_i = 1
        test_x = x
        test_y = y
        while (test_i < 14)
        {
            test_x += p_move_x
            test_y += p_move_y
            if (place_meeting(test_x, test_y, obj_fakewall) || place_meeting(test_x, test_y, obj_text_parent) || place_meeting(test_x, test_y, obj_chest_parent) || place_meeting(test_x, test_y, obj_sealchest))
                break
            else if (place_meeting(test_x, test_y, obj_obstacle_parent) && (!(place_meeting(test_x, test_y, obj_boulder))) && (!(place_meeting(test_x, test_y, obj_npc_talk))))
                break
            else if (place_meeting(test_x, test_y, obj_enemy_parent) || place_meeting(test_x, test_y, obj_boulder) || place_meeting(test_x, test_y, obj_npc_talk))
            {
                if (test_i >= 2)
                {
                    state = (495 << 0)
                    using_swapper = true
                }
                break
            }
            else
            {
                test_i++
                continue
            }
        }
    }
    if (!using_swapper)
    {
        if (place_meeting((x + p_move_x), (y + p_move_y), obj_floor_tile) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_enemy_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_floor_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_obstacle_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_npc_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_npc_talk))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_jewel_collect))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_text_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_fakewall))))
        {
            if (ds_grid_get(obj_inventory.ds_player_info, 8, 3) == 0)
            {
                if (string_length(tile_str) < tile_limit)
                {
                    instance_create_layer((x + p_move_x), (y + p_move_y), "Effects", obj_sparkle)
                    instance_create_layer((x + p_move_x), (y + p_move_y), "Pit", obj_pit)
                    swipe_state = 1
                    float_attack = 1
                    var floor_tile = instance_place((x + p_move_x), (y + p_move_y), obj_floor_tile)
                    if (global.cc_state != 0)
                        global.cc_multiplier = 1
                    if (ds_grid_get(obj_inventory.ds_player_info, 10, 2) == 999)
                    {
                        with (obj_endlessrod_numbers)
                            instance_destroy()
                        var itile = string_length(tile_str) - 2
                        var iendless = instance_create_layer(x, (y - 8), "Effects", obj_endlessrod_numbers)
                        with (iendless)
                            e_number = itile
                    }
                    with (floor_tile)
                    {
                        destroyer_id = 1
                        instance_destroy()
                    }
                    switch set_p_direction
                    {
                        case 0:
                            sprite_index = spr_a_right
                            break
                        case 1:
                            sprite_index = spr_a_up
                            break
                        case 2:
                            sprite_index = spr_a_left
                            break
                        case 3:
                            sprite_index = spr_a_down
                            break
                    }

                    aattack = 1
                    ds_grid_set(obj_inventory.ds_player_info, 3, 1, ((ds_grid_get(obj_inventory.ds_player_info, 3, 1)) + 1))
                    ds_grid_set(obj_inventory.ds_player_info, 3, 3, ((ds_grid_get(obj_inventory.ds_player_info, 3, 3)) + 1))
                    ds_list_set(obj_inventory.ds_rcrds, 0, ((ds_list_find_value(obj_inventory.ds_rcrds, 0)) + 1))
                    audio_play_sound(snd_voidrod_store, 1, 0)
                    state = (14 << 0)
                    void_count += 1
                    scr_lev_count()
                    scr_lev_check(0, "This L code does something 1")
                }
                else
                {
                    instance_create_layer(x, (y - 16), "Effects", obj_question)
                    state = (20 << 0)
                }
            }
            else
            {
                instance_create_layer(x, (y - 16), "Effects", obj_question)
                state = (20 << 0)
            }
        }
        else if (place_meeting((x + p_move_x), (y + p_move_y), obj_pit) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_enemy_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_floor_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_obstacle_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_npc_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_npc_talk))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_jewel_collect))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_text_parent))) && (!(place_meeting((x + p_move_x), (y + p_move_y), obj_fakewall))))
        {
            if (string_length(string(tile_str)) > 3)
            {
                if (ds_grid_get(obj_inventory.ds_player_info, 8, 3) == 0)
                {
                    instance_create_layer((x + p_move_x), (y + p_move_y), "Effects", obj_sparkle)
                    swipe_state = 1
                    float_attack = 1
                    var check_fallobj = instance_place((x + p_move_x), (y + p_move_y), obj_fall)
                    var check_dfappear = instance_place((x + p_move_x), (y + p_move_y), obj_cif_deathfloor_appear)
                    if check_fallobj
                    {
                        with (check_fallobj)
                        {
                            instance_create_layer(x, (y - 4), "Effects", obj_plonk)
                            if (global.cc_state != 0)
                                global.cc_score += 2560
                            audio_play_sound(snd_reveal, 1, 0)
                            instance_destroy()
                        }
                    }
                    else if check_dfappear
                    {
                        with (check_dfappear)
                        {
                            instance_create_layer(x, (y - 4), "Effects", obj_plonk)
                            audio_play_sound(snd_reveal, 1, 0)
                            instance_destroy()
                        }
                    }
                    else
                        audio_play_sound(snd_voidrod_place, 1, 0)
                    if (global.cc_state != 0)
                        global.cc_multiplier = 1
                    var l_tile = string_char_at(string(tile_str), (string_length(string(tile_str)) - 1))
                    switch string(l_tile)
                    {
                        case 0:
                            break
                        case 1:
                            break
                        case 2:
                            var ifloor_ins = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor)
                            if (global.puzzle == 1)
                            {
                                var iarray_number = string_length(tile_str) - 3
                                var iarray_value = pp_number[iarray_number]
                                with (ifloor_ins)
                                    puzzle_piece = iarray_value
                            }
                            break
                        case 3:
                            instance_create_layer((x + p_move_x), (y + p_move_y), "Floor_INS", obj_glassfloor)
                            break
                        case 4:
                            instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floorswitch)
                            break
                        case 5:
                            instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_exit)
                            break
                        case 6:
                            instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_copyfloor)
                            var iexstring = "0"
                            with (obj_riddle_008)
                            {
                                var islength = string_length(code_string) + 1
                                code_string = string_insert(iexstring, code_string, islength)
                            }
                            break
                        case 7:
                            instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_bombfloor)
                            break
                        case 8:
                            instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_explofloor)
                            break
                        case 9:
                            var spikisich = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_ev_spikeswitch)
                            with (spikisich)
                            {
                                if (ds_list_size(global.switchspikes_list) > 0)
                                {
                                    switchid = ds_list_find_value(global.switchspikes_list, (ds_list_size(global.switchspikes_list) - 1))
                                    ds_list_delete(global.switchspikes_list, (ds_list_size(global.switchspikes_list) - 1))
                                }
                            }
                            break
                        case "V":
                            var spiki = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_ev_floorspikes)
                            with (spiki)
                            {
                                if (ds_list_size(global.floorspikes_list) > 0)
                                {
                                    switchid = ds_list_find_value(global.floorspikes_list, (ds_list_size(global.floorspikes_list) - 1))
                                    ds_list_delete(global.floorspikes_list, (ds_list_size(global.floorspikes_list) - 1))
                                }
                            }
                            break
                        case "X":
                            instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_deathfloor)
                            break
                        case "A":
                            var hp_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_hp)
                            with (hp_floor)
                            {
                                scr_errormessage(2)
                                global.hpdead = 0
                            }
                            break
                        case "B":
                            var hpn_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_hpn)
                            with (hpn_floor)
                            {
                                creator_id = 1
                                dummy_value = obj_errormessages.dummy_value1
                                alarm[1] = 1
                            }
                            break
                        case "C":
                            var l_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_locust)
                            with (l_floor)
                                scr_errormessage(14)
                            break
                        case "D":
                            var ln_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_hpn2)
                            with (ln_floor)
                            {
                                creator_id = 1
                                dummy_value = obj_errormessages.dummy_value2
                                alarm[1] = 1
                            }
                            break
                        case "E":
                            var vr_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_voidrod)
                            with (vr_floor)
                                scr_errormessage(20)
                            break
                        case "F":
                            var vrn_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_hpn3)
                            with (vrn_floor)
                            {
                                creator_id = 1
                                dummy_value = obj_errormessages.dummy_value3
                                alarm[1] = 1
                            }
                            break
                        case "G":
                            var m1_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_memory1)
                            with (m1_floor)
                            {
                                ds_grid_set(obj_inventory.ds_equipment, 0, 0, obj_errormessages.dummy_mem1)
                                if (obj_errormessages.dummy_mem1 != 0)
                                {
                                    scr_errormessage(23)
                                    obj_errormessages.dummy_mem1 = 0
                                }
                            }
                            break
                        case "H":
                            var m2_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_memory2)
                            with (m2_floor)
                            {
                                ds_grid_set(obj_inventory.ds_equipment, 0, 1, obj_errormessages.dummy_mem2)
                                if (obj_errormessages.dummy_mem2 != 0)
                                {
                                    scr_errormessage(25)
                                    obj_errormessages.dummy_mem2 = 0
                                }
                            }
                            break
                        case "I":
                            var m3_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_memory3)
                            with (m3_floor)
                            {
                                ds_grid_set(obj_inventory.ds_equipment, 0, 2, obj_errormessages.dummy_mem3)
                                if (obj_errormessages.dummy_mem3 != 0)
                                {
                                    scr_errormessage(27)
                                    obj_errormessages.dummy_mem3 = 0
                                }
                            }
                            break
                        case "J":
                            var b_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_blank)
                            with (b_floor)
                            {
                            }
                            break
                        case "K":
                            var br_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_brane)
                            with (br_floor)
                            {
                            }
                            break
                        case "L":
                            var brx_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_hpn4)
                            with (brx_floor)
                            {
                                creator_id = 1
                                dummy_value = obj_errormessages.dummy_value4
                                alarm[1] = 1
                            }
                            break
                        case "M":
                            var bb_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_floor_blank_b)
                            with (bb_floor)
                            {
                            }
                            break
                        case "N":
                            var ms_floor = instance_create_layer((x + p_move_x), (y + p_move_y), "Floor", obj_ev_floor_memory_swapper)
                            with (ms_floor)
                            {
                                ds_grid_set(obj_inventory.ds_equipment, 0, 4, obj_errormessages.dummy_swapper)
                                if (obj_errormessages.dummy_swapper != 0)
                                {
                                    scr_errormessage(496)
                                    obj_errormessages.dummy_swapper = 0
                                }
                            }
                            break
                        default:

                    }

                    if (string_length(tile_str) > 3)
                        tile_str = string_delete(tile_str, (string_length(tile_str) - 1), 1)
                    show_debug_message(tile_str)
                    var n_tile = string_char_at(tile_str, (string_length(tile_str) - 1))
                    ds_grid_set(obj_inventory.ds_player_info, 1, 3, string(n_tile))
                    if (ds_grid_get(obj_inventory.ds_player_info, 10, 2) == 999)
                    {
                        with (obj_endlessrod_numbers)
                            instance_destroy()
                        var itile2 = string_length(tile_str) - 3
                        var iendless2 = instance_create_layer(x, (y - 8), "Effects", obj_endlessrod_numbers)
                        with (iendless2)
                            e_number = itile2
                    }
                    var pit_tile = instance_place((x + p_move_x), (y + p_move_y), obj_pit)
                    with (instance_place((x + p_move_x), (y + p_move_y), obj_pit))
                        instance_destroy(pit_tile)
                    switch set_p_direction
                    {
                        case 0:
                            sprite_index = spr_a_right
                            break
                        case 1:
                            sprite_index = spr_a_up
                            break
                        case 2:
                            sprite_index = spr_a_left
                            break
                        case 3:
                            sprite_index = spr_a_down
                            break
                    }

                    aattack = 1
                    stored = 0
                    ds_grid_set(obj_inventory.ds_player_info, 3, 1, ((ds_grid_get(obj_inventory.ds_player_info, 3, 1)) + 1))
                    ds_grid_set(obj_inventory.ds_player_info, 3, 3, ((ds_grid_get(obj_inventory.ds_player_info, 3, 3)) + 1))
                    ds_list_set(obj_inventory.ds_rcrds, 0, ((ds_list_find_value(obj_inventory.ds_rcrds, 0)) + 1))
                    state = (14 << 0)
                    void_count += 1
                    scr_lev_check(0, "This L code does something 2")
                }
                else
                {
                    instance_create_layer(x, (y - 16), "Effects", obj_question)
                    state = (20 << 0)
                }
            }
            else
            {
                instance_create_layer(x, (y - 16), "Effects", obj_question)
                state = (20 << 0)
            }
        }
        else if (place_meeting(x, (y + p_move_y), obj_text_parent) && sprite_index == spr_m_up)
        {
            state = (19 << 0)
            var inst_npc = instance_place((x + p_move_x), (y + p_move_y), obj_mural)
            if (inst_npc != noone)
            {
                with (inst_npc)
                    alarm[0] = 1
            }
        }
        else if (place_meeting(x, (y + p_move_y), obj_chest_parent) && sprite_index == spr_m_up)
        {
            state = (18 << 0)
            var inst_chest = instance_place(x, (y - spd), obj_chest_parent)
            if (inst_chest != noone)
            {
                with (inst_chest)
                    alarm[0] = 1
            }
        }
        else if (place_meeting(x, (y + p_move_y), obj_sealchest) && sprite_index == spr_m_up)
        {
            state = (18 << 0)
            inst_chest = instance_place(x, (y - spd), obj_sealchest)
            if (inst_chest != noone)
            {
                with (inst_chest)
                    alarm[0] = 1
            }
        }
        else if place_meeting((x + p_move_x), (y + p_move_y), obj_npc_talk)
        {
            state = (19 << 0)
            inst_npc = instance_place((x + p_move_x), (y + p_move_y), obj_npc_talk)
            if (inst_npc != noone)
            {
                with (inst_npc)
                    alarm[0] = 1
            }
        }
        else if place_meeting((x + p_move_x), (y + p_move_y), obj_enemy_cm)
        {
            state = (19 << 0)
            var inst_etalk = instance_place((x + p_move_x), (y + p_move_y), obj_enemy_cm)
            if (inst_etalk != noone)
            {
                with (inst_etalk)
                    alarm[0] = 1
            }
        }
        else if (place_meeting((x + p_move_x), (y + p_move_y), obj_boulder) && ds_grid_get(obj_inventory.ds_equipment, 0, 0) == 1 && global.memory_toggle == 1)
        {
            state = (12 << 0)
            ds_list_set(obj_inventory.ds_rcrds, 7, ((ds_list_find_value(obj_inventory.ds_rcrds, 7)) + 1))
            show_debug_message("Boulder talk: " + (string(ds_list_find_value(obj_inventory.ds_rcrds, 7))))
            var boulder_antimemory_exists = 0
            with (obj_boulder)
            {
                if (b_form == 12)
                    boulder_antimemory_exists = 1
            }
            if (!boulder_antimemory_exists)
            {
                if (active_textbox == noone)
                {
                    var inst = instance_place((x + p_move_x), (y + p_move_y), obj_boulder)
                    if (inst != noone)
                    {
                        with (inst)
                        {
                            alarm[10] = 3
                            var tbox = create_textbox(text, speakers, moods)
                        }
                        active_textbox = tbox
                    }
                }
                else if (!instance_exists(active_textbox))
                    active_textbox = noone
            }
        }
        else if (place_meeting((x + p_move_x), (y + p_move_y), obj_enemy_parent) && ds_grid_get(obj_inventory.ds_equipment, 0, 2) == 3 && global.sword_toggle == 1)
        {
            ds_list_set(obj_inventory.ds_rcrds, 9, ((ds_list_find_value(obj_inventory.ds_rcrds, 9)) + 1))
            show_debug_message("Sword used: " + (string(ds_list_find_value(obj_inventory.ds_rcrds, 9))))
            state = (1 << 0)
        }
        else
        {
            instance_create_layer(x, (y - 16), "Effects", obj_question)
            state = (20 << 0)
        }
    }
}
else if (state == (12 << 0))
{
    if (!instance_exists(active_textbox))
    {
        counter += 1
        if (counter == 1)
        {
            with (obj_boulder)
            {
                if (special_message == 52)
                {
                    special_message = 66
                    alarm[0] = 1
                }
                else if (special_message == 66)
                {
                    b_specialtalkcounter++
                    if (b_specialtalkcounter == 3)
                    {
                        special_message = 67
                        alarm[0] = 1
                    }
                }
                else if (special_message == 67)
                {
                    b_specialtalkcounter = 4
                    special_message = 66
                    alarm[0] = 1
                }
                else if (special_message == 92)
                {
                    special_message = 93
                    alarm[0] = 1
                }
            }
        }
        if (counter == 16)
        {
            counter = 0
            active_textbox = -4
            state = (0 << 0)
        }
    }
}
else if (state == (7 << 0))
{
    if (counter < extend_time)
    {
        image_speed = 1
        switch set_p_direction
        {
            case 0:
                s_extend_x = 1
                break
            case 1:
                s_extend_y = -1
                break
            case 2:
                s_extend_x = -1
                break
            case 3:
                s_extend_y = 1
                break
        }

    }
    switch set_p_direction
    {
        case 0:
            sprite_index = spr_a_right
            break
        case 1:
            sprite_index = spr_a_up
            break
        case 2:
            sprite_index = spr_a_left
            break
        case 3:
            sprite_index = spr_a_down
            break
    }

    counter += 1
    if (counter == extend_time)
    {
        s_extend_x = 0
        s_extend_y = 0
        image_speed = 0
    }
    if (counter >= 20)
    {
        if (float == 0)
        {
            scr_lev_check(0, "Push-stun Lev check", 0)
            if (state != (27 << 0))
            {
                state = (10 << 0)
                counter = 0
            }
        }
        else if (float == 1)
        {
            state = (25 << 0)
            float_state = 2
            counter = 0
        }
    }
}
else if (state == (14 << 0))
{
    if (counter < extend_time)
    {
        image_speed = 1
        switch set_p_direction
        {
            case 0:
                s_extend_x = 1
                break
            case 1:
                s_extend_y = -1
                break
            case 2:
                s_extend_x = -1
                break
            case 3:
                s_extend_y = 1
                break
        }

    }
    counter += 1
    if (counter == extend_time)
    {
        s_extend_x = 0
        s_extend_y = 0
        image_speed = 0
    }
    if (swap_stage == 1 && counter >= 15)
    {
        with (obj_ev_swapper_laser)
            event_perform(ev_other, ev_user0)
        image_speed = 0
        switch set_p_direction
        {
            case 0:
                sprite_index = spr_m_right
                break
            case 1:
                sprite_index = spr_m_up
                break
            case 2:
                sprite_index = spr_m_left
                break
            case 3:
                sprite_index = spr_m_down
                break
        }

        swap_stage = 2
    }
    else if (counter >= 20)
    {
        if (string_length(tile_str) > 4)
        {
            if (global.endless_used == 0)
                global.endless_used = 1
        }
        state = (10 << 0)
        counter = 0
    }
}
else if (state == (20 << 0))
{
    counter += 1
    if (counter >= 30)
    {
        state = (0 << 0)
        counter = 0
    }
}
else if (state == (23 << 0))
{
    obj_pause.can_pause = 0
    image_speed += 0.2
    counter++
    if (counter == 1)
    {
        if (obj_player.set_p_direction == 0)
        {
            var p_sweat = instance_create_layer(x, y, "Effects", obj_sweat)
            with (p_sweat)
            {
                stick_to_player = 1
                flip_x = -1
                x_offset = -8
                y_offset = -8
            }
        }
        else if (obj_player.set_p_direction == 2)
        {
            p_sweat = instance_create_layer(x, y, "Effects", obj_sweat)
            with (p_sweat)
            {
                stick_to_player = 1
                flip_x = 1
                x_offset = 8
                y_offset = -8
            }
        }
        else if (obj_player.set_p_direction == 1)
        {
            p_sweat = instance_create_layer(x, y, "Effects", obj_sweat)
            with (p_sweat)
            {
                stick_to_player = 1
                flip_x = -1
                x_offset = -8
                y_offset = -8
            }
        }
        else if (obj_player.set_p_direction == 3)
        {
            p_sweat = instance_create_layer(x, y, "Effects", obj_sweat)
            with (p_sweat)
            {
                stick_to_player = 1
                flip_x = 1
                x_offset = 8
                y_offset = -8
            }
        }
    }
    if (counter < 48)
    {
        xslide += (p_move_x * 0.01)
        yslide += (p_move_y * 0.01)
        if (input_left_p == 1)
        {
            if (obj_player.set_p_direction == 0)
            {
                button_pressed = 0
                set_p_direction = prevdir
                counter = 0
                x -= 16
                xslide = 0
                yslide = 0
                obj_pause.can_pause = 1
                with (obj_sweat)
                    instance_destroy()
                mbuffer = 1
                state = (0 << 0)
            }
        }
        else if (input_right_p == 1)
        {
            if (obj_player.set_p_direction == 2)
            {
                button_pressed = 0
                set_p_direction = prevdir
                counter = 0
                x += 16
                xslide = 0
                yslide = 0
                obj_pause.can_pause = 1
                with (obj_sweat)
                    instance_destroy()
                mbuffer = 1
                state = (0 << 0)
            }
        }
        else if (input_down_p == 1)
        {
            if (obj_player.set_p_direction == 1)
            {
                button_pressed = 0
                set_p_direction = prevdir
                counter = 0
                y += 16
                xslide = 0
                yslide = 0
                obj_pause.can_pause = 1
                with (obj_sweat)
                    instance_destroy()
                mbuffer = 1
                state = (0 << 0)
            }
        }
        else if (input_up_p == 1)
        {
            if (obj_player.set_p_direction == 3)
            {
                button_pressed = 0
                set_p_direction = prevdir
                counter = 0
                y -= 16
                xslide = 0
                yslide = 0
                obj_pause.can_pause = 1
                with (obj_sweat)
                    instance_destroy()
                mbuffer = 1
                state = (0 << 0)
            }
        }
        else if (input_mouse == 1)
        {
            if (obj_player.set_p_direction == 0)
            {
                button_pressed = 0
                set_p_direction = prevdir
                counter = 0
                x -= 16
                xslide = 0
                yslide = 0
                obj_pause.can_pause = 1
                with (obj_sweat)
                    instance_destroy()
                mbuffer = 1
                state = (0 << 0)
            }
            else if (obj_player.set_p_direction == 2)
            {
                button_pressed = 0
                set_p_direction = prevdir
                counter = 0
                x += 16
                xslide = 0
                yslide = 0
                obj_pause.can_pause = 1
                with (obj_sweat)
                    instance_destroy()
                mbuffer = 1
                state = (0 << 0)
            }
            else if (obj_player.set_p_direction == 1)
            {
                button_pressed = 0
                set_p_direction = prevdir
                counter = 0
                y += 16
                xslide = 0
                yslide = 0
                obj_pause.can_pause = 1
                with (obj_sweat)
                    instance_destroy()
                mbuffer = 1
                state = (0 << 0)
            }
            else if (obj_player.set_p_direction == 3)
            {
                button_pressed = 0
                set_p_direction = prevdir
                counter = 0
                y -= 16
                xslide = 0
                yslide = 0
                obj_pause.can_pause = 1
                with (obj_sweat)
                    instance_destroy()
                mbuffer = 1
                state = (0 << 0)
            }
        }
    }
    else if (counter == 60)
    {
        if (float == 1)
        {
            switch set_p_direction
            {
                case 0:
                    wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 0
                    break
                case 1:
                    wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 1
                    break
                case 2:
                    wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 2
                    break
                case 3:
                    wings_dis = instance_create_layer(x, y, "Player", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 3
                    break
            }

        }
        counter = 0
        state = (8 << 0)
    }
}
else if (state == (8 << 0))
{
    obj_pause.can_pause = 0
    float = 0
    if (!instance_exists(obj_enemy_tan))
    {
        with (obj_enemy_parent)
            cycle = 0
    }
    image_speed += 0.2
    counter += 1
    if (counter == 3)
    {
        ds_list_set(obj_inventory.ds_rcrds, 6, ((ds_list_find_value(obj_inventory.ds_rcrds, 6)) + 1))
        show_debug_message("Falls: " + (string(ds_list_find_value(obj_inventory.ds_rcrds, 6))))
        var baal_check = instance_place(x, (y - 16), obj_boulder)
        if (baal_check != noone && ds_grid_get(obj_inventory.ds_player_info, 1, 1) != 0)
        {
            with (baal_check)
            {
                alarm[3] = 78
                alarm[6] = 78
                if (b_form == 2)
                {
                    with (obj_player)
                        fallsecret = 1
                }
            }
        }
        var baal_check2 = instance_place(x, (y - 16), obj_npc_bee)
        if (baal_check2 != noone && ds_grid_get(obj_inventory.ds_player_info, 1, 1) != 0)
        {
            with (baal_check2)
            {
                alarm[5] = 78
                alarm[8] = 78
                with (obj_player)
                    fallsecret = 1
            }
        }
        with (obj_secret_exit)
        {
            if (secret_warp == 1)
            {
                alarm[3] = 78
                with (obj_player)
                    fallsecret = 1
            }
        }
        var nasecret_check = instance_place(x, y, obj_na_secret_exit)
        if (nasecret_check != noone && player_golden == 0)
        {
            with (nasecret_check)
            {
                alarm[3] = 78
                with (obj_player)
                    fallsecret = 1
            }
        }
    }
    if (counter == 4)
    {
        sprite_index = spr_empty
        audio_play_sound(snd_player_fall, 1, 0)
        instance_destroy(obj_sweat)
        instance_create_layer(x, y, "Effects", obj_player_fall)
        if instance_exists(obj_npc_gor)
        {
            with (obj_npc_gor)
                gor_playerpit = 1
        }
    }
    if (counter == 60 && fallsecret == 0)
        ds_grid_set(obj_inventory.ds_player_info, 1, 0, 0)
    if (global.voider == 1)
    {
        if (counter == 53 && fallsecret == 0)
        {
            var ikx = x
            var iky = y
            scr_ketuttaa(ikx, iky)
            if (global.ketuttaa == 0)
                instance_create_layer(x, y, "Effects", obj_diamond_fade)
            if (room == rm_test2_054)
            {
                var istring = "7"
                with (obj_riddle_008)
                {
                    islength = string_length(code_string) + 1
                    code_string = string_insert(istring, code_string, islength)
                }
            }
            if (global.cc_state != 0)
            {
                global.cc_multiplier = 1
                global.cc_chain = 10
            }
        }
    }
    if (counter >= 90)
    {
        if (global.floorvanish != 0)
            scr_errorcrash()
        if (room == rm_noway)
            scr_errorcrash()
        state = (15 << 0)
    }
    with (obj_npc_friend)
        event_perform(ev_other, ev_user2)
    if (fallsecret == 1)
    {
        with (obj_player_fall)
            secret_exit = 1
    }
}
else if (state == (6 << 0))
{
    ikx = x
    iky = y
    scr_ketuttaa(ikx, iky)
    obj_pause.can_pause = 0
    ds_list_set(obj_inventory.ds_rcrds, 5, ((ds_list_find_value(obj_inventory.ds_rcrds, 5)) + 1))
    show_debug_message("Hits taken: " + (string(ds_list_find_value(obj_inventory.ds_rcrds, 5))))
    sattack = 0
    aattack = 0
    audio_play_sound(snd_player_damage, 1, 0)
    if (didyahite == 0)
    {
        with (instance_place((x + p_move_x), (y + p_move_y), obj_enemy_parent))
        {
            if ((!(place_meeting(x, y, obj_enemy_parent))) && (!(place_meeting(x, y, obj_boulder))))
            {
                if (playerhitme != 0)
                    e_state = (9 << 0)
            }
        }
    }
    if (!instance_exists(obj_enemy_tan))
    {
        with (obj_enemy_parent)
            cycle = 0
    }
    if (float == 0)
    {
        if place_meeting(x, y, obj_pit)
            state = (8 << 0)
        else
            state = (15 << 0)
    }
    else if (float == 1)
    {
        sprite_index = spr_hurt
        switch set_p_direction
        {
            case 0:
                wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                with (wings_dis)
                    wing_dir = 0
                break
            case 1:
                wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                with (wings_dis)
                    wing_dir = 1
                break
            case 2:
                wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                with (wings_dis)
                    wing_dir = 2
                break
            case 3:
                wings_dis = instance_create_layer(x, y, "Player", obj_player_wings_dissipate)
                with (wings_dis)
                    wing_dir = 3
                break
        }

        state = (8 << 0)
        float = 0
    }
    with (obj_npc_friend)
        event_perform(ev_other, ev_user2)
}
else if (state == (10 << 0))
{
    regain_control = 0
    waiting_counter++
    if (global.cc_state == 1)
    {
        var _medal_collected = 0
        var iccmedal = instance_place(x, y, obj_cc_medal)
        if (iccmedal != noone)
        {
            var ipitch = medal_collect_pitch
            medal_collect_pitch += 0.05
            medal_collect_pitch = clamp(medal_collect_pitch, 0, 0.3)
            with (iccmedal)
            {
                if (medal_phase == 0)
                {
                    if audio_is_playing(snd_token_collect)
                        audio_stop_sound(snd_token_collect)
                    var isfx = audio_play_sound(snd_token_collect, 1, 0)
                    audio_sound_pitch(isfx, (0.9 + ipitch))
                    global.cc_medalcounter += 1
                    global.cc_score += global.cc_chain
                    global.cc_chain = global.cc_chain * 2
                    global.cc_chain = clamp(global.cc_chain, 10, 640)
                    mask_index = mask_blank
                    medal_phase = 1
                    _medal_collected = 1
                }
            }
        }
        if (!_medal_collected)
        {
            medal_collect_pitch = 0
            global.cc_chain = 10
        }
    }
    if (waiting_counter >= waiting_limit)
    {
        event_perform(ev_other, ev_user1)
        if (swap_stage == 2)
            swap_stage = 0
        else
            enemyturn_countdown = 2
        counter = 0
        image_speed = 0
        aattack = 0
        sattack = 0
        state = (0 << 0)
        if (alarm_on == 0)
        {
            alarm[0] = input_delay
            alarm_on = 1
        }
    }
}
else if (state == (15 << 0))
{
    obj_pause.can_pause = 0
    if (global.cc_state != 0)
    {
        global.cc_multiplier = 1
        global.cc_chain = 10
    }
    with (obj_cif_death)
        instance_destroy()
    if (counter == 0)
    {
        if (global.voider == 0)
        {
            ds_grid_set(obj_inventory.ds_player_info, 1, 0, 0)
            instance_create_layer((x - 12), (y - 8), "Text", obj_damage_numbers)
        }
    }
    global.hpdead = 0
    sprite_index = spr_hurt
    image_speed += 0.2
    counter++
    if (counter == 59)
    {
        if (global.floorvanish != 0)
            scr_errorcrash()
    }
    if (global.voider == 1)
    {
        if (counter == (deathtimer - 37))
        {
            if (room == rm_test2_054)
            {
                istring = "7"
                with (obj_riddle_008)
                {
                    islength = string_length(code_string) + 1
                    code_string = string_insert(istring, code_string, islength)
                }
            }
            if (global.ketuttaa == 0)
                instance_create_layer(x, y, "Effects", obj_diamond_fade)
        }
    }
    if (counter >= (deathtimer * 1))
    {
        if (global.voider == 0)
        {
            if instance_exists(obj_enemy_parent)
                obj_enemy_parent.e_state = (0 << 0)
            if (!(place_meeting(x, y, obj_pit)))
                instance_create_layer(x, y, "Instances", obj_player_dead)
            if (ds_grid_get(obj_inventory.ds_player_info, 1, 1) == 0)
            {
                sprite_index = spr_empty
                alarm[1] = 180
                if (global.stranger == 1)
                {
                    if (ds_grid_get(obj_inventory.ds_player_info, 16, 3) != 0)
                        ds_grid_set(obj_inventory.ds_player_info, 16, 3, 1000)
                }
                scr_stop_music(1, 4)
                scr_stop_ambience(1, 4)
                global.ambience_shutdown = 1
                obj_music_controller.alarm[3] = 180
                obj_music_controller.alarm[8] = 180
                obj_inventory.alarm[0] = 180
                obj_inventory.alarm[3] = 120
                alarm[2] = 180
                state = (16 << 0)
            }
            else if (ds_grid_get(obj_inventory.ds_player_info, 1, 1) != 0)
            {
                sprite_index = spr_empty
                alarm[4] = 30
                state = (16 << 0)
            }
        }
        else if (global.ketuttaa == 0)
        {
            counter = 0
            room_restart()
        }
        else
        {
            instance_create_layer(x, y, "Effects2", obj_player_eivaanpysty)
            var ifader = instance_create_layer(x, y, "Effects2", obj_fade_black_remain)
            with (ifader)
                transition_multiplier = 2
            if place_meeting(x, y, obj_pit)
                sprite_index = spr_empty
            else
            {
                image_speed = 0
                switch global.stranger
                {
                    case 0:
                        sprite_index = spr_player_dead
                        break
                    case 1:
                        sprite_index = spr_lil_dead
                        break
                }

            }
            state = (25 << 0)
        }
    }
}
else if (state == (1 << 0))
{
    var beecheck = instance_place((x + p_move_x), (y + p_move_y), obj_enemy_bee)
    var beefake = instance_place((x + p_move_x), (y + p_move_y), obj_enemy_bee_fake)
    var beefake2 = instance_place((x + p_move_x), (y + p_move_y), obj_enemy_bee_fake2)
    var flycheck = instance_place((x + p_move_x), (y + p_move_y), obj_enemy_cf)
    if (global.sword_used == 0)
        global.sword_used = 1
    float_attack = 1
    swipe_state = 1
    if (room == rm_e_022)
    {
        if instance_place((x + p_move_x), (y + p_move_y), obj_enemy_cl)
        {
            with (obj_riddle_005)
            {
                check2 += 1
                show_debug_message("Check 2: " + string(check2))
            }
        }
    }
    with (instance_place((x + p_move_x), (y + p_move_y), obj_enemy_parent))
    {
        if beecheck
        {
        }
        else if beefake
        {
            if audio_is_playing(snd_bee_laughter)
                audio_stop_sound(snd_bee_laughter)
            audio_play_sound(snd_bee_laughter, 1, 0)
            with (beefake)
                player_attack = 1
        }
        else if beefake2
        {
            if audio_is_playing(snd_bee_laughter)
                audio_stop_sound(snd_bee_laughter)
            audio_play_sound(snd_bee_laughter, 1, 0)
            with (beefake2)
                player_attack = 1
        }
        else if flycheck
        {
            with (flycheck)
            {
                if (f_state == 0)
                {
                    if audio_is_playing(snd_enemy_explosion)
                        audio_stop_sound(snd_enemy_explosion)
                    audio_play_sound(snd_enemy_explosion, 1, 0)
                }
                else
                {
                    if audio_is_playing(snd_bee_laughter)
                        audio_stop_sound(snd_bee_laughter)
                    audio_play_sound(snd_bee_laughter, 1, 0)
                }
            }
        }
        else
        {
            if audio_is_playing(snd_enemy_explosion)
                audio_stop_sound(snd_enemy_explosion)
            audio_play_sound(snd_enemy_explosion, 1, 0)
        }
        if (global.cc_state != 0)
        {
            if (global.cc_multiplier > 1)
            {
                var imultifx = instance_create_depth(x, y, 80, obj_cc_multiplier_fx)
                with (imultifx)
                    multiplier = clamp(global.cc_multiplier, 1, 16)
            }
        }
        if (global.cc_state != 0)
            scr_cc_scorevalue(enemy_score, 1)
        e_state = (11 << 0)
    }
    with (instance_place((x + p_move_x), (y + p_move_y), obj_cif_bullet_parent))
        event_perform(ev_other, ev_user1)
    with (obj_enemy_cm)
        player_moved = 0
    switch set_p_direction
    {
        case 0:
            sprite_index = spr_a_right
            break
        case 1:
            sprite_index = spr_a_up
            break
        case 2:
            sprite_index = spr_a_left
            break
        case 3:
            sprite_index = spr_a_down
            break
    }

    sattack = 1
    if audio_is_playing(snd_sword_stab)
        audio_stop_sound(snd_sword_stab)
    audio_play_sound(snd_sword_stab, 1, 0)
    state = (14 << 0)
}
else if (state == 495)
{
    if (global.swapper_used == 0)
        global.swapper_used = 1
    float_attack = 1
    swipe_state = 1
    test_i = 1
    test_x = x
    test_y = y
    while (test_i < 14)
    {
        test_x += p_move_x
        test_y += p_move_y
        if (place_meeting(test_x, test_y, obj_fakewall) || place_meeting(test_x, test_y, obj_text_parent) || place_meeting(test_x, test_y, obj_chest_parent) || place_meeting(test_x, test_y, obj_sealchest))
            break
        else if (place_meeting(test_x, test_y, obj_obstacle_parent) && (!(place_meeting(test_x, test_y, obj_boulder))) && (!(place_meeting(test_x, test_y, obj_npc_talk))))
            break
        else if (place_meeting(test_x, test_y, obj_enemy_parent) || place_meeting(test_x, test_y, obj_boulder) || place_meeting(test_x, test_y, obj_npc_talk))
        {
            if (test_i >= 2)
            {
                var swap_obj = -4
                with (instance_place(test_x, test_y, obj_enemy_parent))
                    swap_obj = id
                with (instance_place(test_x, test_y, obj_boulder))
                    swap_obj = id
                with (instance_place(test_x, test_y, obj_npc_talk))
                    swap_obj = id
                var swapper_laser = instance_create_depth(x, y, 150, obj_ev_swapper_laser)
                with (swapper_laser)
                {
                    if (test_x > x)
                        laser_direction = 0
                    else if (test_x < x)
                        laser_direction = 180
                    else if (test_y > y)
                        laser_direction = 270
                    else if (test_y < y)
                        laser_direction = 90
                    laser_length = test_i
                    swap_object = swap_obj
                }
                swap_stage = 1
            }
            break
        }
        else
        {
            test_i++
            continue
        }
    }
    with (obj_enemy_cm)
        player_moved = 0
    switch set_p_direction
    {
        case 0:
            sprite_index = spr_a_right
            break
        case 1:
            sprite_index = spr_a_up
            break
        case 2:
            sprite_index = spr_a_left
            break
        case 3:
            sprite_index = spr_a_down
            break
    }

    if audio_is_playing(snd_laser)
        audio_stop_sound(snd_laser)
    isfx = audio_play_sound(snd_laser, 1, 0)
    audio_sound_pitch(isfx, 1.2)
    state = (14 << 0)
}
if (enemyturn_countdown > 0)
{
    enemyturn_countdown--
    if (enemyturn_countdown <= 0)
    {
        if (enemy_cycle == 0)
        {
            if instance_exists(obj_enemy_parent)
            {
                if instance_exists(obj_exit)
                {
                    if (obj_exit.hidden == 0 && place_meeting(x, y, obj_exit) && obj_exit.cheese_counter == 2)
                        obj_enemy_parent.e_state = (0 << 0)
                    else
                        obj_enemy_parent.e_state = (14 << 0)
                }
                else
                    obj_enemy_parent.e_state = (14 << 0)
            }
            with (obj_enemy_floormaster)
                e_state = (14 << 0)
            with (obj_jewel_collect)
                event_perform(ev_other, ev_user1)
        }
    }
}
if (state == (9 << 0))
{
    if (global.player_blink == 1)
    {
        obj_pause.can_pause = 0
        sprite_index = spr_blink
        image_speed += 0.5
    }
    else
    {
        obj_pause.can_pause = 0
        sprite_index = spr_m_down
        image_speed += 0.04
        event_perform(ev_other, ev_user9)
    }
}
if (state == (21 << 0))
{
    counter++
    if (counter > 0 && counter <= 120)
    {
        sprite_index = spr_sleep
        image_speed += 0.02
    }
    else if (counter > 120 && counter <= 240)
    {
        sprite_index = spr_wakey
        image_speed += 0.02
    }
    else if (counter > 240 && counter <= 300)
    {
        sprite_index = spr_wakey
        image_speed = 0
    }
    else if (counter > 300)
    {
        sprite_index = spr_enter
        if (image_speed != wake_speed)
            image_speed += 0.1
        else
        {
            image_speed = 0
            sprite_index = spr_m_down
            counter = 0
            state = (0 << 0)
            alarm_on = 0
            ds_grid_set(obj_inventory.ds_player_info, 7, 0, 0)
            scr_savegame()
        }
    }
}
if (state == (22 << 0))
{
    sprite_index = spr_item
    ds_grid_set(obj_inventory.ds_player_info, 8, 3, 0)
    state = (18 << 0)
    var inst_vr = instance_place(x, y, obj_voidrod_collect)
    if (inst_vr != noone)
    {
        with (inst_vr)
            alarm[0] = 1
    }
}
if (state == (26 << 0))
{
    sprite_index = spr_item
    state = (18 << 0)
    var inst_l = instance_place(x, y, obj_locust_collect)
    if (inst_l != noone)
    {
        with (inst_l)
            alarm[0] = 1
    }
}
if (float_state == 1)
{
    if (ds_grid_get(obj_inventory.ds_equipment, 0, 1) == 2 && global.wings_toggle == 1 && can_float == 1)
    {
        if audio_is_playing(snd_wingspawn)
            audio_stop_sound(snd_wingspawn)
        audio_play_sound(snd_wingspawn, 1, 0)
        ds_list_set(obj_inventory.ds_rcrds, 8, ((ds_list_find_value(obj_inventory.ds_rcrds, 8)) + 1))
        show_debug_message("Wings used: " + (string(ds_list_find_value(obj_inventory.ds_rcrds, 8))))
        if (global.wings_used == 0)
            global.wings_used = 1
        float = 1
        can_float = 0
    }
}
if (float_state == 2)
{
    state = (25 << 0)
    obj_pause.can_pause = 0
    image_speed += 0.2
    counter++
    if (counter == 1)
    {
        if (float == 1)
        {
            switch set_p_direction
            {
                case 0:
                    wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 0
                    break
                case 1:
                    wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 1
                    break
                case 2:
                    wings_dis = instance_create_layer(x, y, "Effects", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 2
                    break
                case 3:
                    wings_dis = instance_create_layer(x, y, "Player", obj_player_wings_dissipate)
                    with (wings_dis)
                        wing_dir = 3
                    break
            }

            float = 0
        }
        if (obj_player.set_p_direction == 0)
        {
            p_sweat = instance_create_layer(x, y, "Effects", obj_sweat)
            with (p_sweat)
            {
                stick_to_player = 1
                flip_x = -1
                x_offset = -8
                y_offset = -8
            }
        }
        else if (obj_player.set_p_direction == 2)
        {
            p_sweat = instance_create_layer(x, y, "Effects", obj_sweat)
            with (p_sweat)
            {
                stick_to_player = 1
                flip_x = 1
                x_offset = 8
                y_offset = -8
            }
        }
        else if (obj_player.set_p_direction == 1)
        {
            p_sweat = instance_create_layer(x, y, "Effects", obj_sweat)
            with (p_sweat)
            {
                stick_to_player = 1
                flip_x = -1
                x_offset = -8
                y_offset = -8
            }
        }
        else if (obj_player.set_p_direction == 3)
        {
            p_sweat = instance_create_layer(x, y, "Effects", obj_sweat)
            with (p_sweat)
            {
                stick_to_player = 1
                flip_x = 1
                x_offset = 8
                y_offset = -8
            }
        }
    }
    else if (counter == 61)
    {
        counter = 0
        float_state = 0
        state = (8 << 0)
    }
}
if (state == (27 << 0))
{
    show_debug_message("Lev check state... is this bad?")
    recheck_counter++
    if (recheck_counter == 4)
    {
        event_perform(ev_other, ev_user11)
        recheck_counter = 0
    }
}
wing_speed += 0.5
switch swipe_state
{
    case 0:
        swipe_speed = 0
        switch set_p_direction
        {
            case 0:
                swipe_dir = 90
                swipe_xswap = -1
                swipe_yswap = 1
                sw_x = 8
                sw_y = 8
                break
            case 1:
                swipe_dir = 180
                swipe_xswap = 1
                swipe_yswap = 1
                sw_x = -8
                sw_y = -8
                break
            case 2:
                swipe_dir = 270
                swipe_xswap = 1
                swipe_yswap = 1
                sw_x = -8
                sw_y = 8
                break
            case 3:
                swipe_dir = 0
                swipe_xswap = 1
                swipe_yswap = 1
                sw_x = 8
                sw_y = 8
                break
        }

        break
    case 1:
        if (swipe_speed != swipe_frames)
            swipe_speed += 1
        else
            swipe_state = 0
        break
}

if (obj_player.state == (10 << 0) || obj_player.state == (13 << 0) || obj_player.state == (11 << 0) || obj_player.state == (7 << 0) || obj_player.state == (14 << 0) || obj_player.state == (20 << 0))
    player_pause_countdown = 4
