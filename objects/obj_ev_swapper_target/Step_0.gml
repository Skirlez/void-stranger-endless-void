if global.pause
    return;
if !fade_away && instance_exists(target_object)
{
    x = target_object.x
    y = target_object.y
	if (target_object.object_index == tree_index)
		y += 24;
}	
color_counter++
switch color_counter
{
    case 5:
        target_color = 8421504
        break
    case 10:
        target_color = 12632256
        break
    case 15:
        target_color = 16777215
        break
    case 25:
        target_color = 12632256
        break
    case 30:
        target_color = 8421504
        color_counter = 0
        break
}

switch target_state
{
    case 999:
        counter++
        if (counter == 16)
        {
            counter = 0
            target_state = 10
        }
        break
    case 0:
        counter++
        target_speed += 0.5
        target2_speed += 0.5
        if (target_speed >= target_frames)
            target_speed = 0
        if (target2_speed >= target_frames)
            target2_speed = 0
        if (counter == 8)
        {
            counter = 0
            target_state = 1
        }
        break
    case 1:
        target_speed += 0.5
        target2_speed += 0.5
        if (target_speed >= target_frames)
            target_speed = 0
        if (target2_speed >= target_frames)
            target2_speed = 0
        if (fade_away == true)
        {
            counter++
            if (counter == 16)
                target_state = 2
        }
        break
    case 2:
        if (target_speed < target_frames)
            target_speed += 0.5
        if (target2_speed < target_frames)
            target2_speed += 0.5
        if (target_speed >= target_frames && target2_speed >= target_frames)
            instance_destroy()
        break
    case 10:
        for (var i = 0; i < 4; i += 1)
        {
            if (t_x[i] != ttx)
            {
                t_x[i] -= ((sign(t_x[i] - ttx)) * 1)
                t_y[i] -= ((sign(t_y[i] - tty)) * 1)
            }
            else
                target_state = 11
        }
        break
    case 11:
        var iframes = 2
        var i_imageframe = asset_get_index("scr_music_strobe_integer(iframes)")
        if (i_imageframe == 1)
        {
            t_x[0] = 1
            t_y[0] = 1
            t_x[1] = -1
            t_y[1] = 1
            t_x[2] = 1
            t_y[2] = -1
            t_x[3] = -1
            t_y[3] = -1
        }
        else if (i_imageframe == 0)
        {
            t_x[0] = 0
            t_y[0] = 0
            t_x[1] = 0
            t_y[1] = 0
            t_x[2] = 0
            t_y[2] = 0
            t_x[3] = 0
            t_y[3] = 0
        }
        if (fade_away == true)
        {
            counter++
            if (counter == 4)
            {
                t_x[0] = 0
                t_y[0] = 0
                t_x[1] = 0
                t_y[1] = 0
                t_x[2] = 0
                t_y[2] = 0
                t_x[3] = 0
                t_y[3] = 0
                target_state = 12
            }
        }
        break
    case 12:
        target_speed += 0.5
        arrow_speed += 0.5
        if (target_speed >= target_frames)
            instance_destroy()
        break
}

