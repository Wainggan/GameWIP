

if input.check_pressed("sneak") {
	hitboxAnim.add(new Tween(0.25, 0, 1, function(_e){ hitboxSize = _e }, "backBig"))
} else if input.check_released("sneak") {
	hitboxAnim.add(new Tween(0.25, 1, 0, function(_e){ hitboxSize = _e }, "ease"))
}
hitboxAnim.update(global.delta_multi)

var _img = 0;
if abs(dir_graphic) <= slowMoveSpeed + 0.1 {
	if dir_graphic < 0 _img = 1;
	else if dir_graphic > 0 _img = 2;
} else {
	if dir_graphic < 0 _img = 3;
	else if dir_graphic > 0 _img = 4;
}

draw_sprite_ext(sprite_index, _img, round(x), round(y), 1 * dir_graphic == 0 ? 1 : sign(dir_graphic), 1, 0, c_white, 1)


draw_set_alpha(grazeHitboxGraphicShow)
	draw_circle(round(x)-1, round(y)-1, grazeRadius - 6, 1)
draw_set_alpha(1)

if sprite_index != spr_player_vee exit

for (var i = 0; i < array_length(tails); i++) {
	for (var j = 0; j < array_length(tails[i]); j++) {
		var p = tails[i][j];
		var tailSize = max(parabola(-6, 10, 8, j) + 3, 6)
		draw_sprite_ext(spr_player_tail, 0, p.x, p.y, tailSize / 64, tailSize / 64, 0, #3e2b32, 1)
	}
}

for (var i = 0; i < array_length(tails); i++) {
	for (var j = 0; j < array_length(tails[i]); j++) {
		var p = tails[i][j];
		var tailSize = max(parabola(-6, 10, 8, j) + 3, 6)
		draw_sprite_ext(spr_player_tail, 0, p.x, p.y, (tailSize-2) / 64, (tailSize-2) / 64, 0, #cc8297, 1)
	}
}

