var winWidth = window_get_width();
var winHeight = window_get_height();

scale = min(floor(winWidth / WIDTH), floor(winHeight / HEIGHT))
scale = max(scale, 0)

x = (winWidth/2- WIDTH/2*scale )+WIDTH/8;
y = (winHeight/2-HEIGHT/2*scale )
x += screenShakeX;
y += screenShakeY;



surface_set_target(bullet_playerSurf)
	draw_clear_alpha(c_black, 0)
		with obj_laser_player {
			if activeAnim != 0 {
				draw_sprite_ext(spr_player_laser_head, 0, round(x), round(y), 1, image_yscale, image_angle, image_blend, image_alpha);
				draw_sprite_ext(spr_player_laser, 0, round(x) + lengthdir_x(32, image_angle), round(y) + lengthdir_y(32, image_angle), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
			}
		}
		with obj_bullet_player {
			draw_sprite_ext(sprite_index, image_index, round(x), round(y), image_xscale + fade/fadeTime, image_yscale + fade/fadeTime, image_angle, image_blend, image_alpha-fade/fadeTime);
		}
		
surface_reset_target()


surface_set_target(bullet_surf)
	draw_clear_alpha(c_black, 0)
	
	shader_set(outline_shader)
	shader_set_uniform_f(outline_u_color, 1, 0.96, 1, 0.96)
	shader_set_uniform_f(outline_u_thickness, 2)
	shader_set_uniform_f(outline_u_pixelSize, 
		1 / surface_get_width(bullet_playerSurf),
		1 / surface_get_height(bullet_playerSurf),
	);
		draw_surface_ext(bullet_playerSurf, 0, 0, 1, 1, 0, c_white, 1)
	shader_reset()
	
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

// fix alpha
//gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_src_alpha, bm_one)

draw_surface_ext(bullet_surf, 0, 0, 1, 1, 0, #dddddd, 0.66)

//gpu_set_blendmode(bm_normal)
