
if !keyboard_check(ord("H")) {

// multiply post

var _colList = [c_blue, c_fuchsia, c_purple, c_aqua, c_orange]
gpu_set_tex_filter(true)
gpu_set_blendmode_ext(bm_dest_colour, bm_zero); // multiply
//gpu_set_blendmode_ext_sepalpha(bm_dest_colour, bm_zero, bm_src_alpha, bm_inv_src_alpha);
shader_set(shd_multiplyHelper)
	
	for (var i = 0; i < 5; i++) {
		var _rnd = i * 3.141 * 2.0 + 0.412;
		var _col = _colList[wrap(i, 0, array_length(_colList))]
		var _posX = sin(global.time / 200.0 * 0.9212 + _rnd * 0.6512) * WIDTH / 2;
		var _posY = cos(global.time / 200.0 * 1.0442 + _rnd * 0.1264) * HEIGHT / 2;
		draw_sprite_ext(spr_atmosphere, 0, WIDTH / 2 + _posX, HEIGHT / 2 + _posY, 5, 5, 0, _col, 0.04)
	}
	
shader_reset()
gpu_set_blendmode(bm_normal)
gpu_set_tex_filter(false)


// overlay post

surface_set_target(background_surf)
draw_surface(application_surface, 0, 0)
surface_reset_target()

var _col = c_blue
shader_set(shd_blend_overlay)

	draw_surface_ext(background_surf, 0, 0, 1, 1, 0, _col, 0.03)
	
shader_reset()

}


with obj_bullet {
	if object_index == obj_bullet
		draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale + fade/fadeTime + pop * 0.1, image_yscale + fade/fadeTime + pop * 0.1, image_angle, innerGlow, image_alpha-fade/fadeTime);
	else {
		draw_sprite_ext(spr_laser_head, 0, round(x), round(y), 1, image_yscale, image_angle, c_white, image_alpha);
		draw_sprite_ext(spr_laser, 0, round(x + lengthdir_x(30, image_angle)), round(y + lengthdir_y(30, image_angle)), image_xscale, image_yscale, image_angle, c_white, image_alpha);
	}
		
}


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