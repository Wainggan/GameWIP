if !surface_exists(blur_surface)
	blur_surface = surface_create(WIDTH, HEIGHT);
if !surface_exists(blur_surf_ping)
	blur_surf_ping = surface_create(WIDTH, HEIGHT);



surface_set_target(blur_surface);
	draw_clear(c_black)
	draw_sprite_tiled_ext(spr_debug, 0, 0, global.time, 1, 1, merge_color(c_white, c_black, 0.4), 1);
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