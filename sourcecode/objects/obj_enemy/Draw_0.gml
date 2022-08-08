hitAnim = approach(hitAnim, 0, 0.2 * global.delta_multi)

if hitAnim != 0 {
	shader_set(shd_color)
	shader_set_uniform_f(shader_get_uniform(shd_color, "colorAmount"), hitAnim)
	shader_set_uniform_f(shader_get_uniform(shd_color, "colorTarget"), 1, 1, 1)
	draw_sprite_ext(sprite_index, image_index, round(x + xOff), round(y + yOff), image_xscale + hitAnim/4, image_yscale + hitAnim/4, image_angle, image_blend, image_alpha)
	shader_reset()
} else {
	draw_sprite(sprite_index, image_index, round(x + xOff), round(y + yOff))
}