

// multiply post

var _colList = look_atmosphere_colors.value
gpu_set_tex_filter(true)
gpu_set_blendmode_ext(bm_dest_colour, bm_zero); // multiply
//gpu_set_blendmode_ext_sepalpha(bm_dest_colour, bm_zero, bm_src_alpha, bm_inv_src_alpha);
shader_set(shd_multiplyHelper)
	
	for (var i = 0; i < array_length(_colList); i++) {
		var _rnd = i * 3.141 * 2.0 + 0.412;
		var _col = _colList[wrap(i, 0, array_length(_colList))].value
		var _posX = sin(global.time / 200.0 * 0.9212 + _rnd * 0.6512) * WIDTH / 2;
		var _posY = cos(global.time / 200.0 * 1.0442 + _rnd * 0.1264) * HEIGHT / 2;
		draw_sprite_ext(
			spr_atmosphere, 0, WIDTH / 2 + _posX, HEIGHT / 2 + _posY,
			5, 5, 0, _col, look_atmosphere_strength.value)
	}
	
shader_reset()
gpu_set_blendmode(bm_normal)
gpu_set_tex_filter(false)


// overlay post

refreshApplicationSurf()

var _col = look_overlay_color.value
blendmodeSet(shd_blend_overlay)

	draw_rectangle_sprite(0, 0, WIDTH, HEIGHT, , _col, look_overlay_strength.value)
	
shader_reset()


// fix alpha
//gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_src_alpha, bm_one)

with obj_bullet {
	if object_index == obj_bullet
		draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale + fade/fadeTime + pop * 0.1, image_yscale + fade/fadeTime + pop * 0.1, image_angle, innerGlow, image_alpha-fade/fadeTime);
	else {
		draw_sprite_ext(spr_laser_head, 0, round(x), round(y), 1, image_yscale, image_angle, c_white, image_alpha);
		draw_sprite_ext(spr_laser, 0, round(x + lengthdir_x(30, image_angle)), round(y + lengthdir_y(30, image_angle)), image_xscale, image_yscale, image_angle, c_white, image_alpha);
	}
}

//gpu_set_blendmode(bm_normal)



draw_set_halign(fa_center)

draw_set_font(ft_splash)

var _tf1 = 0, _tc1 = 0, _tf2 = 0, _tc2 = 0

var _lastcolor = draw_get_color()

with obj_specialText_score {
	if draw_get_font() != font {
		_tf1++
		draw_set_font(font)
	}
	if _lastcolor != color {
		draw_set_color(color); 
		_lastcolor = color;
		
		_tc1++
	}
	
	draw_text_transformed(round(x), round(y), text, 1, min(life / 4, 1), 0)
}

draw_set_font(ft_damage)

with obj_specialText_damage {
	if draw_get_font() != font {
		_tf2++
		draw_set_font(font)
	}
	if _lastcolor != color {
		draw_set_color(color); 
		_lastcolor = color;
		_tc2++
	}
	
	var _scale = 1
	if font == ft_bigdamage
		_scale = 3
	
	draw_text_transformed(round(x), round(y), text, 1 * _scale, min(life / 4, 1) * _scale, 0)
}

draw_set_color(c_white)

draw_set_color(#aaaaaa)
draw_set_font(ft_combo)

with obj_flavorText {
	draw_set_alpha(min(life / 10, 0.7))
	draw_text_transformed(round(x), round(y), text, scale, scale, 0)
}

draw_set_alpha(1)

draw_set_color(c_white)

draw_set_halign(fa_left)
draw_set_font(ft_debug)

//refreshApplicationSurf()
//blendmodeSet(shd_blend_invert)
with obj_player draw_sprite_ext(spr_playerTarget, 0, hook_ind_xAnim.value, hook_ind_yAnim.value, hook_ind_showAnim.value, hook_ind_showAnim.value, 0, c_white, 1)
//shader_reset()

with obj_player draw_sprite_ext(spr_player_hitbox, 0, round(x), round(y), hitboxSize, hitboxSize, 0, c_white, 1)



