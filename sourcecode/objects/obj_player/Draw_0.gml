if input.check_pressed("sneak") {
	//hitboxAnim.add(new Tween(0.25, 0, 1, function(_e){ hitboxSize = _e }, "backBig"))
	hitboxAnim.setWeights(8, 2, 2.5)
} else if input.check_released("sneak") {
	//hitboxAnim.add(new Tween(0.25, 1, 0, function(_e){ hitboxSize = _e }, "ease"))
	hitboxAnim.setWeights(10, 1, 0)
}

var _t = global.delta_milliP

hitboxAnim.update(_t, input.check("sneak"));
hitboxSize = hitboxAnim.value;
hitboxAnimRotate += 0.8 * global.delta_multi

hook_ind_xAnim.update(_t, hook_x);
hook_ind_yAnim.update(_t, hook_y);
hook_ind_showAnim.update(_t, hook_maybeTarget != noone ? 1 : 0);

hook_line_showAnim.update(_t, hook_ing);

hook_icon_xAnim.update(_t, hook_x);
hook_icon_showAnim.update(_t, hook_maybeTarget != noone ? 1 : 0);
hook_icon_rotate += 1 * global.delta_multi

hook_focus_chargeAnim.update(_t, hook_focus_charge);


draw_set_alpha(grazeHitboxGraphicShow)
	draw_circle(round(x)-1, round(y)-1, grazeRadius - 6, 1)
draw_set_alpha(1)


var _offX = 0;
var _offY = 0;
if shakeAmount > 0 {
	_offX += round(random_range(-shakeAmount, shakeAmount))
	_offY += round(random_range(-shakeAmount/4, shakeAmount/4))
}
//surface_set_target(surf);
	//draw_clear_alpha(c_black, 0)

	var _img = 0;
	if abs(dir_graphic) <= slowMoveSpeed + 0.1 {
		if dir_graphic < 0 _img = 1;
		else if dir_graphic > 0 _img = 2;
	} else {
		if dir_graphic < 0 _img = 3;
		else if dir_graphic > 0 _img = 4;
	}

	image_index = _img;
	
	if sprite_index == spr_player_vee
		for (var i = 0; i < array_length(tails); i++) {
			for (var j = 0; j < array_length(tails[i]); j++) {
				var p = tails[i][j];
				var tailSize = max(parabola(-6, 10, 8, j) + 3, 6)
				draw_sprite_ext(spr_player_tail, 0, _offX + p.x, _offY + p.y, tailSize / 64, tailSize / 64, 0, #3e2b32, 1)
			}
		}

	draw_sprite_ext(sprite_index, _img, round(_offX + x), round( _offY + y), 1 * dir_graphic == 0 ? 1 : sign(dir_graphic), 1, 0, c_white, 1)
	
	if sprite_index == spr_player_vee
		for (var i = 0; i < array_length(tails); i++) {
			for (var j = 0; j < array_length(tails[i]); j++) {
				var p = tails[i][j];
				var tailSize = max(parabola(-6, 10, 8, j) + 3, 6)
				draw_sprite_ext(spr_player_tail, 0, _offX + p.x, _offY + p.y, (tailSize-2) / 64, (tailSize-2) / 64, 0, #cc8297, 1)
			}
		}
	
	lifeChargeGraphicX = 
		lerp(lifeChargeGraphicX, x, 1 - power(1 - 0.9999999, global.delta_milli * 2));
	lifeChargeGraphicY = 
		lerp(
			lifeChargeGraphicY, 
			y + 48 > HEIGHT ? y - 42 : y + 42, 
	1 - power(1 - 0.9999999, global.delta_milli * 2)
		);
	
	var _rad = 6, _outlineColor = merge_color(c_black, c_white, hook_charge)
	if hook_charge == 1
		_outlineColor = (global.time % 8) < 4 ? #ff44ff : c_white
	
	draw_set_color(_outlineColor)
	draw_set_alpha(hook_charge * 0.6 + 0.2)
	draw_circle_outline_part(round(lifeChargeGraphicX), round(lifeChargeGraphicY), _rad + 3, 2, hook_charge / 2, 270, false)
	draw_circle_outline_part(round(lifeChargeGraphicX), round(lifeChargeGraphicY), _rad + 3, 2, hook_charge / 2, 270, true)
	
	draw_circle_outline_part(round(lifeChargeGraphicX), round(lifeChargeGraphicY), _rad - 2, 1, hook_charge / 2, 270, false)
	draw_circle_outline_part(round(lifeChargeGraphicX), round(lifeChargeGraphicY), _rad - 2, 1, hook_charge / 2, 270, true)
	
	draw_set_color(c_blue)
	draw_set_alpha(0.4)
	draw_circle_outline_part(round(lifeChargeGraphicX), round(lifeChargeGraphicY), _rad, 4, hook_charge / 2, 270, false)
	draw_circle_outline_part(round(lifeChargeGraphicX), round(lifeChargeGraphicY), _rad, 4, hook_charge / 2, 270, true)
	
	draw_set_color(c_white)
	draw_set_alpha(1)
	//var _amount = 16;
	//var _size = 6;
	//for (var i = 0; i < round(_amount * hook_charge); i++) {
	//	draw_line_sprite(
	//		round(lifeChargeGraphicX) + lengthdir_x(_size, 360 / _amount / 2 * i - 90), 
	//		round(lifeChargeGraphicY) + lengthdir_y(_size, 360 / _amount / 2 * i - 90),
	//		round(lifeChargeGraphicX) + lengthdir_x(_size, 360 / _amount / 2 * (i + 1) - 90), 
	//		round(lifeChargeGraphicY) + lengthdir_y(_size, 360 / _amount / 2 * (i + 1) - 90),
	//		4, c_blue, 0.4
	//	);
	//	draw_line_sprite(
	//		round(lifeChargeGraphicX) + lengthdir_x(_size, 360 / _amount / 2 * -i - 90), 
	//		round(lifeChargeGraphicY) + lengthdir_y(_size, 360 / _amount / 2 * -i - 90),
	//		round(lifeChargeGraphicX) + lengthdir_x(_size, 360 / _amount / 2 * (-i - 1) - 90), 
	//		round(lifeChargeGraphicY) + lengthdir_y(_size, 360 / _amount / 2 * (-i - 1) - 90),
	//		4, c_blue, 0.4
	//	);
	//}
//surface_reset_target()

draw_line_sprite(x, y, hook_x, hook_y, hook_line_showAnim.value * 4, c_white, 1);

if hook_ing {
	//draw_sprite(spr_playerHookAim, 0, x, y - 16);
}

draw_set_color(c_white);
var prog = hook_focus_chargeAnim.value / hook_focus_limit;
draw_line_sprite(2, HEIGHT-3, prog*(WIDTH/2-2)+2, HEIGHT-3, 3);
draw_line_sprite(WIDTH-2, HEIGHT-3, WIDTH-prog*(WIDTH/2-2)+2, HEIGHT-3, 3);

var _amount = 3;

var _size = 0;
_size += hitboxAnim.value * ((hitboxAnim.value - 1) * 0.8 + 1) * grazeRadius
_size = max(_size, 2)
if hitboxAnim.value > 0.1
	_size += wave(-4, 4, 24)

for (var i = 0; i < _amount; i++) {
	draw_sprite(
		spr_player_hitboxFlair, 0,
		round(x) + lengthdir_x(_size, 360 / _amount * i + 90 + hitboxAnimRotate), 
		round(y) + lengthdir_y(_size, 360 / _amount * i + 90 + hitboxAnimRotate)
	);
}
for (var i = 0; i < _amount; i++) {
	draw_sprite(
		spr_player_hitboxFlair, 0,
		round(x) + lengthdir_x(_size, 360 / _amount * i + 90 + -hitboxAnimRotate), 
		round(y) + lengthdir_y(_size, 360 / _amount * i + 90 + -hitboxAnimRotate)
	);
}



//draw_surface(surf, 0, 0);