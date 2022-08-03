// TODO: get the bullet glow drawn as metaballs :3

if !surface_exists(surf_bullet) {
	surf_bullet = surface_create(WIDTH, HEIGHT)
}
if !surface_exists(surf_playerBullet) {
	surf_playerBullet = surface_create(WIDTH, HEIGHT)
}

surface_set_target(surf_playerBullet)
	draw_clear_alpha(c_black, 0)
		with obj_bullet_player {
			draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale + fade/fadeTime, image_yscale + fade/fadeTime, image_angle, image_blend, image_alpha-fade/fadeTime);
	
		}
surface_reset_target()


surface_set_target(surf_bullet)
	draw_clear_alpha(c_black, 0)
	
	draw_surface_ext(surf_playerBullet, 0, 0, 1, 1, 0, c_white, 0.9)
		
	gpu_set_blendmode(bm_add)
		with obj_bullet {
			draw_sprite_ext(sprite_index, 1, round(x), round(y), image_xscale + fade/fadeTime, image_yscale + fade/fadeTime, image_angle, merge_color(glow, c_white, (highlight ? ((global.time % 8) >= 4 ? 0 : 0.3 ) : 0)), image_alpha-fade/fadeTime);
	
		}
	gpu_set_blendmode(bm_normal)
surface_reset_target()

draw_surface_ext(surf_bullet, 0, 0, 1, 1, 0, c_white, 0.6)