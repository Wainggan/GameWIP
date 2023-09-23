hitAnim = approach(hitAnim, 0, 0.2 * global.delta_multi)

var _c = place_meeting(x, y, obj_player)

var _index = global.upgrades[$ type].index

if hitAnim != 0 {
	shader_set(shd_color)
	shader_set_uniform_f(shader_get_uniform(shd_color, "colorAmount"), hitAnim)
	shader_set_uniform_f(shader_get_uniform(shd_color, "colorTarget"), 1, 1, 1)
	draw_sprite_ext(spr_collectable_upgrade_base, _c, round(x), round(y), image_xscale + hitAnim/4, image_yscale + hitAnim/4, image_angle, image_blend, image_alpha)
	draw_sprite_ext(spr_collectable_upgrade_symbols, _index, round(x), round(y), image_xscale + hitAnim/4, image_yscale + hitAnim/4, image_angle, image_blend, image_alpha)
	shader_reset()
} else {
	draw_sprite_ext(spr_collectable_upgrade_base, _c, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	draw_sprite_ext(spr_collectable_upgrade_symbols, _index, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}