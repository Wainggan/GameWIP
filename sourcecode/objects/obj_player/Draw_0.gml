

if inputSystem.check_pressed("sneak") {
	hitboxAnim.add(new Tween(0.2, 0, 1, function(_e){ hitboxSize = _e }, "backBig"))
} else if inputSystem.check_released("sneak") {
	hitboxAnim.add(new Tween(0.18, 1, 0, function(_e){ hitboxSize = _e }, "ease"))
}
hitboxAnim.update(global.delta_multi)

draw_sprite_ext(sprite_index, 0, round(x), round(y), 1, 1, 0, c_white, 1)

//draw_text(x + 10, y + 10, ( tReloadTime + 1 - power(min(grazeCombo + 1, 100), 0.2) ) - bulletCharge + 0)

//slowHitboxAnim = approach(slowHitboxAnim, inputSystem.check("sneak") ? 1 : 0, slowHitboxAnimSpeed * global.delta_multi)

//draw_sprite_ext(sprite_index, 1, round(x), round(y), 1, 1, 0, c_white, slowHitboxAnim)


draw_set_alpha(grazeHitboxGraphicShow)
	draw_circle(round(x)-1, round(y)-1, /*grazeRadius*/32, 1)
draw_set_alpha(1)

if sprite_index != spr_playerTest_sprite exit
array_foreach(tails, function(tail){
	tail.points_applyFunc(function(s, i){
		var tailSize = 4 * 2
		var tailFall = 10
		draw_sprite_ext(spr_player_tail, 0, s.x, s.y, (tailSize-i/tailFall) / 64, (tailSize-i/tailFall) / 64, 0, 0x281140, 1)
		//draw_circle(p.x, p.y, tailSize-i/tailFall, false)
	})

})
array_foreach(tails, function(tail){

	tail.points_applyFunc(function(s, i){
		var tailSize = 4 * 2
		var tailFall = 10 // 16

		draw_sprite_ext(spr_player_tail, 0, s.x, s.y, (tailSize-i/tailFall - 2) / 64, (tailSize-i/tailFall - 2) / 64, 0, 0x7a53d7, 1)
	})
})

draw_set_color(c_white)