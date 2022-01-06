var winWidth = window_get_width();
var winHeight = window_get_height();

var gameSurfaceX = (winWidth/2-WIDTH/2)+WIDTH/8;
var gameSurfaceY = 16



if (array_length(shockwave_waves) > 0) {
	
	var fxStrength = -0.04
	
	if !surface_exists(shockwave_surf_waves) {
		shockwave_surf_waves = surface_create(WIDTH * shockwave_surf_wavesScale, HEIGHT * shockwave_surf_wavesScale)
		shockwave_texWaves = surface_get_texture(shockwave_surf_waves)
	}
	
	gpu_set_tex_filter(true)
	
	surface_set_target(shockwave_surf_waves)
		draw_clear_alpha($FF7F7F, 1);
		gpu_set_blendmode_ext(bm_dest_color, bm_src_color);
		
		shader_set(shd_addNormals);
		for (var i = 0; i < array_length(shockwave_waves); i++) {
			var w = shockwave_waves[i]
			draw_sprite_ext(shockwave_sprite, w.image, 
				w.x * shockwave_surf_wavesScale, 
				w.y * shockwave_surf_wavesScale, 
				w.scale * shockwave_surf_wavesScale,
				w.scale * shockwave_surf_wavesScale, 0, c_white, w.alpha)
		}
		shader_reset()
		gpu_set_blendmode(bm_normal)
	surface_reset_target()
	
	gpu_set_tex_filter(false)
	
	shader_set(shd_shockwave_distort)
		shader_set_uniform_f(shockwave_u_fxstrength, fxStrength)
		shader_set_uniform_f(shockwave_u_aspect, WIDTH / HEIGHT)
		texture_set_stage(shockwave_u_texWaves, shockwave_texWaves)
		draw_surface(application_surface, gameSurfaceX, gameSurfaceY)
	shader_reset()
	
	ignore draw_surface_ext(shockwave_surf_waves, 0, 0, 1, 1, 0, c_white, 0.5)
	
	
	
	
} else {
	draw_surface(application_surface, gameSurfaceX, gameSurfaceY)
}

