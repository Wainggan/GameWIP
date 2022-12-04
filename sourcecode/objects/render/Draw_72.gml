if !surface_exists(bullet_surf)
	bullet_surf = surface_create(WIDTH, HEIGHT)
if !surface_exists(bullet_playerSurf)
	bullet_playerSurf = surface_create(WIDTH, HEIGHT)

if !surface_exists(blur_surface)
	blur_surface = surface_create(WIDTH, HEIGHT);
if !surface_exists(blur_surf_ping)
	blur_surf_ping = surface_create(WIDTH, HEIGHT);
	
//if !surface_exists(water_surf)
//	water_surf = surface_create(WIDTH, HEIGHT);

if !global.gameActive exit

var _currentB = backgroundOrder[currentBackground];
var _newB = backgroundOrder[newBackground];

#region background layer logic
	
backgroundSpeed = approach(backgroundSpeed, newBackgroundSpeed, backgroundSpeedAccel);
backgroundY += global.delta_multi * backgroundSpeed;
		
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

//surface_set_target(water_surf);
//	draw_clear_alpha(c_black, 0);
	
#region blur

//surface_reset_target()

surface_set_target(blur_surface);
	draw_clear(c_black)
	
	// draw background layer
	
	// draw emergency tile
	
	draw_sprite_tiled_ext(spr_debug, 0, 0, global.time, 1, 1, merge_color(c_white, c_black, 0.4), 1);
	
	// draw water
	
	//draw_surface(water_surf, 0, 0);
	
	// draw background
	
	draw_set_color(c_white)
		
	_currentB.draw(_lastBY);
	_newB.draw(_lastBY - (_newB.height * 16));
	
	
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


surface_set_target(bullet_playerSurf)
	draw_clear_alpha(c_black, 0)
		with obj_laser_player {
			if activeAnim != 0 {
				draw_sprite_ext(spr_player_laser_head, 0, round(x), round(y), 1, image_yscale, image_angle, image_blend, image_alpha);
				draw_sprite_ext(spr_player_laser, 0, round(x) + lengthdir_x(32, image_angle), round(y) + lengthdir_y(32, image_angle), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
			}
		}
		with obj_bullet_player {
			draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale + fade/fadeTime, image_yscale + fade/fadeTime, image_angle, image_blend, image_alpha-fade/fadeTime);
		}
		
surface_reset_target()


surface_set_target(bullet_surf)
	draw_clear_alpha(c_black, 0)
	
	draw_surface_ext(bullet_playerSurf, 0, 0, 1, 1, 0, c_white, 1)
	
	gpu_set_blendmode(bm_add)
		with obj_bullet {
			var _glow = merge_color(glowTarget, c_white, pop * 0.5);
			if object_index == obj_bullet
				draw_sprite_ext(sprite_index, 1, round(x), round(y), image_xscale + fade/fadeTime + pop * 0.2, image_yscale + fade/fadeTime + pop * 0.2, image_angle, _glow, image_alpha-fade/fadeTime);
			else {
				draw_sprite_ext(spr_laser_head, 1, round(x), round(y), 1, image_yscale + pop * 0.2, image_angle, _glow, image_alpha);
				draw_sprite_ext(spr_laser, 1, round(x + lengthdir_x(30, image_angle)), round(y + lengthdir_y(30, image_angle)), image_xscale, image_yscale + pop * 0.2, image_angle, _glow, image_alpha);
			}
		}
	gpu_set_blendmode(bm_normal)
surface_reset_target()

draw_surface_ext(bullet_surf, 0, 0, 1, 1, 0, c_white, 0.6)