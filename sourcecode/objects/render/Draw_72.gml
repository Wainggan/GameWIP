if !surface_exists(bullet_surf)
	bullet_surf = surface_create(WIDTH, HEIGHT)
if !surface_exists(bullet_playerSurf)
	bullet_playerSurf = surface_create(WIDTH, HEIGHT)

if !surface_exists(blur_surface)
	blur_surface = surface_create(WIDTH, HEIGHT);
if !surface_exists(blur_surf_ping)
	blur_surf_ping = surface_create(WIDTH, HEIGHT);
	
if !surface_exists(shadowtemp_surf)
	shadowtemp_surf = surface_create(WIDTH, HEIGHT);
if !surface_exists(watertemp_surf)
	watertemp_surf = surface_create(WIDTH, HEIGHT);
	
if !surface_exists(background_surf)
	background_surf = surface_create(WIDTH, HEIGHT);
	
//if !surface_exists(water_surf)
//	water_surf = surface_create(WIDTH, HEIGHT);

if !global.gameActive exit

var _currentB = backgroundOrder[currentBackground];
var _newB = backgroundOrder[newBackground];

#region background layer logic
	
backgroundSpeed = approach(backgroundSpeed, newBackgroundSpeed, backgroundSpeedAccel);
backgroundY += global.delta_multi * backgroundSpeed;
backgroundTotalY += global.delta_multi * backgroundSpeed;
		
if backgroundY % (backgroundOrder[currentBackground].height * 16) < 
	backgroundLastY % (backgroundOrder[currentBackground].height * 16) {
	backgroundY -= backgroundOrder[currentBackground].height * 16;
	currentBackground = newBackground;
	if is_array(global.currentBackground) {
		newBackground = global.currentBackground[0];
		array_delete(global.currentBackground, 0, 1);
		if array_length(global.currentBackground) == 1 global.currentBackground = global.currentBackground[0]
	} else {
		newBackground = global.currentBackground;
	}
	newBackgroundSpeed = global.currentBackgroundSpeed;
}
if currentBackground == newBackground
	newBackgroundSpeed = global.currentBackgroundSpeed;
			
backgroundLastY = backgroundY;
		
var _currentB = backgroundOrder[currentBackground];
var _newB = backgroundOrder[newBackground];
		
var _lastBY = backgroundY % (_currentB.height * 16) - (_currentB.height - 30) * 16;
	
#endregion


surface_set_target(shadowtemp_surf)
	draw_clear_alpha(c_black, 0)
	
	/*
	// fml
	var _angleX = obj_player.x-mouse_x;
	var _angleY = obj_player.y-mouse_y;
	
	gpu_set_fog(true, c_black, 0, 1)
	
	with obj_player {
		draw_sprite_pos(
			sprite_index, image_index, 
			x-(sprite_width/2)+_angleX,
			y+_angleY,
			x+(sprite_width/2)+_angleX,
			y+_angleY,
			x+(sprite_width/2),
			y,
			x-(sprite_width/2),
			y, 
			1
		)
	}
	
	gpu_set_fog(false, c_black, 0, 1)
	
	*/
	
	with obj_player draw_sprite(spr_player_shadow, 0, x, y+32);
	
	with obj_enemy draw_sprite(spr_player_shadow, 0, x, y+32)

surface_reset_target()
surface_set_target(watertemp_surf)

	draw_clear_alpha(c_black, 0)
	
	draw_sprite_tiled_ext(spr_debug, 0, 0, _lastBY, 1, 1, merge_color(c_white, c_black, 0.4), 1);
	
	gpu_set_blendmode_ext(bm_dest_colour, bm_zero)
	
		draw_sprite_stretched_ext(spr_pixel, 0, 0, 0, WIDTH, HEIGHT, #3355bb, 1)
	
	gpu_set_blendmode(bm_add)
	
		draw_sprite_stretched_ext(spr_pixel, 0, 0, 0, WIDTH, HEIGHT, #5b5566, 1)
	
	gpu_set_blendmode(bm_normal)
	
	

surface_reset_target()
surface_set_target(background_surf) // draw underwater
	draw_clear_alpha(#95e6dc, 1)
	
	//show_debug_message(backgroundTotalY / HEIGHT / pi)
	shader_set(water_shader);
	shader_set_uniform_f(water_u_iTime, global.time);
	shader_set_uniform_f(water_u_iPos, backgroundTotalY / HEIGHT);
	
		draw_surface_ext(watertemp_surf, 0, 0, 1, 1, 0, merge_color(c_white, c_blue, 0.1), 1)
	
	//gpu_set_blendmode(bm_normal)
	shader_reset()
	
surface_reset_target()
surface_set_target(watertemp_surf) // draw reflections
	draw_clear_alpha(c_black, 0)
	//draw_clear_alpha(#68c3ed, 1)
	
	//draw_sprite_tiled_ext(spr_debug, 0, 0, global.time, 1, 1, merge_color(c_white, c_black, 0.4), 0.6);

	with obj_enemy {
		switch sprite_index {
			case spr_enemy_thing:
				image_index = 0
				test += global.delta_multi;
				for (var i = 0; i < 3; i++) {
					draw_sprite(sprite_index, 1, x + lengthdir_x(32, test + 360 / 3 * i), y - lengthdir_y(28, test + 360 / 3 * i) + sprite_height)
				}
				for (var i = 0; i < 3; i++) {
					draw_sprite(sprite_index, 1, x + lengthdir_x(32, -test + 360 / 3 * i), y - lengthdir_y(28, -test + 360 / 3 * i) + sprite_height)
				}
				break;
		}

		//show_debug_message(y)
		draw_sprite_ext(sprite_index, image_index, round(x + xOff), round(y - yOff + sprite_height), image_xscale, image_yscale*-1, image_angle, image_blend, image_alpha)
		
	}

	with obj_bullet {
		var _glow = merge_color(glowTarget, #ddbbdd, 0.7);
		if object_index == obj_bullet
			draw_sprite_ext(sprite_index, 1, round(x), round(y + 24), (image_xscale - fade/fadeTime) * 0.9, (image_yscale - fade/fadeTime) * 0.9, image_angle, _glow, image_alpha);
		else {
			//draw_sprite_ext(spr_laser_head, 1, round(x), round(y + 24), 1, image_yscale, image_angle, _glow, image_alpha);
			//draw_sprite_ext(spr_laser, 1, round(x + lengthdir_x(30, image_angle)), round(y + lengthdir_y(30, image_angle) + 24), image_xscale, image_yscale, image_angle, _glow, image_alpha);
		}
	}

	with obj_player {
		
		//if sprite_index == spr_player_vee
		ignore for (var i = 0; i < array_length(tails); i++) {
			for (var j = 0; j < array_length(tails[i]); j++) {
				var p = tails[i][j];
				var tailSize = p.size
				//draw_sprite_ext(spr_player_tail, 0, p.x, p.y + 64 - 12, tailSize / 64, tailSize / 64, 0, #3e2b32, 1)
			}
		}
		
		draw_sprite_ext(sprite_index, image_index, round(x), round(y+64), 1 * dir_graphic == 0 ? 1 : sign(dir_graphic), -1, 0, c_white, 1)
		
		//if sprite_index == spr_player_vee
		for (var i = 0; i < array_length(tails); i++) {
			for (var j = 0; j < array_length(tails[i]); j++) {
				var p = tails[i][j];
				var tailSize = p.size
				draw_sprite_ext(spr_player_tail, 0, p.x, p.y + 64 - 12, (tailSize-2) / 64, (tailSize-2) / 64, 0, #cc8297, 1)
			}
		}
		
	}
	
	
	

surface_reset_target()
surface_set_target(background_surf) // finalize reflections
	
	//draw_clear_alpha(c_black, 1)
	
	//draw_sprite_tiled_ext(spr_debug, 0, 0, global.time, 1, 1, merge_color(c_white, c_black, 0.4), 1);
	
	//gpu_set_blendmode_ext(bm_inv_dest_alpha, bm_one)
	
	shader_set(water_shader);
	shader_set_uniform_f(water_u_iTime, global.time);
	shader_set_uniform_f(water_u_iPos, backgroundTotalY / HEIGHT);
	
		draw_surface_ext(watertemp_surf, 0, 0, 1, 1, 0, merge_color(c_white, c_blue, 0.4), 1)
	
	//gpu_set_blendmode(bm_normal)
	shader_reset()
	
	_currentB.draw(_lastBY);
	_newB.draw(_lastBY - (_newB.height * 16));
	
	draw_surface_ext(shadowtemp_surf, 0, 0, 1, 1, 0, c_white, 0.6)
	
	

surface_reset_target()
	
#region blur

//surface_reset_target()

surface_set_target(blur_surface);

	draw_surface(background_surf, 0, 0);

	// draw dark filter
	draw_sprite_stretched_ext(spr_pixel, 0, 0, 0, WIDTH, HEIGHT, c_black, 0.4 * focusAnimCurve.evaluate());
surface_reset_target();

draw_surface(blur_surface, 0, 0);

if focusAnimCurve.evaluate() != 0 {
	shader_set(blur_shader)
		shader_set_uniform_f(blur_u_blurAmount, 10);
		shader_set_uniform_f(blur_u_sigma, 0.2);
		shader_set_uniform_f(blur_u_texelSize, 1 / WIDTH, 1 / HEIGHT);
	
		shader_set_uniform_f(blur_u_blurVector, 1, 0);
		surface_set_target(blur_surf_ping);
			draw_surface(blur_surface, 0, 0);
		surface_reset_target();
	
		shader_set_uniform_f(blur_u_blurVector, 0, 1);
		draw_surface_ext(blur_surf_ping, 0, 0, 1, 1, 0, c_white, 1 * focusAnimCurve.evaluate());
	shader_reset();
}

#endregion


