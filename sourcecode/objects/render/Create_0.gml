application_surface_draw_enable(false)
surface_resize(application_surface, WIDTH, HEIGHT)
//display_set_gui_size(960, 540)
display_set_gui_maximize()

depth = 100

draw_set_font(ft_debug)

#region Shockwave shader

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
		image : 3
	}
	array_push(shockwave_waves, newWave)
	return newWave
}

#endregion

#region Title Metaball Shader

tMeta_shader = shd_metaballTitle;

tMeta_u_iRes = shader_get_uniform(tMeta_shader, "iResolution")
tMeta_u_iTime = shader_get_uniform(tMeta_shader, "iGlobalTime")

tMeta_lagFlag = false
tMeta_lagAve = 60

#endregion

#region Blur Shader

blur_shader = shd_blur;
blur_u_blurAmount = shader_get_uniform(blur_shader, "blurAmount");
blur_u_sigma = shader_get_uniform(blur_shader, "sigma");
blur_u_texelSize = shader_get_uniform(blur_shader, "texelSize");
blur_u_blurVector = shader_get_uniform(blur_shader, "blurVector");

blur_surface = -1;

blur_surf_ping = -1;

#endregion

#region Outline Shader

outline_shader = shd_outline
outline_u_color = shader_get_uniform(outline_shader, "u_color")
outline_u_pixelSize = shader_get_uniform(outline_shader, "u_pixelSize")
outline_u_thickness = shader_get_uniform(outline_shader, "u_thickness")

#endregion

#region Water Shader

water_shader = shd_wave;
water_u_iTime = shader_get_uniform(water_shader, "iTime");
water_u_iPos = shader_get_uniform(water_shader, "iPos");
// TODO: offset water wave to follow the background speed


#endregion

#region Bullets

bullet_surf = -1
bullet_playerSurf = -1

#endregion

focusAnimCurve = new AnimCurve( , 1, 0);
game_focus_set(false);
focusAnimCurve.percent = 1;

background_surf = -1;
shadowtemp_surf = -1;
watertemp_surf = -1;
underwatertemp_surf = -1;

application_surf = -1;

backgroundOrder = [];
currentBackground = 0;
newBackground = 0;
backgroundY = 0;
backgroundTotalY = 0;
backgroundLastY = 0;
newBackgroundSpeed = 2;
backgroundSpeed = 2;
backgroundSpeedAccel = 0.02;

screenShakeX = 0;
screenShakeY = 0;

scoreAnim = 0

refreshApplicationSurf = function(){
	surface_set_target(application_surf)
	draw_surface(application_surface, 0, 0)
	surface_reset_target()
}

blendmodeSet = function(_mode){
	shader_set(_mode)
	texture_set_stage(shader_get_sampler_index(_mode, "u_destination"), surface_get_texture(application_surf))
}

