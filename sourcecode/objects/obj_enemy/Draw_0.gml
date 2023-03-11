hitAnim = approach(hitAnim, 0, 0.2 * global.delta_multi)

var _offX = 0;
var _offY = 0;
if shakeAmount > 0 {
	_offX += round(random_range(-shakeAmount, shakeAmount))
	_offY += round(random_range(-shakeAmount/4, shakeAmount/4))
}

switch sprite_index {
	case spr_enemy_flower:
		image_angle = wave(-360, 360, 6, test);
		break;
	case spr_enemy_crystal:
		image_angle = wave(-10, 10, 4, test);
		break;
	case spr_enemy_thing:
		image_index = 0
		test += global.delta_multi;
		for (var i = 0; i < 3; i++) {
			draw_sprite(sprite_index, 1, x + lengthdir_x(32, test + 360 / 3 * i), y + lengthdir_y(28, test + 360 / 3 * i))
		}
		for (var i = 0; i < 3; i++) {
			draw_sprite(sprite_index, 1, x + lengthdir_x(32, -test + 360 / 3 * i), y + lengthdir_y(28, -test + 360 / 3 * i))
		}
		break;
	case spr_enemy_cat:
		yOff = wave(-2, 2, 3, test);
		break;
}

if hitAnim != 0 {
	shader_set(shd_color)
	shader_set_uniform_f(shader_get_uniform(shd_color, "colorAmount"), hitAnim)
	shader_set_uniform_f(shader_get_uniform(shd_color, "colorTarget"), 1, 1, 1)
	draw_sprite_ext(sprite_index, image_index, round(_offX + x + xOff), round(_offY + y + yOff), image_xscale + hitAnim/4, image_yscale + hitAnim/4, image_angle, image_blend, image_alpha)
	shader_reset()
} else {
	draw_sprite_ext(sprite_index, image_index, round(_offX + x + xOff), round(_offY + y + yOff), image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}