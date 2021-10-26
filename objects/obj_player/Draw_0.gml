draw_sprite(sprite_index, 0, round(x), round(y))

slowHitboxAnim = approach(slowHitboxAnim, keyboard_check(vk_shift) ? 1 : 0, slowHitboxAnimSpeed * global.delta_multi)

draw_sprite_ext(sprite_index, 1, round(x), round(y), 1, 1, 0, c_white, slowHitboxAnim)


draw_set_alpha(grazeHitboxGraphicShow)
	draw_circle(round(x)-1, round(y)-1, /*grazeRadius*/32, 1)
draw_set_alpha(1)

/*
draw_text(x, y, string(grazeCombo))
draw_text(x, y+16, string( max( ( tReloadTime - (sqrt(grazeCombo) / 4) ) - bulletCharge, 3) ))
for (var i = 0; i < array_length(grazeBulletList); i++) {
	draw_text(x, y + 32 + i*16, string(grazeBulletList[i]))
}
*/