if input.check_pressed("sneak") {
	//hitboxAnim.add(new Tween(0.25, 0, 1, function(_e){ hitboxSize = _e }, "backBig"))
	hitboxAnim.setWeights(8, 2, 2.5)
} else if input.check_released("sneak") {
	//hitboxAnim.add(new Tween(0.25, 1, 0, function(_e){ hitboxSize = _e }, "ease"))
	hitboxAnim.setWeights(10, 1, 0)
}
hitboxAnim.update(global.delta_milli, input.check("sneak"));
hitboxSize = hitboxAnim.value;

hook_ind_xAnim.update(global.delta_milli, hook_x);
hook_ind_yAnim.update(global.delta_milli, hook_y);
hook_ind_showAnim.update(global.delta_milli, hook_maybeTarget);

hook_line_showAnim.update(global.delta_milli, hook_ing);

hook_icon_xAnim.update(global.delta_milli, hook_x);
hook_icon_showAnim.update(global.delta_milli, hook_maybeTarget);
hook_icon_rotate += 1 * global.delta_multi


draw_set_alpha(grazeHitboxGraphicShow)
	draw_circle(round(x)-1, round(y)-1, grazeRadius - 6, 1)
draw_set_alpha(1)



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
				draw_sprite_ext(spr_player_tail, 0, p.x, p.y, tailSize / 64, tailSize / 64, 0, #3e2b32, 1)
			}
		}

	draw_sprite_ext(sprite_index, _img, round(x), round(y), 1 * dir_graphic == 0 ? 1 : sign(dir_graphic), 1, 0, c_white, 1)
	
	if sprite_index == spr_player_vee
		for (var i = 0; i < array_length(tails); i++) {
			for (var j = 0; j < array_length(tails[i]); j++) {
				var p = tails[i][j];
				var tailSize = max(parabola(-6, 10, 8, j) + 3, 6)
				draw_sprite_ext(spr_player_tail, 0, p.x, p.y, (tailSize-2) / 64, (tailSize-2) / 64, 0, #cc8297, 1)
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
	var _amount = 16;
	var _size = 6;
	for (var i = 0; i < round(_amount * hook_charge); i++) {
		draw_line_sprite(
			round(lifeChargeGraphicX) + lengthdir_x(_size, 360 / _amount / 2 * i - 90), 
			round(lifeChargeGraphicY) + lengthdir_y(_size, 360 / _amount / 2 * i - 90),
			round(lifeChargeGraphicX) + lengthdir_x(_size, 360 / _amount / 2 * (i + 1) - 90), 
			round(lifeChargeGraphicY) + lengthdir_y(_size, 360 / _amount / 2 * (i + 1) - 90),
			4, c_blue, 0.4
		);
		draw_line_sprite(
			round(lifeChargeGraphicX) + lengthdir_x(_size, 360 / _amount / 2 * -i - 90), 
			round(lifeChargeGraphicY) + lengthdir_y(_size, 360 / _amount / 2 * -i - 90),
			round(lifeChargeGraphicX) + lengthdir_x(_size, 360 / _amount / 2 * (-i - 1) - 90), 
			round(lifeChargeGraphicY) + lengthdir_y(_size, 360 / _amount / 2 * (-i - 1) - 90),
			4, c_blue, 0.4
		);
	}
//surface_reset_target()

draw_line_sprite(x, y, hook_x, hook_y, hook_line_showAnim.value * 4, c_white, 1);

if hook_ing {
	//draw_sprite(spr_playerHookAim, 0, x, y - 16);
}

//draw_surface(surf, 0, 0);