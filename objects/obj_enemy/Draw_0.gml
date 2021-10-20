hitAnim = approach(hitAnim, 0, hitAnimSpeed * global.delta_multi)

draw_sprite_ext(sprite_index, image_index, round(x), round(y), image_xscale+hitAnim, image_yscale+hitAnim, image_angle, image_blend, image_alpha)