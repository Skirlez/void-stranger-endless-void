
var cam_width = camera_get_view_width(view_camera[0])
var cam_height = camera_get_view_height(view_camera[0])
var ratio_x = cam_width / 224;
var ratio_y = cam_height / 144;
image_xscale = ratio_x
image_yscale = ratio_y

if state == hammer_states.idle {
	if ev_is_mouse_on_me() && ev_mouse_pressed()
		state = hammer_states.dragged;
	else {
		var cam_x = camera_get_view_x(view_camera[0])
		var cam_y = camera_get_view_y(view_camera[0])
		x = cam_x + xstart * ratio_x;
		y = cam_y + ystart * ratio_y;
		image_angle = 0;
	}
}
else if state == hammer_states.dragged {
	if ev_mouse_released() {
		judging_display = instance_place(x, y, global.display_object)	
		if instance_exists(judging_display)
			state = hammer_states.animation
		else
			state = hammer_states.idle
	}
	else {
		x = mouse_x	
		y = mouse_y	
	}
	image_angle = -45
	
}
else if state == hammer_states.animation {
	if !instance_exists(judging_display)
		state = hammer_states.idle
	else {
		judge_animation_timer++;
		x = lerp(x, judging_display.x + judging_display.sprite_width / 2, 0.3)
		y = lerp(y, judging_display.y + judging_display.sprite_height / 2, 0.3)
		if judge_animation_timer <= 15 {
			
			var t = judge_animation_timer;	
			// we wanna turn 135 degrees in a cool way
			image_angle = -45 
				+ (t * t * t / 25) 

			if judge_animation_timer == 15 {
				audio_play_sound(asset_get_index("snd_ev_hammer_judge"), 10, false)	
			}
		}
		else {
			if judge_animation_timer == 30 {
				state = hammer_states.idle
				judge_animation_timer = 0;
			}	
		}
	}
}

	