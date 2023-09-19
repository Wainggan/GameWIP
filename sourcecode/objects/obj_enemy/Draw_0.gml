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
		image_index = 0
		break;
	case spr_enemy_thing:
		image_index = 0
		test += global.delta_multi;
		for (var i = 0; i < 3; i++) {
			draw_sprite(sprite_index, 2, x + lengthdir_x(32, test + 360 / 3 * i), y + lengthdir_y(28, test + 360 / 3 * i))
			draw_sprite(sprite_index, 2, x + lengthdir_x(32, -test + 360 / 3 * i), y + lengthdir_y(28, -test + 360 / 3 * i))
		}
		ignore for (var i = 0; i < 3; i++) {
			//draw_sprite(sprite_index, 3, x + lengthdir_x(32, test + 360 / 3 * i), y + lengthdir_y(28, test + 360 / 3 * i))
			//draw_sprite(sprite_index, 3, x + lengthdir_x(32, -test + 360 / 3 * i), y + lengthdir_y(28, -test + 360 / 3 * i))
		}
		break;
	case spr_enemy_cat:
		yOff = wave(-2, 2, 3, test);
		break;
}

if sprite_boss {
	moveAnim.update(global.delta_milliP, clamp(lastX - x, -7, 7))
	image_angle = moveAnim.value * 1.5
	image_index = 0;
	yOff = wave(-1, 2, 3);
	if abs(moveAnim.value) > 1 image_index = 1
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


var _x = x
var _y = y

if _y < 96
	_y = lerp(_y, 96, 0.4)

showHp_x = lerp(showHp_x, _x, 1 - power(1 - 0.999, global.delta_milliP))
showHp_y = lerp(showHp_y, _y, 1 - power(1 - 0.999, global.delta_milliP))

// draw boss hp bar
if phaseActive && currentPhase < array_length(showHp_scale) {	
	
	var _x = round(showHp_x)
	var _y = round(showHp_y)
	
	showHp_anim = approach(showHp_anim, 1, 0.04 * global.delta_multi)

	var _currentpercent = hp / maxhp
	var _totalpercent = 0

	for (var i = array_length(showHp_scale) - 1; i >= currentPhase + 1; i--) {
		_totalpercent += showHp_scale[i] / showHp_total
	}

	var _newpercent = showHp_scale[currentPhase] / showHp_total * _currentpercent

	var _percent = _totalpercent + _newpercent
	
	var _danger = 1 - clamp(_percent * 4, 0, 1)
	
	var _flashingColor = global.time % 6 <= 3 ? #ff30ff : #30ffff
	
	draw_set_color(merge_color(#100010, _flashingColor, _danger))
	draw_set_alpha(0.5)
	
	draw_circle_outline(_x, _y, 64, 4 * min(1, showHp_anim * 2))
	
	draw_set_alpha(0.8)
	draw_set_color(merge_color(c_white, #ff5060, _danger))

	draw_circle_outline_part(_x, _y, 64, 6 * showHp_anim, _percent / 2 * showHp_anim, 270, false)
	draw_circle_outline_part(_x, _y, 64, 6 * showHp_anim, _percent / 2 * showHp_anim, 270, true)
	
	draw_set_color(c_white)
	draw_set_alpha(1)

	var _offset = 0
	for (var i = 0; i < array_length(showHp_scale); i++) {
		var _totalpercent = showHp_scale[i] / showHp_total
		_offset += _totalpercent
		
		var _dir = 360 * _offset / 2
		var _scale = abs(360 * (1 - _offset) - 360 * _percent)
		_scale = 3 - clamp(_scale / 8, 0, 2)
		_scale *= showHp_anim
		
		if i >= currentPhase && i < currentPhase + 2 {
			draw_circle(_x + lengthdir_x(64 - 6, 90 - _dir), _y + lengthdir_y(64 - 6, 90 - _dir), _scale, false)
			draw_circle(_x + lengthdir_x(64 - 6, 90 + _dir), _y + lengthdir_y(64 - 6, 90 + _dir), _scale, false)
		}
	}
	
}
