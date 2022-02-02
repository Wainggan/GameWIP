if global.gameActive exit
if tMeta_lagFlag exit
var l = tMeta_lagAve
tMeta_lagAve = lerp(tMeta_lagAve, fps, 0.2)
if current_time/1000 >= 2 && tMeta_lagAve < 40 && tMeta_lagAve < l tMeta_lagFlag = true
shader_set(tMeta_shader)
shader_set_uniform_f(tMeta_u_iRes, 512, 480)
shader_set_uniform_f(tMeta_u_iTime, global.time / 60)
draw_sprite_stretched(spr_pixel, 0, 0, 0, window_get_width(), window_get_height())
shader_reset()

