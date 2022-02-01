if global.gameActive exit
shader_set(tMeta_shader)
	shader_set_uniform_f(tMeta_u_iRes, 512, 480)
	shader_set_uniform_f(tMeta_u_iTime, global.time / 60)
	draw_sprite_stretched(spr_pixel, 0, 0, 0, window_get_width(), window_get_height())
	shader_reset()