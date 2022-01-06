application_surface_draw_enable(false)
surface_resize(application_surface, WIDTH, HEIGHT)
//display_set_gui_size(960, 540)
display_set_gui_maximize()

draw_set_font(ft_debug)

surf_bullet = -1
surf_playerBullet = -1

{ // shockwave shader

shockwave_sprite = spr_shockwaves;

shockwave_shader = shd_shockwave_distort
shockwave_u_fxstrength = shader_get_uniform(shockwave_shader, "fxStrength")
shockwave_u_aspect = shader_get_uniform(shockwave_shader, "aspect")
shockwave_u_texWaves = shader_get_sampler_index(shockwave_shader, "texWaves")
shockwave_aspect = camera_get_view_width(view_camera[0]) / camera_get_view_height(view_camera[0])
shockwave_texWaves = -1;

shockwave_waves = [];

shockwave_surf_waves = -1
shockwave_surf_wavesScale = 1/2;

shockwave_create = function(inx = WIDTH/2, iny = HEIGHT/2, inlife=120){
	var newWave = {
		x : inx,
		y : iny,
		mode : 0,
		currentlife : 0,
		life : 120,
		scale : 0,
		scaleSpeed : 12,
		scaleTarget : 120,
		alpha : 1,
		image : 8
	}
	array_push(shockwave_waves, newWave)
	return newWave
}

}

scoreAnim = 0
lastScore = 0;
scoreAnimCurve = new AnimCurve("ease");