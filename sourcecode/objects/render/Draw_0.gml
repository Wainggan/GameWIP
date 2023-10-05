var winWidth = window_get_width();
var winHeight = window_get_height();

scale = min(winWidth / WIDTH, winHeight / HEIGHT)
scale = floor(scale)
scale = max(scale,1)

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

if keyboard_check_pressed(ord("1")) debugpause = !debugpause;

// bullet process for visibility + style

if !keyboard_check(ord("2")) {

// overlay for grey backgrounds and spice
refreshApplicationSurf()
blendmodeSet(shd_blend_difference)
gpu_set_blendmode_ext(bm_one, bm_zero)

//if keyboard_check(ord("1"))
draw_surface_ext(bullet_surf, 0, 0, 1, 1, 0, c_white, 0.5)

shader_reset()

// smoothens and averages the general brightness of colors
refreshApplicationSurf()
blendmodeSet(shd_blend_overlay)

//if keyboard_check(ord("2"))
draw_surface_ext(bullet_surf, 0, 0, 1, 1, 0, c_white, 0.3)

shader_reset()

// makes the brighter colors darker and the darker bright
refreshApplicationSurf()
blendmodeSet(shd_blend_allanon)

//if keyboard_check(ord("3"))
draw_surface_ext(bullet_surf, 0, 0, 1, 1, 0, c_white, 0.6)

shader_reset()

gpu_set_blendmode(bm_normal)

} else {
	draw_surface_ext(bullet_surf, 0, 0, 1, 1, 0, #eeeeee, 0.6)
}
