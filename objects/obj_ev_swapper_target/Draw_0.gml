if (target_state == 999)
    return;
gpu_set_fog(true, target_color, 0, 0)
for (var i = 0; i < 4; i += 1)
{
    switch i
    {
        case 0:
            draw_sprite_ext(target_index, target_speed, (x + t_x[i] + 8), (y + t_y[i] + 8), 1, 1, 180, c_white, 1)
            break
        case 1:
            break
        case 2:
            break
        case 3:
            draw_sprite_ext(target_index, target_speed, (x + t_x[i] - 8), (y + t_y[i] - 8), 1, 1, 0, c_white, 1)
            break
    }

    switch i
    {
        case 0:
            break
        case 1:
            draw_sprite_ext(arrow_index, arrow_speed, (x + t_x[i] - 8), (y + t_y[i] + 8), 1, 1, 0, c_white, 1)
            break
        case 2:
            draw_sprite_ext(arrow_index, arrow_speed, (x + t_x[i] + 8), (y + t_y[i] - 8), 1, 1, 180, c_white, 1)
            break
        case 3:
            break
        default:

    }

}
gpu_set_fog(false, c_white, 0, 0)
