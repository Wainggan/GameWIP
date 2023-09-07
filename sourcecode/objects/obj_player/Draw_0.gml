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

hook_ind_xAnim.update(_t, hook_x);
hook_ind_yAnim.update(_t, hook_y);
hook_ind_showAnim.update(_t, hook_maybeTarget != noone ? 1 : 0);

hook_line_showAnim.update(_t, hook_ing);

hook_icon_xAnim.update(_t, hook_x);
hook_icon_showAnim.update(_t, hook_maybeTarget != noone ? 1 : 0);
hook_icon_rotate += 1 * global.delta_multi

hook_focus_chargeAnim.update(_t, hook_focus_charge);

var _focusIntensity = clamp(hook_focus_chargeAnim.value - (hook_focus_limit - 1) + hook_focus_active * (hook_focus_limit - 1), 0, 1)
if hook_focus_charge == hook_focus_limit || hook_focus_active {

	gpu_set_blendmode(bm_add)
	var _col = [c_fuchsia, c_aqua]
	_col = _col[global.time % 12 <= 6]
	if global.time % 6 <= 3
		draw_sprite_ext(spr_atmosphere, 0, x, y, 2, 2, 0, _col, _focusIntensity * 0.06)
	
	gpu_set_blendmode(bm_normal)

}


draw_set_alpha(grazeHitboxGraphicShow)
	draw_circle(round(x)-1, round(y)-1, grazeRadius - 6, 1)
draw_set_alpha(1)


offX = 0;
offY = 0;
if shakeAmount > 0 {
	offX += round(random_range(-shakeAmount, shakeAmount))
	offY += round(random_range(-shakeAmount/4, shakeAmount/4))
}
//surface_set_target(surf);
	//draw_clear_alpha(c_black, 0)
	
	//var _col_tail = #cc8297, _col_outline = #3e2b32
	var _col_tail = #dc7b95, _col_outline = #3e2b32

	var _img = 0;
	if abs(dir_graphic) <= slowMoveSpeed + 0.1 {
		if dir_graphic < 0 _img = 1;
		else if dir_graphic > 0 _img = 2;
	} else {
		if dir_graphic < 0 _img = 3;
		else if dir_graphic > 0 _img = 4;
	}
	
	_img = 0

	image_index = _img;
	
	ignore if true || sprite_index == spr_player_vee
		for (var i = 0; i < array_length(tails); i++) {
			for (var j = 0; j < array_length(tails[i]); j++) {
				var p = tails[i][j];
				var tailSize = p.size
				//draw_sprite_ext(spr_player_tail, 0, _offX + p.x, _offY + p.y, tailSize / 64, tailSize / 64, 0, _col_outline, 1)
			}
		}
	
	var _flip = 1 * dir_graphic == 0 ? 1 : sign(dir_graphic)
	_flip = 1;
	
	//sprite_index = keyboard_check(190) ? spr_player_vee : spr_player_vii
	
	moveAnim.update(_t, clamp(x_vel, -7, 7))
	
	draw_sprite_ext(sprite_index, _img, round(offX + x), round(offY + y), _flip, 1, moveAnim.value * -1.5, c_white, 1)
	
	ignore hairTuft.loop(function(_p, i, _points) {
		if i == 0 return;
		
		draw_sprite_ext(sprite_index, 1, _points[i - 1].x, _points[i - 1].y, 1, 1, _p.dir + 90, c_white, 1)
	})
	
	
	if true || sprite_index == spr_player_vee
		for (var i = 0; i < array_length(tails); i++) {
			
			tails[i].loop(function(_p, j) {
				draw_sprite_ext(spr_player_tail, 0, offX + _p.x, offY + _p.y, _p.size / 64, _p.size / 64, 0, #ff7d9f, 1)
			})
			
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
		
	
	// fix alpha
	gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_src_alpha, bm_one)
	
	draw_set_color(_outlineColor)
	draw_set_alpha(hook_charge * 0.6 + 0.1)
	
	var _x = round(lifeChargeGraphicX), _y = round(lifeChargeGraphicY)
	
	
	// outer outline
	draw_circle_outline_part(_x, _y, _rad + 3, 2, hook_charge / 2, 270, false)
	draw_circle_outline_part(_x, _y, _rad + 3, 2, hook_charge / 2, 270, true)
	
	// inner outline
	draw_circle_outline_part(_x, _y, _rad - 2, 1, hook_charge / 2, 270, false)
	draw_circle_outline_part(_x, _y, _rad - 2, 1, hook_charge / 2, 270, true)
	
	
	var _lowColor = c_white, _highColor = c_white;
	var _lowPrecent = 0, _highPrecent = 0;
	
	if hook_charge < graze_charge {
		_lowColor = #dd66ff
		_lowPrecent = hook_charge
		_highColor = #dd22dd
		_highPrecent = graze_charge
	} else {
		_lowColor = #dd66ff
		_lowPrecent = graze_charge
		_highColor = #2233ff
		_highPrecent = hook_charge
	}
	
	
	// inside graze charge
	draw_set_color(_highColor)
	draw_set_alpha(0.7)
	draw_circle_outline_part(_x, _y, _rad, 4, max(0, _highPrecent / 2 - _lowPrecent / 2), 270 + 180 * _lowPrecent, false)
	draw_circle_outline_part(_x, _y, _rad, 4, max(0, _highPrecent / 2 - _lowPrecent / 2), 270 - 180 * _lowPrecent, true)
	
	draw_set_color(_lowColor)
	draw_set_alpha(0.7)
	draw_circle_outline_part(_x, _y, _rad, 4, _lowPrecent / 2, 270, false)
	draw_circle_outline_part(_x, _y, _rad, 4, _lowPrecent / 2, 270, true)
	
	draw_set_color(c_white)
	draw_set_alpha(1)
	
	
	gpu_set_blendmode(bm_normal)
	
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
	draw_circle(x, y, hook_radius - 16, true)
	//draw_sprite(spr_playerHookAim, 0, x, y - 16);
}

draw_set_color(c_white);
var _prog = hook_focus_chargeAnim.value / hook_focus_limit;
var _thick = hook_focus_charge == hook_focus_limit ? 2 : 3
if (hook_focus_charge != hook_focus_limit || global.time % 8 <= 4) && hook_focus_chargeAnim.value > 0 {
	draw_line_sprite(2, HEIGHT-3, _prog*(WIDTH/2-2)+2, HEIGHT-3, _thick);
	draw_line_sprite(WIDTH-2, HEIGHT-3, WIDTH-_prog*(WIDTH/2-2)+2, HEIGHT-3, _thick);
}

var _amount = 3;

var _speed = 0.8
// gl
_speed += _focusIntensity * 5
hitboxAnimRotate += _speed * global.delta_multi
var _lineLength = max(3, _speed * 3)

var _size = 0;
_size += hitboxAnim.value * ((hitboxAnim.value - 1) * 0.8 + 1) * grazeRadius
_size = max(_size, 2)
if hitboxAnim.value > 0.1
	_size += wave(-4, 4, 24)

for (var i = 0; i < _amount; i++) {
	var _p = 360 / _amount * i + 90
	if hitboxAnim.value < 0.4 
		draw_sprite(
			spr_player_hitboxFlair, 0,
			round(x) + lengthdir_x(_size, _p + hitboxAnimRotate), 
			round(y) + lengthdir_y(_size, _p + hitboxAnimRotate)
		);
	else
		draw_line_sprite(
			round(x) + lengthdir_x(_size, _p + hitboxAnimRotate), 
			round(y) + lengthdir_y(_size, _p + hitboxAnimRotate),
			round(x) + lengthdir_x(_size, _p + hitboxAnimRotate - _lineLength), 
			round(y) + lengthdir_y(_size, _p + hitboxAnimRotate - _lineLength),
			2
		);
}
for (var i = 0; i < _amount; i++) {
	var _p = 360 / _amount * i + 90
	if hitboxAnim.value < 0.4 
		draw_sprite(
			spr_player_hitboxFlair, 0,
			round(x) + lengthdir_x(_size, _p + -hitboxAnimRotate), 
			round(y) + lengthdir_y(_size, _p + -hitboxAnimRotate)
		);
	else
		draw_line_sprite(
			round(x) + lengthdir_x(_size, _p + -hitboxAnimRotate), 
			round(y) + lengthdir_y(_size, _p + -hitboxAnimRotate),
			round(x) + lengthdir_x(_size, _p + -hitboxAnimRotate + _lineLength), 
			round(y) + lengthdir_y(_size, _p + -hitboxAnimRotate + _lineLength),
			2
		);
}



//draw_surface(surf, 0, 0);