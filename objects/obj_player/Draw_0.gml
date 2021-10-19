draw_sprite(sprite_index, 0, x, y)

if keyboard_check(vk_shift) {
	slowHitboxAnim += slowHitboxAnimSpeed * global.delta_multi
} else {
	slowHitboxAnim -= slowHitboxAnimSpeed * global.delta_multi
}
slowHitboxAnim = clamp(slowHitboxAnim, 0, 1)

draw_sprite_ext(sprite_index, 1, x, y, 1, 1, 0, c_white, slowHitboxAnim)

