squish = lerp(squish, 1, 1 - power(1 - 0.9999, global.delta_milliP * 2))

draw_sprite_ext(
	sprite_index,
	image_index,
	round(x + offsetX),
	round(y + offsetY),
	image_xscale * squish,
	image_yscale * (1 + (1 - squish)),
	image_angle,
	image_blend,
	image_alpha
)

