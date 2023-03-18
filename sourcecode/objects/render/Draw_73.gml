
surface_set_target(bullet_surf)
	draw_clear_alpha(c_black, 0)
	gpu_set_blendmode(bm_add);
with obj_bullet {
	if object_index == obj_bullet
		draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale + fade/fadeTime + pop * 0.1, image_yscale + fade/fadeTime + pop * 0.1, image_angle, #f5f5f5, image_alpha-fade/fadeTime);
	else {
		draw_sprite_ext(spr_laser_head, 0, round(x), round(y), 1, image_yscale, image_angle, #f5f5f5, image_alpha);
		draw_sprite_ext(spr_laser, 0, round(x + lengthdir_x(30, image_angle)), round(y + lengthdir_y(30, image_angle)), image_xscale, image_yscale, image_angle, #f5f5f5, image_alpha);
	}
		
}
gpu_set_blendmode(bm_normal)
surface_reset_target()

draw_surface(bullet_surf, 0, 0)

draw_set_font(ft_splash)
draw_set_halign(fa_center)

//shader_set(tColor_shader)

//texture_set_stage(shader_get_sampler_index(tColor_shader, "otherTexture"), surface_get_texture(application_surface))
draw_set_color(make_color_rgb(220, 220, 220))

with obj_specialText {
	//if !(life <= 4 && life % 2 < 1)
	draw_text_transformed(round(x), round(y), text, 1, min(life / 4, 1), 0)
}
//shader_reset()

draw_set_color(c_white)

draw_set_halign(fa_left)
draw_set_font(ft_debug)

with obj_player draw_sprite_ext(sprite_index, 5, round(x), round(y), hitboxSize, hitboxSize, 0, c_white, 1)