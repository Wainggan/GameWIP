currentSize = min(currentSize + sizeSpeed * global.delta_multi, targetSize);
if (currentSize >= targetSize) {
	instance_destroy()
}
var list = ds_list_create()
collision_circle_list(x, y, currentSize, obj_bullet, 0, 1, list, 0)
for (var i = 0; i < ds_list_size(list); i++) {
	var b = list[| i]
	var d = point_direction(x, y, b.x, b.y)
	particle.burst(b.x, b.y, "bulletExplosion", lengthdir_x(2, d), lengthdir_y(2, d))
	instance_destroy(b)
}
ds_list_destroy(list)
