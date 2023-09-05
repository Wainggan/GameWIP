size += 24 * global.delta_multi
alpha = approach(alpha, 1, 0.1 * global.delta_multi)
if size > 512 {
	size2 += 48 * global.delta_multi
}
if size2 > point_distance(0, 0, WIDTH, HEIGHT) instance_destroy();