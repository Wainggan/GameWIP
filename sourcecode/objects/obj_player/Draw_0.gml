

if inputSystem.check_pressed("sneak") {
	hitboxAnim.add(new Tween(0.2, 0, 1, function(_e){ hitboxSize = _e }, "backBig"))
} else if inputSystem.check_released("sneak") {
	hitboxAnim.add(new Tween(0.18, 1, 0, function(_e){ hitboxSize = _e }, "ease"))
}
hitboxAnim.update(global.delta_multi)

show_debug_message(dir_graphic)

var _img = 0;
if dir_graphic < 0 _img = 2;
else if dir_graphic > 0 _img = 1;

draw_sprite_ext(sprite_index, _img, round(x), round(y), 1 * dir_graphic == 0 ? 1 : sign(dir_graphic), 1, 0, c_white, 1)

//draw_text(x + 10, y + 10, ( tReloadTime + 1 - power(min(grazeCombo + 1, 100), 0.2) ) - bulletCharge + 0)

//slowHitboxAnim = approach(slowHitboxAnim, inputSystem.check("sneak") ? 1 : 0, slowHitboxAnimSpeed * global.delta_multi)

//draw_sprite_ext(sprite_index, 1, round(x), round(y), 1, 1, 0, c_white, slowHitboxAnim)


draw_set_alpha(grazeHitboxGraphicShow)
	draw_circle(round(x)-1, round(y)-1, grazeRadius - 6, 1)
draw_set_alpha(1)

if sprite_index != spr_player_vee exit

for (var i = 0; i < array_length(tails); i++) {
	for (var j = 0; j < array_length(tails[i]); j++) {
		var p = tails[i][j];
		var tailSize = max(parabola(-6, 12, 8, j) + 3, 4)
		draw_sprite_ext(spr_player_tail, 0, p.x, p.y, tailSize / 64, tailSize / 64, 0, #3e2b32, 1)
	}
}

for (var i = 0; i < array_length(tails); i++) {
	for (var j = 0; j < array_length(tails[i]); j++) {
		var p = tails[i][j];
		var tailSize = max(parabola(-6, 12, 8, j) + 3, 4)
		draw_sprite_ext(spr_player_tail, 0, p.x, p.y, (tailSize-2) / 64, (tailSize-2) / 64, 0, #b8617c, 1)
	}
}


/*
array_foreach(tails, function(tail){
	tail.points_applyFunc(function(s, i){
		var tailSize = max(parabola(-7, 10, 7, i) + 3, 4)
		draw_sprite_ext(spr_player_tail, 0, s.x, s.y, tailSize / 64, tailSize / 64, 0, 0x281140, 1)
	})

})
array_foreach(tails, function(tail){
	tail.points_applyFunc(function(s, i){
		var tailSize = max(parabola(-7, 10, 7, i) + 3, 4)
		//if !s.soft
		draw_sprite_ext(spr_player_tail, 0, s.x, s.y, (tailSize - 2)/64, (tailSize - 2)/64, 0, 0x7a53d7, 1);
	})
})
