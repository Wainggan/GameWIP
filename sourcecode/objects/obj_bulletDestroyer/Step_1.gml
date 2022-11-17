if destroyAll && !fix {
	with obj_bullet {
		mask_index = spr_nothing
	}
	fix = true;
}

currentSize = min(currentSize + sizeSpeed * global.delta_multi, targetSize);
if (currentSize >= targetSize) {
	if destroyAll instance_destroy(obj_bullet);
	instance_destroy()
}
var list = ds_list_create()
collision_circle_list(x, y, currentSize, obj_bullet, 0, 1, list, 0)
for (var i = 0; i < ds_list_size(list); i++) {
	var b = list[| i]
	var d = point_direction(x, y, b.x, b.y)
	if b.object_index != obj_laser particle.burst(b.x, b.y, "bulletExplosion", lengthdir_x(2, d), lengthdir_y(2, d))
	if bulletBonus 
		if true || (-32 < b.x && b.x < WIDTH + 32 && -32 < b.y && b.y < HEIGHT + 32)
			with instance_create_layer(b.x, b.y, "Instances", obj_collectable) y_vel = -2
	instance_destroy(b)
}
ds_list_destroy(list)

