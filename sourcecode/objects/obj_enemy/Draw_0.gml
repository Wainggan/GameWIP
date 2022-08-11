hitAnim = approach(hitAnim, 0, 0.2 * global.delta_multi)

switch sprite_index {
	case spr_enemy_flower:
		image_angle = wave(-20, 20, 2, test);
	case spr_enemy_crystal:
		image_angle = wave(-10, 10, 4, test);
	case spr_enemy_thing:
		image_index = 0
		test += global.delta_multi;
		for (var i = 0; i < 3; i++) {
			draw_sprite(sprite_index, 1, x + lengthdir_x(32, test + 360 / 3 * i), y + lengthdir_y(32, test + 360 / 3 * i))
		}
		for (var i = 0; i < 3; i++) {
			draw_sprite(sprite_index, 1, x + lengthdir_x(32, -test + 360 / 3 * i), y + lengthdir_y(32, -test + 360 / 3 * i))
		}
	case spr_enemy_cat:
		yOff = wave(-2, 2, 3, test)
}

if hitAnim != 0 {
	shader_set(shd_color)
	shader_set_uniform_f(shader_get_uniform(shd_color, "colorAmount"), hitAnim)
	shader_set_uniform_f(shader_get_uniform(shd_color, "colorTarget"), 1, 1, 1)
	draw_sprite_ext(sprite_index, image_index, round(x + xOff), round(y + yOff), image_xscale + hitAnim/4, image_yscale + hitAnim/4, image_angle, image_blend, image_alpha)
	shader_reset()
} else {
	draw_sprite_ext(sprite_index, image_index, round(x + xOff), round(y + yOff), image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}