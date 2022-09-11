var winWidth = window_get_width();
var winHeight = window_get_height();

x = (winWidth/2-WIDTH/2)+WIDTH/8;
y = 16
x += screenShakeX;
y += screenShakeY;




surface_set_target(bullet_playerSurf)
	draw_clear_alpha(c_black, 0)
		with obj_bullet_player {
			draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale + fade/fadeTime, image_yscale + fade/fadeTime, image_angle, image_blend, image_alpha-fade/fadeTime);
		}
surface_reset_target()


surface_set_target(bullet_surf)
	draw_clear_alpha(c_black, 0)
	
	draw_surface_ext(bullet_playerSurf, 0, 0, 1, 1, 0, c_white, 1)
	
	gpu_set_blendmode(bm_add)
		with obj_bullet {
			var _glow = merge_color(glow, c_white, pop * 0.5);
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